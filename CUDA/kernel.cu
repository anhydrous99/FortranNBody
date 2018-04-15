#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <math.h>

__device__ double G = 6.673e-11;

__global__ void inner_cal_ef0(double pos1x, double pos1y, double pos1z, double m1 , double *mass, double *posx, double *posy, double *posz, double *forx, double *fory, double *forz, int i)
{
    int j = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i != j )
    {
        double pos2x = posx[j],
	       pos2y = posy[j],
	       pos2z = posz[j];
	double m2 = mass[j];
	double relposx, relposy, relposz;
	double univecx, univecy, univecz;
	double magpos2, magpos;
	relposx = pos1x - pos2x;
	relposy = pos1y - pos2y;
	relposz = pos1z - pos2z;
	magpos2 = relposx * relposx + relposy * relposy + relposz * relposz;
	magpos  = sqrt(magpos2);
	univecx = relposx / magpos;
	univecy = relposy / magpos;
	univecz = relposz / magpos;
	magpos  = - G * m1 * m2 / magpos2;
	forx[i] += magpos * univecx;
	fory[i] += magpos * univecy;
	forz[i] += magpos * univecz;
    }
}

// simple kernel function that adds two vectors
__global__ void calculate(double *mass, double *posx, double *posy, double *posz, double *forx, double *fory, double *forz, int ef_type, double ef_mass, int N)
{
    if ( N == 1 )
    {
        if ( ef_type == 1 )
        {
	    double m = mass[0];
            double relposx = posx[0], relposy = posy[0], relposz = posz[0];
	    double univecx, univecy, univecz;
	    double magpos2, magpos;
	    magpos2 = relposx * relposx + relposy * relposy + relposz * relposz;
	    magpos = sqrt(magpos2);
	    univecx = relposx / magpos;
	    univecy = relposy / magpos;
	    univecz = relposz / magpos;
	    magpos = - G * ef_mass * m / magpos2;
	    forx[0] = magpos * univecx;
	    fory[0] = magpos * univecy;
	    forz[0] = magpos * univecz;
	}
    }
    else
    {
	    int i = threadIdx.x + blockIdx.x * blockDim.x;
	    int blocks = 1;
	    double pos1x = posx[i], pos1y = posy[i], pos1z = posz[i];
	    double m1 = mass[i];
	    inner_cal_ef0<<< blocks, N >>>(pos1x, pos1y, pos1z, m1, mass, posx, posy, posz, forx, fory, forz, i);
	    cudaDeviceSynchronize();
    }
}
// function called from main fortran program
extern "C" void KERNEL_WRAPPER(int *ef_type_p, double *ef_mass_p, int *N_p, double *mass, double *posx, double *posy, double *posz, double *forx, double *fory, double *forz)
{
    double *mass_d; // declare GPU vector copies
    double *posx_d, *posy_d, *posz_d;
    double *forx_d, *fory_d, *forz_d;

    int blocks = 1;
    int ef_type = *ef_type_p;
    double ef_mass = *ef_mass_p;
    int N = *N_p;

    // Allocate memory on GPU
    cudaMalloc( (void **)&mass_d, sizeof(double) * N );
    cudaMalloc( (void **)&posx_d, sizeof(double) * N );
    cudaMalloc( (void **)&posy_d, sizeof(double) * N );
    cudaMalloc( (void **)&posz_d, sizeof(double) * N );
    cudaMalloc( (void **)&forx_d, sizeof(double) * N );
    cudaMalloc( (void **)&fory_d, sizeof(double) * N );
    cudaMalloc( (void **)&forz_d, sizeof(double) * N );

    // copy vectors from CPU to GPU
    cudaMemcpy( mass_d, mass, sizeof(double) * N, cudaMemcpyHostToDevice );
    cudaMemcpy( posx_d, posx, sizeof(double) * N, cudaMemcpyHostToDevice );
    cudaMemcpy( posy_d, posy, sizeof(double) * N, cudaMemcpyHostToDevice );
    cudaMemcpy( posz_d, posz, sizeof(double) * N, cudaMemcpyHostToDevice );
    cudaMemcpy( forx_d, forx, sizeof(double) * N, cudaMemcpyHostToDevice );
    cudaMemcpy( fory_d, fory, sizeof(double) * N, cudaMemcpyHostToDevice );
    cudaMemcpy( forz_d, forz, sizeof(double) * N, cudaMemcpyHostToDevice );

    // call function on GPU
    calculate<<< blocks, N >>>(mass_d, posx_d, posy_d, posz_d, forx_d, fory_d, forz_d, ef_type, ef_mass, N);

    cudaDeviceSynchronize();

    // copy vectors back from GPU to CPU
    cudaMemcpy( forx, forx_d, sizeof(double) * N, cudaMemcpyDeviceToHost );
    cudaMemcpy( fory, fory_d, sizeof(double) * N, cudaMemcpyDeviceToHost );
    cudaMemcpy( forz, forz_d, sizeof(double) * N, cudaMemcpyDeviceToHost );

    // free GPU memory
    cudaFree(mass_d);
    cudaFree(posx_d);
    cudaFree(posy_d);
    cudaFree(posz_d);
    cudaFree(forx_d);
    cudaFree(fory_d);
    cudaFree(forz_d);
    return;
}

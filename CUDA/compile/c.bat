@echo off
nvcc -arch=sm_35 -rdc=true -c ..\kernel.cu
nvcc -arch=sm_35 -dlink -o link_kernel.obj kernel.obj -lcudadevrt -lcudart
ifort /Fe:CNBodySim link_kernel.obj kernel.obj ..\..\modules\mod_numeric.f90 ..\..\modules\mod_math.f90 ..\..\modules\mod_astronomy.f90 ..\calcforces.f90 ..\..\fimport.f90 ..\..\evolve.f90 ..\..\runNBody.f90 /include:"C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v7.5\include" /link /libpath:"C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v7.5\lib\x64" cudart.lib cuda.lib cudadevrt.lib
del *.mod >nul 2>&1
del *.obj <nul 2>&1
del *.pdb >nul 2>&1
del *.*~  >nul 2>&1

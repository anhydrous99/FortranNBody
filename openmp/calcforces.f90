! This subroutine calculates both the internal and external forces
!
subroutine calcforces(ef_type, ef_mass, N, mass, pos, forces)
!
! Use Statements
!
use mod_numeric, only: int_kind, & ! kind for Integer vars
                       real_kind   ! kind for Real vars
use mod_math, only: zero, &        ! Number zero
                    one            ! Number one  
!
! G: Universal Gravitational Constant(MKS)
! msun: Mass of Sun in kg
!
use mod_astronomy, only: G, & 
                         msun
!
! Implicit Statement
!
implicit none
!
! Internal Functions
!
intrinsic sqrt, dot_product
!
! Declaration Statements
!
! Input Variables
!
! ef_type : 0 - no external force
!           1 - point mass at origin
!
integer(kind=int_kind), intent(in) :: ef_type
!
! Mass of Point Mass if ef_type = 1
!
real(kind=real_kind), intent(in)   :: ef_mass
!
! Number of point masses
!
integer(kind=int_kind), intent(in) :: N
!
! Mass of point masses
!
real(kind=real_kind), intent(in)   :: mass(1:N)
!
! Position of point masses in meters
!
real(kind=real_kind), intent(in)   :: pos(1:3,1:N)
!
! Output Variables
!
real(kind=real_kind), intent(out)  :: forces(1:3,1:N)
!
! Local Arrays
!
real(kind=real_kind) :: position1(1:3), &
                        position2(1:3), &
                        relpos(1:3), &
                        univec(1:3)
!
! Local Variables
!
integer(kind=int_kind) :: i, j
real(kind=real_kind)   :: magpos, magpos2, magfor
!
! Begin Implementation
!
! Calculate External Forces
!
    if (ef_type == 0) then
        forces = zero
    else if (ef_type == 1) then
        do i = 1, N
            relpos  = pos(1:3,i)
            magpos2 = dot_product(relpos,relpos)
            magpos  = sqrt(magpos2)
            univec  = relpos / magpos
            forces(1:3,i) = - G * ef_mass * mass(i) &
                            / magpos2 * univec
        end do
    else
        write(*,*) 'calcforces: ef_type = ', ef_type
        write(*,*) ' not implemented.'
        write(*,*) ' Exiting.'
        stop
    end if
! 
! Calculate Internal Forces
!
    !$omp parallel &
    !$omp   private( position1, position2, relpos, i, j, magpos2, magpos, univec ) &
    !$omp   shared ( N, pos, forces )
    !$omp do
    do i = 1, N
        position1(1:3) = pos(1:3,i)
        do j = 1, N
            if (j == i) cycle
            position2(1:3) = pos(1:3,j)
            relpos = position1 - position2
            magpos2 = dot_product(relpos,relpos)
            magpos  = sqrt(magpos2)
            univec  = relpos / magpos
            forces(1:3,i) =   forces(1:3,i) &
                              - G * mass(i) * mass(j) &
                              / magpos2 * univec
        end do
    end do
    !$omp end do
    !$omp end parallel
    return
end subroutine calcforces

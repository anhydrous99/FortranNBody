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
! G: Universal Gravitational Constant (MKS)
! msun: Mass of sun in kg
!
use mod_astronomy, only: G, &
                         msun
!
! Implicit Statement
!
implicit none
!
! External
!
external kernel_wrapper
!
! Declaration Statements
!
! Input Variables
!
! ef_type : 0 - no external forces
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
! Local Arrays/Variables
!
real(kind=real_kind) :: posx(1:N), posy(1:N), posz(1:N)
real(kind=real_kind) :: forx(1:N), fory(1:N), forz(1:N)
!
! Begin Implementation
!
! Calculate Forces
!
    forces = zero       
    forx   = zero
    fory   = zero
    forz   = zero
    posx = pos(1,1:N)
    posy = pos(2,1:N)
    posz = pos(3,1:N)
    call KERNEL_WRAPPER(ef_type, ef_mass, N, mass, posx, posy, posz, &
                        forx, fory, forz)
    forces(1,1:N) = forx
    forces(2,1:N) = fory
    forces(3,1:N) = forz
    return
end subroutine calcforces

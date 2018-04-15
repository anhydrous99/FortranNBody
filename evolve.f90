! This subroutine Calculates the new Positions and Velocity of
!     point mass after TimeStep
!
subroutine evolve(ef_type, ef_mass, &
                  deltat, N, mass, pos, vel, forces, accel)
!
! Use Statements
!
use mod_numeric,   only: int_kind, & ! kind for Integer vars
                       real_kind     ! kind for Real vars
!
use mod_math,      only: two         ! Number two
!
use mod_astronomy, only: G           ! Universal Gravitational Constant
                                     ! in (MKS)
!
! Implicit Statement
!
implicit none
!
! External subroutines
!
external calcforces
!
! Input Variables
!
! ef_type         : 0 - no external force
!                   1 - point mass at origin
!
integer(kind=int_kind), intent(in) :: ef_type
!
! Mass of Point Mass if ef_type = 1
!
real(kind=real_kind), intent(in)   :: ef_mass
!
! Time step in seconds
!
real(kind=real_kind), intent(in)    :: deltat
!
! Number of point masses
!
integer(kind=int_kind), intent(in)  :: N
!
! Mass of point masses
!
real(kind=real_kind), intent(in)    :: mass(1:N)
! 
! input output variables
!
! Position of point masses in meters
! Velocity of point masses in meters per second
!
real(kind=real_kind), intent(inout) :: pos(1:3,1:N), &
                                       vel(1:3,1:N)
!
! Total Forces acting on objects
! Acceleration of objects
!
real(kind=real_kind), intent(out) :: forces(1:3,1:N), &
                                     accel(1:3,1:N)
!
! Local Variables
!
integer(kind=int_kind) :: i
!
! Begin Implementation
!
! Calculate Forces on each point mass
!
    call calcforces(ef_type, ef_mass, &
                    N, mass, pos, forces)
!
! Calculate Acceleration
!
    do i = 1, N
        accel(1:3,i) = forces(1:3,i) / mass(i)
    end do
!
! Calculate Position
!
    pos = pos + deltat * vel + (deltat * deltat) * accel / two
!
! Calculate Velocity
!
    vel = vel + deltat * accel
    return
end subroutine evolve

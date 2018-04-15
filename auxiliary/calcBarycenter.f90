!
! Calculate Barycenter in terms of distance from sun in meters
!
subroutine calcBarycenter(pos, mass, N, baryCenter)
!
! Use Statements
!
use mod_numeric, only: int_kind, & ! kind for Integer vars
                       real_kind   ! kind for Real vars
!
! Implicit None
!
implicit none
!
! Declaration Statements
!
! Input Variables
!
integer(kind=int_kind), intent(in) :: N
real(kind=real_kind), intent(in)   :: pos(1:3,1:N)
real(kind=real_kind), intent(in)   :: mass(1:N)
!
! Output Variables
!
real(kind=real_kind), intent(out)  :: baryCenter(1:3)
!
! Local Variables
!
integer(kind=int_kind) :: i
real(kind=real_kind) :: mr(1:3), m
real(kind=real_kind) :: sunpos(1:3), baryC(1:3)
!
! Begin Implementation
!
    mr = 0
    m  = 0
    sunpos = pos(1:3,1)
    do i = 1, N
        mr = mr + mass(i) * pos(1:3,i)
        m = m + mass(i)
    end do
    baryC = mr / m
    baryCenter = sunpos - baryC
    return
end subroutine calcBarycenter

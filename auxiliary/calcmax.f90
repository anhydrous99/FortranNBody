subroutine calcmax(pos, maxpos, ymax)
!
! Use Statement
!
use mod_numeric, only: real_kind ! kind for Real vars
!
! Implicit Statements
!
implicit none
!
! Internal Functions
!
intrinsic sqrt, dot_product, max
!
! Declaration Statements
! Input Variables
!
real(kind=real_kind), intent(in) :: pos(1:3)
!
! Input/Output Variables
!
real(kind=real_kind), intent(inout) :: maxpos, &
                                       ymax
!
! Local Variables
!
real(kind=real_kind) :: magpos_sqr, magpos
!
! Beginning Implementation
!
    magpos_sqr = dot_product(pos(1:3), pos(1:3))
    magpos = sqrt(magpos_sqr)
    maxpos = max(magpos, maxpos)
    ymax   = max(pos(2),ymax)
    return
end subroutine calcmax

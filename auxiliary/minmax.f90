subroutine minmax(pos, minpos, maxpos)
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
intrinsic sqrt, dot_product, min, max
!
! Declaration Statements
! Input Variables
!
real(kind=real_kind), intent(in) :: pos(1:3)
!
! Input/Output Variables
!
real(kind=real_kind), intent(inout) :: minpos, maxpos
!
! Local Variables
!
real(kind=real_kind) :: magpos_sqr, magpos
!
! Beginning Implementation
!
    magpos_sqr = dot_product(pos(1:3), pos(1:3))
    magpos = sqrt(magpos_sqr)
    minpos = min(magpos, minpos)
    maxpos = max(magpos, maxpos)
    return
end subroutine minmax

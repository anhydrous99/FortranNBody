! This subroutine exports body data to file
!
subroutine fexport(nunit, time, N, mass, pos, vel)
!
! Use Statements
!
use mod_numeric, only: int_kind, & ! kind for Integer vars
                       real_kind   ! kind for Real vars
!
! Implicit Statement
!
implicit none
!
! Declaration Statement
!
integer(kind=int_kind), intent(in) :: nunit, &
                                      N
real(kind=real_kind), intent(in)   :: time,         &
                                      mass(1:N),    &
                                      pos(1:3,1:N), &
                                      vel(1:3,1:N)
!
! Local Variables
!
integer(kind=int_kind) :: i
!
! Begin Implementation
!
    write(nunit,*) 't:(',time,')'
    do i = 1, N
        write(nunit,*) 'i:(',i,')'
        write(nunit,*) 'm:(',mass(i),')'
        write(nunit,*) 'p(',pos(1:3,i),')'
        write(nunit,*) 'v(',vel(1:3,i),')'
    end do
    write(nunit,*)
    return
end subroutine fexport

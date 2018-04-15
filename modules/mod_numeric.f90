! This module contains numerical constants
module mod_numeric
!
! Implicit Statement
!
implicit none
!
! Public Statement
!
public
!
! Declaration Statements
!
    integer(kind=4), parameter :: int_kind  = 4 ! kind for Integer vars
    integer(kind=4), parameter :: real_kind = 8 ! kind for Real vars
    real(kind=8),    parameter :: max_general = 1.7D308
    real(kind=8),    parameter :: min_general = -1.7D308
end module mod_numeric

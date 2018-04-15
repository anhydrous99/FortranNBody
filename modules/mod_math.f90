! This module holds Mathematical constants
!
module mod_math
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
! Public Statement
!
public
!
! Declaration Statements
!
    real(kind=real_kind), parameter :: zero = 0D0 ! Number Zero
    real(kind=real_kind), parameter :: one  = 1D0 ! Number One
    real(kind=real_kind), parameter :: two  = 2D0 ! Number Two
    real(kind=real_kind), parameter :: onehundred  = 1D2 ! Number 100
    real(kind=real_kind), parameter :: onethousand = 1D3 ! Number 1000
!
end module mod_math

! This module holds Astronomy Constants
!
module mod_astronomy
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
! Universal Gravitational Constant G taken from
! Allen's Astrophysical Quantities Fourth Edition (2000)
! in MKS Units
!   real value
!    real(kind=real_kind), parameter :: G = 6.673D-11
    real(kind=real_kind), parameter :: G = 6.671D-11
!
! Mass of the Sun in kg taken from
! Allen's Astrophysical Quantities Fourth Edition (2000)
!
    real(kind=real_kind), parameter :: msun = 1.9891D30
!
! mass of earth in kg taken from
! Allen's Astrophysical Quantities Fourth Edition (2000)
!
    real(kind=real_kind), parameter :: mearth = 5.9742D24
!
! Astronomical Units in meters taken from
! Allen's Astrophysical Quantities Fourth Edition (2000)
!
    real(kind=real_kind), parameter :: AU = 1.4959787066D11
!
! Radius of the sun in meters taken from
! Allen's Astrophysical Quantities Fourth Edition (2000)
!
    real(kind=real_kind), parameter :: rsun = 6.955D08
!
! Other Units ------------
!
! Kilometers
!
    real(kind=real_kind), parameter :: km = 1D3
!
! Megameters
!
    real(kind=real_kind), parameter :: Megam = 1D6
!
! Kilometer per Second
!
    real(kind=real_kind), parameter :: KPS  = 1D3
!
! Centimeters per Second
!
    real(kind=real_kind), parameter :: CMPS = 1D-2
!
! a Day in seconds
!
    real(kind=real_kind), parameter :: day = 86400D0
!
! an Hour in seconds
!
    real(kind=real_kind), parameter :: hour = 3600d0
!
! an Minute in seconds
!
    real(kind=real_kind), parameter :: minute = 60d0
end module mod_astronomy

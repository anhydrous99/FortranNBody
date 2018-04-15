! This subroutine imports body data from file
!
subroutine fimport(nunit_particle, N, mass, pos, vel)
!
! Use Statements
!
use mod_numeric,   only: int_kind, & ! kind for Integer vars
                         real_kind   ! kind for Real vars
use mod_math,      only: onethousand ! Number 1000
use mod_astronomy, only: AU, &       ! Astronomical Units
                         day
!
! Implicit Statement
!
implicit none
!
! Declaration Statement
! In Variables
!
integer(kind=int_kind), intent(in) :: nunit_particle
integer(kind=int_kind), intent(in) :: N
!
! Out Variables
!
real(kind=real_kind), intent(out) :: mass(1:N)
real(kind=real_kind), intent(out) :: pos(1:3,1:N), &
                                     vel(1:3,1:N)
!
! Local Variables
!
integer(kind=int_kind) :: Nin
integer(kind=int_kind) :: i, i_Object
!
! Begin Implementation
!
    open(unit=nunit_particle, file='data_particles.t')
    read(nunit_particle,*) Nin
    if (Nin < N) then
        write(*,*) 'fimport: Number of Objects in data_particles.txt'
        write(*,*) ' is less than Number of Objects specified.'
        write(*,*) ' Exiting.'
        stop
    end if
    do i = 1, N
        read(nunit_particle,*) i_Object
        if (i /= i_Object) then
            write(*,*) 'fimport: Invalid Object Numbers.'
            write(*,*) ' Exiting.'
            stop
        end if
        read(nunit_particle,*) mass(i)
        read(nunit_particle,*) pos(1,i), pos(2,i), pos(3,i)
        read(nunit_particle,*) vel(1,i), vel(2,i), vel(3,i)
    end do
    close(nunit_particle)
    return
end subroutine

! File format (example data.txt)
!--------------------------------
!Number of Objects
!1
!m
!x,y,z
!vx,vy,vz
!2
!m
!x,y,z
!vx,vy,vz
!...
!--------------------------------
! # - Point Mass Number
! m - Mass in kilograms
! x - x position
! y - y position
! z - z position
! vx - x velocity
! vy - y velocity
! vz - z velocity
! Position units - (_AU, __M, _KM)
! Velocity units - (APD, MPS, KPS)
! APD - Astronomical Units per Day
! MPS - Meters per second
! KPS - Kilometers per second
! Mass     units - (_KG, __G)
!
!
! not including ---

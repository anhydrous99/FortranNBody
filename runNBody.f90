program runNBody
!
! Use Statements
!
use mod_numeric, only: int_kind, & ! kind for Integer vars
                       real_kind   ! kind for Real vars
!
use mod_math, only: zero, &        ! Number 0
                    onethousand
!
use mod_astronomy, only: day, &    ! A day in Seconds
                         AU,  &    ! A Astronomical Unit in meters
                         KPS, &    ! A km/s in m/s
                         CMPS, &
                         rsun
!
! Implicit Statement
!
implicit none
!
! External Subroutines
!
external fimport, evolve
!
! Maximum number of particles allowed
!
integer(kind=int_kind), parameter :: Nmax = 999
!
! Declaration Statements
!
! Local Arrays/Variables
!
! Input/Output units
!
integer(kind=int_kind), parameter :: nunit_indata = 1,   &
                                     nunit_particle = 2, &
                                     nunit_history = 3
integer(kind=int_kind), parameter :: nunit_outdata = 4
!
! ef_type          : 0 - no external force
!                    1 - point mass at origin
!
integer(kind=int_kind) :: ef_type
!
! ef_mass : Mass of Point Mass if ef_type = 1
!
real(kind=real_kind)   :: ef_mass
!
! deltat :  Size of Time Steps (s)
!
real(kind=real_kind)   :: deltat
!
! nTimeSteps   : Number of TimeSteps
! N            : Number of Objects
! file_steps   : # of Steps between file outputs
! scrn_steps   : # of Steps between screen outputs
!
integer(kind=int_kind) :: nTimeSteps, &
                          N,          &
                          file_steps, &
                          scrn_steps
!
! Mass of Objects
!
real(kind=real_kind)   :: mass(1:Nmax)
!
! pos : Position of Objects
! vel : Velocity of Objects
!
real(kind=real_kind)   :: pos(1:3,1:Nmax), &
                          vel(1:3,1:Nmax)
!
! Total Forces acting on objects
! Acceleration of objects
!
real(kind=real_kind)   :: forces(1:3,1:Nmax), &
                          accel(1:3,1:Nmax)
!
! time : Total Time
!
real(kind=real_kind)   :: time
integer(kind=int_kind) :: i, j, k
!
! Begin Implementation
!
! Check if Nmax value is supported
!
    if (Nmax > 999) then
            write(*,*) ' Values greater than 999 for Nmax have not' // &
                       ' been implemented.'
            write(*,*) ' Exiting.'
            stop
    end if
!
! Initialize Time
!
    time = zero
!
! Open File 'indata.txt'
! File contains Important Information
!
    open( unit = nunit_indata, file = 'indata.t', &
          form='formatted', status='old')
!
! Read N : Number of Objects
!
    read(nunit_indata,*) N
!
! Read nTimeSteps : Number of TimeSteps
!
    read(nunit_indata,*) nTimeSteps
!
! Read deltat : Change in Time
!
    read(nunit_indata,*) deltat
!
! Read file_steps : # of Steps between file outputs
!
    read(nunit_indata,*) file_steps
!
! Read scrn_steps : # of Steps between screen outputs
!
    read(nunit_indata,*) scrn_steps
!
! Read ef_type
!
    read(nunit_indata,*) ef_type
    read(nunit_indata,*)
!
!  Read ef_mass
!
    read(nunit_indata,*) ef_mass
!
! Close File 'indata.txt
!
    close(nunit_indata)
!
! Write to history file the input data
!
    open( unit = nunit_history, file = 'histdata.txt', &
          form='formatted', status='unknown')
    write(nunit_history,*) 'N               = ', N
    write(nunit_history,*) 'nTimeSteps      = ', nTimeSteps
    write(nunit_history,*) 'deltat          = ', deltat
    write(nunit_history,*) 'file_steps      = ', file_steps
    write(nunit_history,*) 'screen_steps    = ', scrn_steps
    write(nunit_history,*) 'ext. force type = ', ef_type
    write(nunit_history,*) 'ext. mass       = ', ef_mass
    write(nunit_history,*)
    close(nunit_history)
!
! Opens file 'data_particles.txt'
!  and using, nunit_particle and N,
!  gets: (mass: Mass of Object
!         pos : Position of Object
!         vel : Velocity of Object
!
    call fimport(nunit_particle, N, mass, pos, vel)
    open(unit = nunit_outdata, file = 'outdata.txt', &
            form = 'formatted', status = 'unknown')
    write(nunit_outdata,*) 'n:(',n,')'
    call fexport(nunit_outdata, time, N, mass, pos, vel)
!
    do i = 1, nTimeSteps
!
! This Subroutine progresses time 1 * deltat
!
        call evolve(ef_type, ef_mass, &
                    deltat, N, mass, pos, vel, forces, accel)
!
! Calculates time after deltat
!
        time = time + deltat
!
! Prints out status to file every file_steps
!
        if(i/file_steps*file_steps == i) then
                call fexport(nunit_outdata, time, N, mass, pos, vel)
        end if
!
! Prints out status to screen every scrn_steps
!
        if(i/scrn_steps*scrn_steps == i) then
            write(*,"('time=  ', ES21.13, ' Seconds')") time
        end if
!
    end do
    close(nunit_outdata)
    stop
!    1 format(1f6.2, 3f11.7,3f11.6)
    1 format(7ES10.2)
end program runNBody

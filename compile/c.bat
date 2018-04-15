@echo off
ifort /fast /Fe:NBodySim ..\modules\mod_numeric.f90 ..\modules\mod_math.f90 ..\modules\mod_astronomy.f90  ..\fimport.f90 ..\fexport.f90 ..\calcforces.f90 ..\evolve.f90 ..\runNBody.f90
clean.bat
NBodySim.exe

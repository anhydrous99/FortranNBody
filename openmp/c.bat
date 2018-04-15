@echo off
ifort /fast /Qopenmp /Fe:NBodySim ..\modules\mod_numeric.f90 ..\modules\mod_math.f90 ..\modules\mod_astronomy.f90 ..\auxiliary\calcBarycenter.f90 ..\fimport.f90 calcforces.f90 ..\evolve.f90 ..\runNBody.f90
del *.obj *.mod

@echo off
ifort /fpe:0 /Fe:NBodySim /debug:all /traceback /check:all  ..\modules\mod_numeric.f90 ..\modules\mod_math.f90 ..\modules\mod_astronomy.f90 ..\auxiliary\calcBarycenter.f90 ..\fimport.f90 ..\calcforces.f90 ..\evolve.f90 ..\runNBody.f90

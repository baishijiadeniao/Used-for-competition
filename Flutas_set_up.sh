#!/bin/bash

# Edit FC name and FFTW path in targets/target.generic-intel.

# MPI=intelmpi-2021.7.0
MPI=openmpi-4.1.2-intel2021.4.0
if [[ "$MPI" =~ ^intel ]]; then
        module load intel/2021.7.0
        module load fftw/3.3.10-intel2021.7.0-impi
        export I_MPI_F90=ifort
elif [[ "$MPI" =~ ^openmpi ]]; then
        module load fftw/3.3.10-ompi
        export OMPI_MPIF90=ifort
fi
module load $(echo $MPI | sed -e "s/\-/\//")

make ARCH=generic-intel APP=two_phase_ht DO_DBG=0 DO_POSTPROC=0

export LD_LIBRARY_PATH=/home/hpc/b154dc/b154dc19/FluTAS/fftw/lib:$LD_LIBRARY_PATH
export CPATH=/home/hpc/b154dc/b154dc19/FluTAS/fftw/include:$CPATH
export PATH=/home/hpc/b154dc/b154dc19/FluTAS/fftw/bin:$PATH
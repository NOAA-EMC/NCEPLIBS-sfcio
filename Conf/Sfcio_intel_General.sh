# *** manually set environments (for intel compiler) of sfcio ***

 : ${USERMODE:=false}  # user mode (USERMODE) is closed by default
                       # set env var USERMODE to "true" to active it
 ${USERMODE} && {
    echo "Environment set by user"
# On theia/cray, user can load environment
#   module load intel/18.0.1.163
# Or set environment on specific platform
    intel_version=2018.1.163
    intel_topdir=/apps/intel/compilers_and_libraries_$intel_version
    source $intel_topdir/linux/bin/compilervars.sh intel64
 }

 ANCHORDIR=..
 export COMP=ips
 export SFCIO_VER=v1.1.0
 export SFCIO_SRC=
 export SFCIO_INC4=$ANCHORDIR/include/sfcio_${SFCIO_VER}_4
 export SFCIO_LIB4=$ANCHORDIR/libsfcio_${SFCIO_VER}_4.a

 export CC=icc
 export FC=ifort
 export CPP=cpp
 export OMPCC="$CC -qopenmp"
 export OMPFC="$FC -qopenmp"
 export MPICC=mpiicc
 export MPIFC=mpiifort

 export DEBUG="-g -traceback -O0"
 export CFLAGS="-g -traceback -O3 -fPIC"
 export FFLAGS="-g -traceback -O3 -convert big_endian -assume byterecl -fPIC"
 export FPPCPP="-cpp"
 export FREEFORM="-free"
 export CPPFLAGS="-P -traditional-cpp"
 export MPICFLAGS="-g -traceback -O3 -fPIC"
 export MPIFFLAGS="-g -traceback -O3 -fPIC"
 export MODPATH="-module "
 export I4R4="-integer-size 32 -real-size 32"
 export I4R8="-integer-size 32 -real-size 64"
 export I8R8="-integer-size 64 -real-size 64"

 export CPPDEFS=""
 export CFLAGSDEFS="-DUNDERSCORE -DLINUX"
 export FFLAGSDEFS=""

 export USECC=""
 export USEFC="YES"
 export DEPS=""

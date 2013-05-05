#!/bin/sh
###############################################################################
#
# $Id$
#
# Script to configure, build, and install the library.
#
# The build configuration setup (compiler, compiler switched, libraries, etc)
# is specified via files in the config-setup/ subdirectory that are sourced
# within this script.
#
# The installation directory is ${PWD}
#
###############################################################################

usage()
{
  echo
  echo " Usage: make_sfcio_lib.sh [-g|-h] setup-file"
  echo
  echo "   Script to iterate the configuration script over the set of precision"
  echo "   versions of the library."
  echo
  echo '   The installation directory is ${PWD}'
  echo
  echo " Options:"
  echo "   -g          Perform a Gnu-style install into include/ and lib/ directories"
  echo "               The default is an NCO-style install to reflect the structure"
  echo "               of /nwprod/lib"
  echo
  echo "   -h          Print this message and exit"
  echo
  echo " Arguments:"
  echo '   setup-file  File, in the "config-setup/" subdirectory, that contains'
  echo "               the build configuration setup (compiler, compiler switches,"
  echo "               libraries, etc) that are sourced within this script."
  echo
  echo "               Currently available setup files are:"
  for file in `ls ./config-setup/`; do
    echo "     `basename ${file}`" >&2
  done
  echo
}


# Setup
# ...Definitions
SCRIPT_NAME=$(basename $0)
SUCCESS=0
FAILURE=1
# ...Defaults
INSTALL_TYPE="nco"


# Parse the command line options
while getopts :gh OPTVAL; do
  # Exit if option argument looks like another option
  case ${OPTARG} in
    -*) break;;
  esac
  # Parse the valid options
  case ${OPTVAL} in
    g) INSTALL_TYPE="gnu";;
    h)  usage
        exit ${SUCCESS};;
    :|\?) OPTVAL=${OPTARG}
          break;;
  esac
done
# ...Remove the options processed
shift $(expr ${OPTIND} - 1)
# ...Output invalidities based on OPTVAL
case ${OPTVAL} in
  # If OPTVAL contains nothing, then all options
  # have been successfully parsed and all that
  # remains are the arguments
  \?) if [ $# -lt 1 ]; then
        echo; echo "${SCRIPT_NAME}: ERROR - Missing build setup argument"
        usage
        exit ${FAILURE}
      fi;;
  # Invalid option
  ?) echo "${SCRIPT_NAME}: ERROR - Invalid option '-${OPTARG}'"
     usage
     exit ${FAILURE};;
esac


# Source the build setup
SETUP_FILE="./config-setup/$1"
if [ ! -f ${SETUP_FILE} ]; then
  echo "${SCRIPT_NAME}: ERROR - Cannot find specified setup file ${SETUP_FILE}" >&2
  exit ${FAILURE}
fi
. ${SETUP_FILE}


# Generate the makefiles
echo; echo; echo; echo
echo "==============================================================="
echo "==============================================================="
echo "Configuring for build"
echo "==============================================================="
echo "==============================================================="
echo
./configure --prefix=${PWD}
if [ $? -ne 0 ]; then
  echo "${SCRIPT_NAME}: Error configuring for build" >&2
  exit 1
fi

# Build the current configuration
echo; echo
echo "==============================================================="
echo "Starting build"
echo "==============================================================="
echo
make clean
make
if [ $? -ne 0 ]; then
  echo "${SCRIPT_NAME}: Error building" >&2
  exit 1
fi

# Install the current build...
if [ "${INSTALL_TYPE}" = "nco" ]; then
  echo; echo
  echo "==============================================================="
  echo "Performing NCO-type install"
  echo "==============================================================="
  echo
  make nco_install
  if [ $? -ne 0 ]; then
    echo "${SCRIPT_NAME}: ERROR in NCO-style installation" >&2
    exit ${FAILURE}
  fi
else
  echo; echo
  echo "==============================================================="
  echo "Performing GNU-type install"
  echo "==============================================================="
  echo
  make install
  if [ $? -ne 0 ]; then
    echo "${SCRIPT_NAME}: ERROR in Gnu-style installation" >&2
    exit ${FAILURE}
  fi
fi

# Clean up
make distclean

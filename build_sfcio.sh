#!/bin/sh

 : ${THISDIR:=$(dirname $(readlink -f -n ${BASH_SOURCE[0]}))}
 CDIR=$PWD; cd $THISDIR

 source ./Conf/Analyse_args.sh
 source ./Conf/Collect_info.sh
 source ./Conf/Gen_cfunction.sh
 source ./Conf/Reset_version.sh

 if [[ ${sys} == "intel_general" ]]; then
   sys6=${sys:6}
   source ./Conf/Sfcio_${sys:0:5}_${sys6^}.sh
 elif [[ ${sys} == "gnu_general" ]]; then
   sys4=${sys:4}
   source ./Conf/Sfcio_${sys:0:3}_${sys4^}.sh
 else
   source ./Conf/Sfcio_intel_${sys^}.sh
 fi
 $CC --version &> /dev/null || {
   echo "??? SFCIO: compilers not set." >&2
   exit 1
 }
 [[ -z $SFCIO_VER || -z $SFCIO_LIB4 ]] && {
   echo "??? SFCIO: module/environment not set." >&2
   exit 1
 }

set -x
 sfcioLib4=$(basename ${SFCIO_LIB4})
 sfcioInc4=$(basename ${SFCIO_INC4})

#################
 cd src
#################

 $skip || {
#-------------------------------------------------------------------
# Start building libraries
#
 echo
 echo "   ... build default (i4/r4) sfcio library ..."
 echo
   make clean LIB=$sfcioLib4 MOD=$sfcioInc4
   mkdir -p $sfcioInc4
   FFLAGS4="$I4R4 $FFLAGS ${MODPATH}$sfcioInc4"
   collect_info sfcio 4 OneLine4 LibInfo4
   sfcioInfo4=sfcio_info_and_log4.txt
   $debg && make debug FFLAGS="$FFLAGS4" LIB=$sfcioLib4 \
                                         &> $sfcioInfo4 \
         || make build FFLAGS="$FFLAGS4" LIB=$sfcioLib4 \
                                         &> $sfcioInfo4
   make message MSGSRC="$(gen_cfunction $sfcioInfo4 OneLine4 LibInfo4)" \
                LIB=$sfcioLib4
 }

 $inst && {
#
#     Install libraries and source files 
#
   $local && {
     instloc=..
     LIB_DIR4=$instloc
     INCP_DIR=$instloc/include
     [ -d $INCP_DIR ] || { mkdir -p $INCP_DIR; }
     INCP_DIR4=$INCP_DIR
     SRC_DIR=
   } || {
     [[ $instloc == --- ]] && {
       LIB_DIR4=$(dirname $SFCIO_LIB4)
       INCP_DIR4=$(dirname $SFCIO_INC4)
       SRC_DIR=$SFCIO_SRC
     } || {
       LIB_DIR4=$instloc
       INCP_DIR4=$instloc/include
       SRC_DIR=$instloc/src
       [[ $instloc == .. ]] && SRC_DIR=
     }
     [ -d $LIB_DIR4 ] || mkdir -p $LIB_DIR4
     [ -d $SFCIO_INC4 ] && { rm -rf $SFCIO_INC4; } \
                        || { mkdir -p $INCP_DIR4; }
     [ -z $SRC_DIR ] || { [ -d $SRC_DIR ] || mkdir -p $SRC_DIR; }
   }

   make clean LIB=
   make install LIB=$sfcioLib4 MOD=$sfcioInc4 \
                LIB_DIR=$LIB_DIR4 INC_DIR=$INCP_DIR4 SRC_DIR=$SRC_DIR
 }


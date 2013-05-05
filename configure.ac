## Put version control id tag in output configure script
AC_REVISION($Id$)


## Initialise autoconf
AC_INIT([nceplibs sfcio], [v1.1.0], [ncep.list.emc.nceplibs.support@noaa.gov], [sfcio])


# Output info for user
AC_MSG_NOTICE([AC_PACKAGE_NAME AC_PACKAGE_VERSION])


# Check for existence of unique file before proceeding
AC_CONFIG_SRCDIR([libsrc/sfcio_module.f])


# Define the configuration files
AC_CONFIG_FILES([Makefile libsrc/Makefile])


# Check for programs
AC_PROG_FC(ifort gfortran xlf2003 pgf95)
AC_PROG_INSTALL
AC_CHECK_TOOL([AR], ar)
AC_CHECK_TOOL([RANLIB], ranlib)
# ...Set defaults for ARFLAGS since there is no autoconf macro
test -n "$ARFLAGS" || ARFLAGS="crvs"
AC_SUBST(ARFLAGS)


# Set the programming language
AC_LANG(Fortran)
AC_FC_FREEFORM
AC_FC_SRCEXT(f)

AC_OUTPUT

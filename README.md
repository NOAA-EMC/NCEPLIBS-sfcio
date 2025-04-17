![Status](https://github.com/NOAA-EMC/NCEPLIBS-sfcio/workflows/Build%20and%20Test/badge.svg)

# NCEPLIBS-sfcio

This library provides an API to read the NCEP Spectral model surface
files. This is part of the
[NCEPLIBS](https://github.com/NOAA-EMC/NCEPLIBS) project.

The spectral model is on a sunset track at NCEP and is not being
further developed but is still used for climate forecasts and ensemble
forecasts. The NCEPLIBS-sfcio library was originally part of the GFS
source code and was extracted to allow development of utilities that
read GFS surface files.

This library is used by the
[UFS_UTILS](https://github.com/NOAA-EMC/UFS_UTILS) project.

For full documentation see https://noaa-emc.github.io/NCEPLIBS-sfcio/.

To submit bug reports, feature requests, or other code-related issues including installation and usage questions, please create a [GitHub issue](https://github.com/NOAA-EMC/NCEPLIBS-sfcio/issues). For general NCEPLIBS inquiries, contact [Edward Hartnett](mailto:edward.hartnett@noaa.gov) (secondary point of contact [Alex Richert](mailto:alexander.richert@noaa.gov)).

## Authors

NCEP/EMC Developers

Code manager: [George Vandenberghe](mailto:george.vandenberghe@noaa.gov)

## Installing

```console
git clone https://github.com/NOAA-EMC/NCEPLIBS-sfcio # or download a release from https://github.com/NOAA-EMC/NCEPLIBS-sfcio/releases
cmake -DCMAKE_INSTALL_PREFIX=/path/to/install -S NCEPLIBS-sfcio -B NCEPLIBS-sfcio/build # <add'l CMake options>
cmake --build NCEPLIBS-sfcio/build --parallel 2
ctest --test-dir NCEPLIBS-sfcio/build --parallel 2 # <add'l CTest options>
cmake --install NCEPLIBS-sfcio/build
```

NCEPLIBS-sfcio is also available through [Spack](https://spack.io) as '[sfcio](https://github.com/spack/spack/tree/develop/var/spack/repos/builtin/packages/sfcio)'.

## Disclaimer

The United States Department of Commerce (DOC) GitHub project code is
provided on an "as is" basis and the user assumes responsibility for
its use. DOC has relinquished control of the information and no longer
has responsibility to protect the integrity, confidentiality, or
availability of the information. Any claims against the Department of
Commerce stemming from the use of its GitHub project will be governed
by all applicable Federal law. Any reference to specific commercial
products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of
Commerce. The Department of Commerce seal and logo, or the seal and
logo of a DOC bureau, shall not be used in any manner to imply
endorsement of any commercial product or activity by DOC or the United
States Government.




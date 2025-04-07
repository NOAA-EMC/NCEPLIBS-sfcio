@mainpage

# NCEPLIBS-sfcio

API for surface files I/O. This is part of
the [NCEPLIBS](https://github.com/NOAA-EMC/NCEPLIBS) project.

## Installation

```
git clone https://github.com/NOAA-EMC/NCEPLIBS-sfcio # or download a release from https://github.com/NOAA-EMC/NCEPLIBS-sfcio/releases
cmake -DCMAKE_INSTALL_PREFIX=/path/to/install -S NCEPLIBS-sfcio -B NCEPLIBS-sfcio/build # <add'l CMake options>
cmake --build NCEPLIBS-sfcio/build --parallel 2
ctest --test-dir NCEPLIBS-sfcio/build --parallel 2 # <add'l CTest options>
cmake --install NCEPLIBS-sfcio/build
```

The following CMake build options can be used to configure the build by setting them with `-D<OPTION>=<VALUE>`.

| Option | Description | Default |
|--------|-------------|---------|
| CMAKE_INSTALL_PREFIX | Installation path | /usr/local |
| CMAKE_POSITION_INDEPENDENT_CODE | Enable position-independent code (PIC) for static build | OFF |
| ENABLE_DOCS | Enable generation of doxygen-based documentation. | OFF |
| ENABLE_TESTS | Enable tests | OFF |

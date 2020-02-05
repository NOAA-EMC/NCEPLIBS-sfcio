cmake_minimum_required(VERSION 3.15)
project(sfcio VERSION 1.1.0)
set(${PROJECT_NAME}_VERSION ${PROJECT_VERSION} CACHE INTERNAL "${PROJECT_NAME} version number")
enable_language (Fortran)

if (NOT CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE RELEASE CACHE STRING
    "Choose the type of build, options are: PRODUCTION Debug Release."
    FORCE)
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  set(IntelComp true )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU*" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang*")
  set(GNUComp true )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "pgc*")
  set(PGIComp true )
endif()

STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "RelWithDebInfo" BUILD_RELEASE)
STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "RELEASE" BUILD_RELEASE)
STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "PRODUCTION" BUILD_PRODUCTION)
STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "DEBUG" BUILD_DEBUG)

if( (BUILD_RELEASE) OR (BUILD_PRODUCTION) )
  if(IntelComp)
    set(fortran_flags "-O2" "-g" "-xHOST" "-traceback" "-free" "-convert" "big_endian"
      "-assume" "byterecl")
  elseif(GNUComp)
    set(fortran_flags "-O2" "-ggdb" "-fbacktrace" "-ffree-form"
      "-fconvert=big-endian" "-funroll-loops" "-Wall")
  else()
    message("unknown compiler!")
    exit()
  endif()
endif()

set(lib_name ${PROJECT_NAME}_4)
set(versioned_lib_name ${PROJECT_NAME}_v${PROJECT_VERSION}_4)

file(GLOB fortran_src ${CMAKE_CURRENT_SOURCE_DIR}/src/*.f)
add_library(${lib_name} STATIC ${fortran_src})
set_target_properties(${lib_name} PROPERTIES OUTPUT_NAME "${versioned_lib_name}")

target_compile_options(${lib_name} PRIVATE ${fortran_flags})

set(module_dir "${PROJECT_BINARY_DIR}/include_4")
set_target_properties(${lib_name} PROPERTIES Fortran_MODULE_DIRECTORY ${module_dir})

target_include_directories(${lib_name} PUBLIC
  $<BUILD_INTERFACE:${module_dir}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include_4>)

install(TARGETS ${lib_name}
  EXPORT ${PROJECT_NAME}-config
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib) 
install(DIRECTORY ${module_dir} DESTINATION ${CMAKE_INSTALL_PREFIX})
install(EXPORT ${PROJECT_NAME}-config DESTINATION ${CMAKE_INSTALL_PREFIX})


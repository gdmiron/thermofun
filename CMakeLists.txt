# Require a certain version of cmake
cmake_minimum_required(VERSION 2.8)

# Set the cmake module path of the project
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

set(CMAKE_MACOSX_RPATH ON)

# Set the name of the project
project(thermofun)

# Set the default build type to Release
if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'Release' as none was specified.")
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Define variables with the GNU standard installation directories
include(GNUInstallDirs)

# Set the version of the project
set(THERMOFUN_VERSION_MAJOR "1")
set(THERMOFUN_VERSION_MINOR "0")
set(THERMOFUN_VERSION_MICRO "0")
set(THERMOFUN_VERSION "${THERMOFUN_VERSION_MAJOR}.${THERMOFUN_VERSION_MINOR}.${THERMOFUN_VERSION_MICRO}")

# Define which types of libraries to build
option(BUILD_SHARED_LIBS "Build shared libraries." ON)
option(BUILD_STATIC_LIBS "Build static libraries." ON)
option(BUILD_TESTS       "Build tests." OFF)

if (BUILD_TESTS)
option(LINK_GEMS4R       "Link Reaktoro with GEMS." ON)
else()
option(LINK_GEMS4R       "Link Reaktoro with GEMS." OFF)
endif()

# Set the thermofun source directory path
set(THERMOFUN_SOURCE_DIR ${CMAKE_SOURCE_DIR}/src)
set(THERMOFUN_TESTS_DIR  ${CMAKE_SOURCE_DIR}/tests )

# Set the directory where the third-party libraries are temporarily installed before installed to CMAKE_INSTALL_PREFIX
set(THIRDPARTY_DIR ${CMAKE_BINARY_DIR}/thirdparty)

# Set the include and library directories where the third party libraries were installed
set(THIRDPARTY_INCLUDE_DIR ${THIRDPARTY_DIR}/include)
set(THIRDPARTY_LIBRARY_DIR ${THIRDPARTY_DIR}/lib)

# Install the third-party libraries first
include(InstallThirdPartyLibs)

# Set the include directories
include_directories(${THERMOFUN_SOURCE_DIR})
include_directories(${THIRDPARTY_INCLUDE_DIR})

# Set the lib directory of the third party libraries installed automatically
link_directories(${THIRDPARTY_LIBRARY_DIR})

# Build thermofun library
add_subdirectory(src)

# Build the tests
if(BUILD_TESTS)
    add_subdirectory(tests)
else()
    add_subdirectory(tests EXCLUDE_FROM_ALL)
endif()

# Add target "tests" for manual building of tests, as `make tests`, if BUILD_TESTS is OFF
add_custom_target(tests
    COMMAND ${CMAKE_MAKE_PROGRAM}
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/tests")

# Package ThermoFun
# include(PackageThermoFun)

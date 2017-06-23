###############################################################################
# Description: This cmake script creates a package for ThermoFun.
# Author: G. Dan Miron
# Date: 23 June 2016
###############################################################################

###############################################################################
# Package's system name configuration
###############################################################################
# Set the name of the system if CPACK_SYSTEM_NAME is not defined
if(NOT DEFINED CPACK_SYSTEM_NAME)
    set(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME})
endif()

# Append the system processor label, if defined, to CPACK_SYSTEM_NAME
if(DEFINED CMAKE_SYSTEM_PROCESSOR AND (WIN32 OR APPLE))
    set(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR})
endif()
      
###############################################################################
# Package's generator configuration
###############################################################################
# Set the default CPack generator for Mac
if(NOT CPACK_GENERATOR AND APPLE)
    set(CPACK_GENERATOR "PackageMaker")
endif()

# Set the default CPack generators for Linux
if(NOT CPACK_GENERATOR AND UNIX AND NOT APPLE)
    set(CPACK_GENERATOR "TGZ;DEB;RPM")
endif()

# Set the default CPack generator for Windows
if(NOT CPACK_GENERATOR AND WIN32 AND NOT UNIX)
    set(CPACK_GENERATOR "NSIS")
endif()

###############################################################################
# Package's details configuration
###############################################################################
set(CPACK_PACKAGE_NAME "ThermoFun")
set(CPACK_PACKAGE_CONTACT "G. Dan Miron (dan.miron@psi.ch)")
set(CPACK_PACKAGE_VENDOR "ThermoFun")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "ThermoFun: A universal client for thermodynamic data")
set(CPACK_PACKAGE_VERSION       ${THERMOFUN_VERSION})
set(CPACK_PACKAGE_VERSION_MAJOR ${THERMOFUN_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${THERMOFUN_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${THERMOFUN_VERSION_MICRO})
set(CPACK_PACKAGE_INSTALL_DIRECTORY "ThermoFun")
set(CPACK_PACKAGE_DIRECTORY ${CMAKE_BINARY_DIR}/package)
#set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/resources/icons/thermofun.bmp")

###############################################################################
# Package's resources configuration
###############################################################################
#set(CPACK_RESOURCE_FILE_WELCOME "${CMAKE_SOURCE_DIR}/resources/packaging/welcome.rtf")
#set(CPACK_RESOURCE_FILE_README  "${CMAKE_SOURCE_DIR}/resources/packaging/readme.rtf")
#set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/resources/packaging/license.rtf")

###############################################################################
# Package's components and groups configuration
###############################################################################
# Set all archive installers to be component aware (i.e., distinct between headers, binaries, libraries)
# This affects the cpack generators STGZ, TBZ2, TGZ, TZ and ZIP 
set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)

# Generate a single package containing all components which can be optionally installed individually 
set(CPACK_COMPONENTS_ALL_IN_ONE_PACKAGE ON)

# Set the package components
set(CPACK_COMPONENTS_ALL applications libraries headers interfaces)

# Set more descriptive names for each package components
set(CPACK_COMPONENT_APPLICATIONS_DISPLAY_NAME "Applications")
set(CPACK_COMPONENT_LIBRARIES_DISPLAY_NAME "Libraries")
set(CPACK_COMPONENT_HEADERS_DISPLAY_NAME "Headers")
set(CPACK_COMPONENT_INTERFACES_DISPLAY_NAME "Interfaces")

# Set descriptions to the package components
set(CPACK_COMPONENT_APPLICATIONS_DESCRIPTION 
    "The applications developed using ThermoFun.")
set(CPACK_COMPONENT_LIBRARIES_DESCRIPTION 
    "The C++ static and shared libraries for runtime linking or application development.")
set(CPACK_COMPONENT_HEADERS_DESCRIPTION
    "The C++ header files needed for application development.")
set(CPACK_COMPONENT_INTERFACES_DESCRIPTION 
    "The modules that enable the use of ThermoFun from other programming languages.")

# Set the dependencies of some components on others
set(CPACK_COMPONENT_HEADERS_DEPENDS libraries)
set(CPACK_COMPONENT_INTERFACES_DEPENDS libraries)

# Set the groups among the components
set(CPACK_COMPONENT_LIBRARIES_GROUP "Development")
set(CPACK_COMPONENT_HEADERS_GROUP "Development")

# Set descriptions of the groups
set(CPACK_COMPONENT_GROUP_DEVELOPMENT_DESCRIPTION
   "The components for development of applications using ThermoFun.")

###############################################################################
# Package's options for Debian generator (UNIX)
###############################################################################
#set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "http://www.")

###############################################################################
# Package's options for NSIS generator (Windows)
###############################################################################

include(CPack)

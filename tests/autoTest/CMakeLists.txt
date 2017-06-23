# Needs C++11 features
add_definitions(-std=c++11 -fpermissive)

# Set the include directory where the headers of GEMS4R and its third-party libraries are 
include_directories(${CMAKE_BINARY_DIR}/thirdparty/include)
include_directories(${CMAKE_BINARY_DIR}/thirdparty/include/GEMS4R)
include_directories(${CMAKE_SOURCE_DIR})

# Set the link directory where GEMS4R library and the third-party libraries are installed
link_directories(${CMAKE_BINARY_DIR}/thirdparty/lib)
link_directories(${CMAKE_BINARY_DIR}/thirdparty/lib64)
link_directories(${CMAKE_BINARY_DIR}/GEMS4R)

# Build gemcalc
file(GLOB_RECURSE CPPFILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

foreach(CPPFILE ${CPPFILES})
    get_filename_component(CPPNAME ${CPPFILE} NAME_WE)
    add_executable(${CPPNAME} ${CPPFILE})
    target_link_libraries(${CPPNAME} THERMOFUN_SHARED)
    add_test(NAME ${CPPNAME} COMMAND ${CPPNAME})
endforeach()

add_custom_target(resources ALL COMMENT "Copy resources files to binary directory")
add_custom_command(
    TARGET resources POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/tests/autoTest/Resources
            ${CMAKE_BINARY_DIR}/tests/autoTest/Resources)

#target_link_libraries(gems4r Reaktoro)
#target_link_libraries(gems4r Reaktoro)




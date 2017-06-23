#set(THIRDPARTY_TARGETS GEMS4R)
#set(THIRDPARTY_LIBS gems4r)

# Include the current directory so that cute test framework can be used
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# Add ReaktoroInterpreter tests to the build system
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(autoTest)


#add_subdirectory(ReaktoroInterpreter)

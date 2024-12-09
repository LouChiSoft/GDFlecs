cmake_minimum_required(VERSION 3.25)

# CMake utility modules
include(cmake/apple_silicon.cmake) # Handling Apple Silicon specific behaviours
include(cmake/platform.cmake)      # Handling outputs based on platform
include(cmake/godot-cpp.cmake)     # Handle getting and linking Godot-CPP
include(cmake/gdextension.cmake)   # Handling the creation of the .gdextension file 

# Apple Silicon devices need flags set before the project is created.
set_apple_silicon_flags()

# TODO: Update project name
project(gdextension-template LANGUAGES CXX)
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    #[[
    How you define and add sources to your extension is up to
    you. But this will work as a simple build for now.
    ]]
    file(GLOB SRC "src/*.cpp")
    add_library(${PROJECT_NAME} SHARED ${SRC})
    target_include_directories(${PROJECT_NAME} PRIVATE "${CMAKE_SOURCE_DIR}/src")


    #[[
    set_platform_flags sets the needed flags for the extension 
    as well as the directory that the library is going to be 
    placed into. This will be used later by the function that 
    generates the .gdextension file
    Variables:
    --- TARGET: target name
    ]]
    set_platform_flags(${PROJECT_NAME})

    #[[
    get_and_link_godot_cpp uses FetchContent to download godot-cpp
    from github, include it's CMakeList and link it to a target
    Variables:
    --- TARGET: target name
    --- TAG: Tag or Branch to checkout when linking godot-cpp 
    --- PRECISION: Floating point precision. Valid arguments: SINGLE, DOUBLE
    ]]
    get_and_link_godot_cpp(
        ${PROJECT_NAME} 
        godot-4.3-stable
        "DOUBLE"
    )

    #[[
    get_and_link_godot_cpp uses FetchContent to download godot-cpp
    from github, include it's CMakeList and link it to a target
    Variables:
    --- TARGET: target name
    --- LIB_DIR: Directory within the build and config folder to place 
        .gdextendion file in. Use LIB_DIR provided by set_platform_flags()
    ]]
    generate_gdextension_file(${PROJECT_NAME} ${LIB_DIR})

    #[[
    copy_to_godot_project will copy your extension to a specific location.
    By default it copies it to the addons folder within the demo godot project
    included in this repository
    Variables:
    --- TARGET: target name
    --- DST: destination folder to copy the extension to
    ]]
    copy_to_godot_project(${PROJECT_NAME} "${CMAKE_SOURCE_DIR}/demo/addons")

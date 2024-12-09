function(get_and_link_godot_cpp TARGET TAG PRECISION EXTENSION_FILE)

    set(GODOT_CPP_SYSTEM_HEADERS ON CACHE INTERNAL "Generate system headers")
    set(GODOT_CPP_WARNING_AS_ERROR OFF CACHE INTERNAL "Treat warnings as errors")
    set(GENERATE_TEMPLATE_GET_NODE ON CACHE INTERNAL "Get template node")
    set(FLOAT_PRECISION "${PRECISION}" CACHE INTERNAL "Library precision")
    set(GODOT_CUSTOM_API_FILE "${EXTENSION_FILE}" CACHE INTERNAL "Extension api file")

    include(FetchContent)
    FetchContent_Declare(
        godot-cpp
        GIT_REPOSITORY https://github.com/godotengine/godot-cpp.git
        GIT_TAG ${TAG}
        GIT_SUBMODULES_RECURSE 1
    )
    FetchContent_MakeAvailable(godot-cpp)

    set_target_properties(godot-cpp PROPERTIES
        CXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN ON
    )
    # Turn on LTO and export compile commands for VSCode to use
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)

    target_link_libraries(${TARGET} PRIVATE godot-cpp)

endfunction()


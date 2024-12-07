function(get_and_link_godot_cpp TARGET TAG PRECISION)
    include(FetchContent)

    FetchContent_Declare(
        godot-cpp
        GIT_REPOSITORY https://github.com/godotengine/godot-cpp.git
        GIT_TAG ${TAG}
        GIT_SUBMODULES_RECURSE 1
        # Provide any configuration options you want, for instance:
        CMAKE_ARGS
          -DGODOT_CPP_SYSTEM_HEADERS=ON
          -DGODOT_CPP_WARNING_AS_ERROR=OFF
          -DGENERATE_TEMPLATE_GET_NODE=ON
          -DFLOAT_PRECISION=${PRECISION}
    )

    FetchContent_MakeAvailable(godot-cpp)

    set_target_properties(godot-cpp PROPERTIES
        CXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN ON
    )

    target_link_libraries(${TARGET} PRIVATE godot-cpp)

endfunction()


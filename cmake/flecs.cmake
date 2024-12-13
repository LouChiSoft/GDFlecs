function(get_and_link_flecs TARGET TAG)

    include(FetchContent)
    FetchContent_Declare(
        flecs
        GIT_REPOSITORY https://github.com/SanderMertens/flecs
        GIT_TAG ${TAG}
        GIT_SUBMODULES_RECURSE 1
    )
    FetchContent_MakeAvailable(flecs)

    set_target_properties(flecs PROPERTIES
        CXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN ON
    )
    # Turn on LTO and export compile commands for VSCode to use
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)

    target_link_libraries(${TARGET} PRIVATE flecs::flecs_static)

endfunction()


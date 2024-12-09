function(generate_gdextension_file TARGET_NAME LIB_DIR)
    # Check if the generator is a single-config generator
    if(NOT CMAKE_CONFIGURATION_TYPES)
        set(SINGLE_CONFIG true)
        # Single-config generators don't define CMAKE_CONFIGURATION_TYPES
        message(STATUS "Single-config generator detected. Build type will be determined at configuration time.")
        if(NOT DEFINED CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
            message(FATAL_ERROR "CMAKE_BUILD_TYPE is not set. Please specify a build type (e.g., Debug, Release, RelWithDebInfo, MinSizeRel).")
        else()
            message(STATUS "CMAKE_BUILD_TYPE is set to: ${CMAKE_BUILD_TYPE}")
        endif()
    else()
        set(SINGLE_CONFIG false)
        # Multi-config generators (e.g., Visual Studio, Xcode)
        message(STATUS "Multi-config generator detected. Build type will be determined at build time.")
    endif()


    add_custom_command(
        TARGET  ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} ALL
            -DPROJECT_NAME=${TARGET_NAME}
            -DPROJECT_SOURCE_DIR=${CMAKE_SOURCE_DIR}
            -DPROJECT_BINARY_DIR=${CMAKE_BINARY_DIR}
            -DBUILD_TYPE="$<IF:$<CONFIG:Debug>,Debug,$<IF:$<CONFIG:Release>,Release,$<IF:$<CONFIG:RelWithDebInfo>,RelWithDebInfo,Unknown>>>"
            -DSYSTEM=${LIB_DIR}
            -DIS_RELOADABLE="$<IF:$<CONFIG:Release>,,reloadable = true>"
            -DIS_SINGLE_CONFIG=${SINGLE_CONFIG}
            -P "${CMAKE_SOURCE_DIR}/cmake/configure_gdextension.cmake"
        COMMENT "Configuring GDExtension file"
    )
endfunction()

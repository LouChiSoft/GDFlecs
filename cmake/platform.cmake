function(set_platform_flags TARGET)
    if(APPLE)
        set(SYSTEM_ARCH "universal")
    else()
        set(SYSTEM_ARCH ${CMAKE_SYSTEM_PROCESSOR})
    endif()

    # Check if the generator is a single-config generator
    if(NOT CMAKE_CONFIGURATION_TYPES)
        # Single-config generators don't define CMAKE_CONFIGURATION_TYPES
        if(NOT DEFINED CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
            message(FATAL_ERROR "CMAKE_BUILD_TYPE is not set. Please specify a build type (e.g., Debug, Release, RelWithDebInfo, MinSizeRel).")
        else()
            set(BUILD_OUTPUT_DIR "${PROJECT_BINARY_DIR}/${TARGET}/lib/${CMAKE_SYSTEM_NAME}-${SYSTEM_ARCH}")
        endif()
    else()
        set(BUILD_TYPE "$<IF:$<CONFIG:Debug>,Debug,$<IF:$<CONFIG:Release>,Release,$<IF:$<CONFIG:RelWithDebInfo>,RelWithDebInfo,Unknown>>>")
        set(BUILD_OUTPUT_DIR "${PROJECT_BINARY_DIR}/${BUILD_TYPE}/${TARGET}/lib/${CMAKE_SYSTEM_NAME}-${SYSTEM_ARCH}")
    endif()

    set(LIB_DIR "lib/${CMAKE_SYSTEM_NAME}-${SYSTEM_ARCH}" PARENT_SCOPE)

    set_target_properties( ${TARGET}
        PROPERTIES
            CXX_VISIBILITY_PRESET hidden
            VISIBILITY_INLINES_HIDDEN true
            RUNTIME_OUTPUT_DIRECTORY "${BUILD_OUTPUT_DIR}"
            LIBRARY_OUTPUT_DIRECTORY "${BUILD_OUTPUT_DIR}"
    )
endfunction()


function(copy_to_godot_project TARGET_NAME DST)
    # Set directory to copy build output to. If not provided default
    # will be used
    if(NOT DEFINED DST)
        set(DST "${CMAKE_SOURCE_DIR}/demo/addons/${TARGET_NAME}")
    else()
        set(DST "${DST}/${TARGET_NAME}")
    endif ()

    # Determine which build output to copy and alert the user
    if(NOT CMAKE_CONFIGURATION_TYPES)
        set(BUILD_OUTPUT_DIR "${PROJECT_BINARY_DIR}/${TARGET_NAME}")
    else()
        set(BUILD_TYPE "$<IF:$<CONFIG:Debug>,Debug,$<IF:$<CONFIG:Release>,Release,$<IF:$<CONFIG:RelWithDebInfo>,RelWithDebInfo,Unknown>>>")
        set(BUILD_OUTPUT_DIR "${PROJECT_BINARY_DIR}/${BUILD_TYPE}/${TARGET_NAME}")
    endif()

    message(STATUS "Copying ${BUILD_OUTPUT_DIR} to ${DST} location.")
    add_custom_command(
        TARGET ${TARGET_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${BUILD_OUTPUT_DIR}" # Source folder
        "${DST}" # Destination folder inside DST
        COMMENT "Copying ${BUILD_OUTPUT_DIR} to ${DST} location."
    )
    add_custom_command(
        TARGET ${TARGET_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
        "${BUILD_OUTPUT_DIR}" # Source folder
        "${DST}" # Destination folder inside DST
        COMMENT "Copying ${BUILD_OUTPUT_DIR} to ${DST} location."
    )

endfunction()
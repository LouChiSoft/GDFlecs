function(set_platform_flags TARGET)
    if(APPLE)
        set(SYSTEM_ARCH "universal")
    else()
        set(SYSTEM_ARCH ${CMAKE_SYSTEM_PROCESSOR})
    endif()

    set(BUILD_TYPE "$<IF:$<CONFIG:Debug>,Debug,$<IF:$<CONFIG:Release>,Release,$<IF:$<CONFIG:RelWithDebInfo>,RelWithDebInfo,Unknown>>>")
    set(BUILD_OUTPUT_DIR "${PROJECT_BINARY_DIR}/${BUILD_TYPE}/${PROJECT_NAME}/lib/${CMAKE_SYSTEM_NAME}-${SYSTEM_ARCH}")
    set(LIB_DIR "lib/${CMAKE_SYSTEM_NAME}-${SYSTEM_ARCH}" PARENT_SCOPE)

    set_target_properties( ${TARGET}
        PROPERTIES
            CXX_VISIBILITY_PRESET hidden
            VISIBILITY_INLINES_HIDDEN true
            RUNTIME_OUTPUT_DIRECTORY "${BUILD_OUTPUT_DIR}"
            LIBRARY_OUTPUT_DIRECTORY "${BUILD_OUTPUT_DIR}"
    )

    # Turn on LTO and export compile commands for VSCode to use
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # WARNING: On Windows, this flag has no effect for Visual Studio generators. Ninja or Ninja Multi-Config is recommended
endfunction()


function(install_in_project TARGET_NAME LIB_DIR)
    message(STATUS "Install Prefix: ${CMAKE_INSTALL_PREFIX}")
    set(INSTALL_DIR "${CMAKE_INSTALL_PREFIX}")

    set(BUILD_TYPE "$<IF:$<CONFIG:Debug>,Debug,$<IF:$<CONFIG:Release>,Release,$<IF:$<CONFIG:RelWithDebInfo>,RelWithDebInfo,Unknown>>>")
    set(GDEXTENSION_NAME "${PROJECT_BINARY_DIR}/${BUILD_TYPE}/${PROJECT_NAME}/${TARGET_NAME}.gdextension")

    install( TARGETS ${TARGET_NAME}
    LIBRARY
        DESTINATION ${INSTALL_DIR}/${TARGET_NAME}/${LIB_DIR}
    RUNTIME
        DESTINATION ${INSTALL_DIR}/${TARGET_NAME}/${LIB_DIR}
    )

    install(FILES $<TARGET_PDB_FILE:${TARGET_NAME}>
        DESTINATION ${INSTALL_DIR}/${TARGET_NAME}/${LIB_DIR}
        CONFIGURATIONS Debug RelWithDebInfo
    )

    install(FILES ${GDEXTENSION_NAME}
        DESTINATION ${INSTALL_DIR}/${TARGET_NAME}
        CONFIGURATIONS Debug Release RelWithDebInfo MinSizeRel
    )
endfunction()
set(OUTPUT_DIR ${PROJECT_BINARY_DIR}/${BUILD_TYPE}/${PROJECT_NAME})
string(TOLOWER "${BUILD_TYPE}" CONFIG_LOWER)


if (MINGW)
    set(LIB_PREFIX "lib")
endif()

configure_file(
    "${PROJECT_SOURCE_DIR}/templates/gdextension-template.gdextension"
    "${OUTPUT_DIR}/${PROJECT_NAME}.gdextension"
)
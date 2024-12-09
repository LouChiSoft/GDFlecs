if (IS_SINGLE_CONFIG)
    set(OUTPUT_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME})
else()
    set(OUTPUT_DIR ${PROJECT_BINARY_DIR}/${BUILD_TYPE}/${PROJECT_NAME})
endif()

if (WIN32)
    set(LIB_EXT ".dll")
    set(OS "windows")
    set(ARCH "x86_64")
    if (MINGW)
        set(LIB_PREFIX "lib")
    endif()
elseif(APPLE)
    set(LIB_EXT ".dylib")
    set(OS "macos")
    set(LIB_PREFIX "lib")
else()
    set(LIB_EXT ".so")
    set(OS "linux")
    set(ARCH "x86_64")
    set(LIB_PREFIX "lib")
endif()

if ("${BUILD_TYPE}" STREQUAL "Debug")
    set(OS "${OS}.debug")
endif()

set(PLATFORM "${OS}.${ARCH}")
set(LIB_LOC "${SYSTEM}/${LIB_PREFIX}${PROJECT_NAME}${LIB_EXT}")

configure_file(
    "${PROJECT_SOURCE_DIR}/templates/gdextension-template.gdextension"
    "${OUTPUT_DIR}/${PROJECT_NAME}.gdextension"
)
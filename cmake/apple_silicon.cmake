function(set_apple_silicon_flags)
    if (APPLE)
        set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "")

    endif()
endfunction()
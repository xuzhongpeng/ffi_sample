cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(sample_library VERSION 1.0.0 LANGUAGES CXX)
include_directories(include)
set(dart_api include/dart_api_dl.h include/dart_api_dl.c)
add_library(sample_library SHARED sample.cc dart_async_utils.h dart_async_utils.cc sample.def)
add_executable(sample_test sample.cc dart_async_utils.cc ${dart_api})
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")

if(WIN32)
    # set(CMAKE_C_FLAGS "-g -Wall -I ****\\mingw64\\include -L ***\\mingw64\\lib")
    set(CMAKE_CXX_COMPILER "g++")
    # set(CMAKE_CXX_FLAGS "-g -Wall -I ***\\mingw64\\include -L ***\\mingw64\\lib -lstdc++")
    # set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
    # set(dir ${CMAKE_CURRENT_SOURCE_DIR})
    # set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${dir}/bin")
ENDIF()
# 包含dart include （异步需要）

set_target_properties(sample_library PROPERTIES
    PUBLIC_HEADER sample.h 
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "sample"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)

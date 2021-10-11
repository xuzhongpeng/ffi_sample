cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(sample_library VERSION 1.0.0 LANGUAGES C)
add_library(sample_library SHARED sample.c sample.def)
add_executable(sample_test sample.c)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)

set_target_properties(sample_library PROPERTIES
    PUBLIC_HEADER sample.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "sample"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)

cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(sample VERSION 1.0.0 LANGUAGES CXX C)

add_library(sample SHARED sample.cc sample.def include/dart_api_dl.h include/dart_api_dl.c)
add_executable(test main.cc)
target_link_libraries(test sample)

if(WIN32)
    set(CMAKE_CXX_COMPILER "g++")
ENDIF()

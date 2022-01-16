cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(sample VERSION 1.0.0 LANGUAGES CXX C)

# add_subdirectory("include")
# include_directories ("${CMAKE_SOURCE_DIR}/include")
# LINK_DIRECTORIES("${PROJECT_BINARY_DIR}/../lib")	



add_library(sample SHARED sample.cc sample.def include/dart_api_dl.h include/dart_api_dl.c)


add_executable(test main.cc)


target_link_libraries(test sample)


# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")  #设置c++的编译选项
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")
# set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(WIN32)
    # set(CMAKE_C_FLAGS "-g -Wall -I ****\\mingw64\\include -L ***\\mingw64\\lib")
    set(CMAKE_CXX_COMPILER "g++")
    # set(CMAKE_CXX_FLAGS "-g -Wall -I ***\\mingw64\\include -L ***\\mingw64\\lib -lstdc++")
    # set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
    # set(dir ${CMAKE_CURRENT_SOURCE_DIR})
    # set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${dir}/bin")
ENDIF()
# 包含dart include （异步需要）

# set_target_properties(sample PROPERTIES
#     PUBLIC_HEADER sample.h 
#     VERSION ${PROJECT_VERSION}
#     SOVERSION 1
#     OUTPUT_NAME "sample"
#     XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
# )

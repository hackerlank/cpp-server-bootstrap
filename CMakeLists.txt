cmake_minimum_required(VERSION 2.8)
project (CppServerBootstrap)

set(TARGET_LIB_NAME Server)

set(SERVER_PROJECT_ROOT_DIR ${CMAKE_SOURCE_DIR})
set(SERVER_PROJECT_SRC_DIR ${SERVER_PROJECT_ROOT_DIR}/src)
set(SERVER_PROJECT_BIN_DIR ${SERVER_PROJECT_ROOT_DIR}/bin)
set(SERVER_PROJECT_3RDPARTY_DIR ${SERVER_PROJECT_ROOT_DIR}/third_party)

if (MSVC)
add_definitions(-D_WIN32_WINNT=0x0601)
add_definitions(-D_SCL_SECURE_NO_WARNINGS)
endif()

include_directories(${SERVER_PROJECT_SRC_DIR})
include_directories(${SERVER_PROJECT_3RDPARTY_DIR}/googletest/include)

if (WIN32)
include_directories(${SERVER_PROJECT_3RDPARTY_DIR}/glog/src/windows)
else()
include_directories(${SERVER_PROJECT_3RDPARTY_DIR}/glog/src)
endif()

add_subdirectory(src) 
add_subdirectory(test)

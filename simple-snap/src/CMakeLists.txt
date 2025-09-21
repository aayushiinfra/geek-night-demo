cmake_minimum_required(VERSION 3.5)
project(hello-snap)

set(CMAKE_CXX_STANDARD 11)

add_executable(hello-snap main.cpp)
install(TARGETS hello-snap DESTINATION bin)

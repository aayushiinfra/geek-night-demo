cmake_minimum_required(VERSION 3.5)
project(hello-world)

set(CMAKE_CXX_STANDARD 11)

add_executable(hello-world main.cpp)
install(TARGETS hello-world DESTINATION bin)

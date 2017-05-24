cmake_minimum_required(VERSION 3.6)
project(ProjectEuler)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")

add_executable(Porblem_035 035_circular_primes.cpp MyLib.cpp)

add_executable(Porblem_037 037_trunkable_primes.cpp)

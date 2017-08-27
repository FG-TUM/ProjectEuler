cmake_minimum_required(VERSION 3.6)
project(ProjectEuler)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -g")

add_executable(Problem_035 035_circular_primes.cpp MyLib_cpp.cpp)
add_executable(Problem_037 037_trunkable_primes.cpp MyLib_cpp.cpp)
add_executable(Problem_038 038_pandigital_multiples.cpp MyLib_cpp.cpp)
add_executable(Problem_047 047_distinct_primes_factors.cpp MyLib_cpp.cpp)
add_executable(Problem_052 052_permuted_multiples.cpp MyLib_cpp.cpp)
add_executable(Problem_081 081_path_sum_two_ways.cpp)
add_executable(Problem_082 082_path_sum_three_ways.cpp)
add_executable(Problem_083 083_path_sum_four_ways.cpp)
add_executable(Problem_243 243_resilience.cpp MyLib_cpp.cpp)

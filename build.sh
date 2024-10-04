#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

project_name=$1

cmake_content=$(cat <<EOL
# CMakeLists.txt

set(SOURCES
    src/${project_name}.cpp
)

# set(HEADERS
#     ./header.h
# )

add_executable(${project_name} \${SOURCES})

cmake_minimum_required(VERSION 3.10)
project(${project_name} CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(${project_name} PRIVATE -g -Wall -Wextra -Werror -O0)
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    target_compile_options(${project_name} PRIVATE -O3)
endif()

# target_include_directories(${project_name} PRIVATE src)

# set_target_properties(${project_name} PROPERTIES VERSION ${PROJECT_VERSION})
EOL
)

mkdir -p src

echo "$cmake_content" > ./CMakeLists.txt

echo "int main() { return 0; }" > src/"${project_name}".cpp

echo "boilerplate CMakeLists.txt and source file created"

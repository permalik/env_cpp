#!/bin/bash

# Check if project name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# Assign input project name
project_name=$1

# Define the content of the CMakeLists.txt file
cmake_content=$(cat <<EOL
# CMakeLists.txt
cmake_minimum_required(VERSION 3.10) # Specify the minimum version of CMake
project(${project_name} 1.0)      # Define the project name and language

# Set the C standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add compile_options for debug information
target_compile_options(${project_name} PRIVATE -g -Wall -Wextra -Werror -O0)

# Add compile options for different build types
# if(CMAKE_BUILD_TYPE STREQUAL "Debug")
#     target_compile_options(MyProject PRIVATE -g -O0)
# elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
#     target_compile_options(MyProject PRIVATE -O3)
# endif()

# Specify the source files and header files
set(SOURCES
    ./${project_name}.cpp
)

# set(HEADERS
#     ./header.h
# )

# Create an executable target
add_executable(${project_name} \${SOURCES})

# Optionally, specify include directories (e.g., if you have headers in other directories)
# target_include_directories(${project_name} PRIVATE src)

# Add custom commands for cleaning up files
# CMake handles cleaning up build files automatically, so no need for custom commands.

# Optionally, you can add a version number to the target
# set_target_properties(MyProject PROPERTIES VERSION ${PROJECT_VERSION})
EOL
)

# Create the necessary directory structure
mkdir -p src

# Create the CMakeLists.txt file
echo "$cmake_content" > src/CMakeLists.txt

# Create a sample source file to avoid CMake errors about missing files
echo "int main() { return 0; }" > src/${project_name}.cpp

echo "Boilerplate CMakeLists.txt and source file created in ${project_name} directory."

cmake_minimum_required (VERSION 3.10)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(SHADER_DIR ${CMAKE_CURRENT_LIST_DIR}/src/shaders)

project ("n-body-simulation" CXX)


set (SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/src)
set (TARGET_NAME "N-Body")

add_executable (${TARGET_NAME} ${SRC_DIR}/n-body-simulation.cpp
	"${SRC_DIR}/base/VulkanBase.cpp")

target_include_directories(${TARGET_NAME} PRIVATE "${SRC_DIR}/base" "${SRC_DIR}")

find_package(Vulkan REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE Vulkan::Vulkan)

find_package(unofficial-vulkan-memory-allocator CONFIG REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE unofficial::vulkan-memory-allocator::vulkan-memory-allocator)

find_package(glfw3 CONFIG REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE glfw)

find_library(SHADERC_LIBRARY shaderc_combined)
target_link_libraries(${TARGET_NAME} PRIVATE ${SHADERC_LIBRARY})

add_subdirectory("src/external/SPIRV-Cross")

target_link_libraries(${TARGET_NAME} PRIVATE
		spirv-cross-glsl
		spirv-cross-hlsl
		spirv-cross-cpp
		spirv-cross-reflect
		spirv-cross-msl
		spirv-cross-util
		spirv-cross-core)
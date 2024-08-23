project(AMD)

# create header list
file(GLOB amd_headers "Include/*.h")

# list global sources
set(amd_sources ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_global.c)

# list sources for DINT and DLONG
set(amd_obj_sources
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_1.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_aat.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_defaults.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_dump.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_info.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_order.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_post_tree.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_postorder.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_preprocess.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/amd_valid.c
)

# add a DINT target
add_library(amd_DINT_objs OBJECT ${amd_obj_sources} ${amd_headers})

target_compile_definitions(amd_DINT_objs PRIVATE DINT)

target_include_directories(amd_DINT_objs PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Include
    ${config_dir}
)

# add a DLONG target
add_library(amd_DLONG_objs OBJECT ${amd_obj_sources} ${amd_headers})

target_compile_definitions(amd_DLONG_objs PRIVATE DLONG)

target_include_directories(amd_DLONG_objs PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Include
    ${config_dir}
)

# add no def targets
add_library(amd_NONE_objs OBJECT ${amd_sources} ${amd_headers})

target_include_directories(amd_NONE_objs PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Include
    ${config_dir}
)

# add the amd library
add_library(amd STATIC
    $<TARGET_OBJECTS:amd_DINT_objs>
    $<TARGET_OBJECTS:amd_DLONG_objs>
    $<TARGET_OBJECTS:amd_NONE_objs>
)

target_include_directories(amd 
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Include>
    PRIVATE
        ${config_dir}
)

# link to math library if unix
if(UNIX)
    target_link_libraries(amd m)
endif()

# set name of output library
set_target_properties(amd PROPERTIES OUTPUT_NAME ${lib_prefix}amd)

# build demos
if(BUILD_DEMOS)
    add_subdirectory(Demo)
endif()
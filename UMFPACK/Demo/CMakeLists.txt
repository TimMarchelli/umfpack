add_executable(umf4 umf4.c)
target_link_libraries(umf4 PRIVATE amd umfpack BLAS::BLAS)
target_include_directories(umf4 PRIVATE ${config_dir})

add_executable(umfpack_di_demo umfpack_di_demo.c)
target_link_libraries(umfpack_di_demo PRIVATE amd umfpack BLAS::BLAS)
target_include_directories(umfpack_di_demo PRIVATE ${config_dir})

add_executable(umfpack_dl_demo umfpack_dl_demo.c)
target_link_libraries(umfpack_dl_demo PRIVATE amd umfpack BLAS::BLAS)
target_include_directories(umfpack_dl_demo PRIVATE ${config_dir})

add_executable(umfpack_simple umfpack_simple.c)
target_link_libraries(umfpack_simple PRIVATE amd umfpack BLAS::BLAS)
target_include_directories(umfpack_simple PRIVATE ${config_dir})

add_executable(umfpack_zi_demo umfpack_zi_demo.c)
target_link_libraries(umfpack_zi_demo PRIVATE amd umfpack BLAS::BLAS)
target_include_directories(umfpack_zi_demo PRIVATE ${config_dir})

add_executable(umfpack_zl_demo umfpack_zl_demo.c)
target_link_libraries(umfpack_zl_demo PRIVATE amd umfpack BLAS::BLAS)
target_include_directories(umfpack_zl_demo PRIVATE ${config_dir})

# add common compile options to each target
get_property(targets DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY BUILDSYSTEM_TARGETS)
foreach(target ${targets})
    target_compile_options(${target} PRIVATE
        $<$<C_COMPILER_ID:GNU>:-Wno-unused-result>
        $<$<C_COMPILER_ID:Clang>:-Wno-format -Wno-deprecated-declarations>
        $<$<C_COMPILER_ID:MSVC>:/wd4477>
    )
endforeach()

if(WIN32)
    add_custom_command(TARGET umfpack_zl_demo POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy -t $<TARGET_FILE_DIR:umfpack_zl_demo> $<TARGET_RUNTIME_DLLS:umfpack_zl_demo>
        COMMAND_EXPAND_LISTS
    )
endif()
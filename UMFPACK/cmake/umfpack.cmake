# get all headers
file(GLOB umf_public_headers "${CMAKE_CURRENT_SOURCE_DIR}/Include/*.h")

add_library(umf_DINT_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_analyze.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_apply_order.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_colamd.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_free.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_fsize.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_is_permutation.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_malloc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_realloc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_report_perm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_singletons.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_blas3_update.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_build_tuples.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_create_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_dump.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_extend_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_garbage_collection.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_get_memory.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_init_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_init.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_wrapup.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_local_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_lsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_head_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_free_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_init_memoryspace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_row_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale_column.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_set_stats.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_symbolic_usage.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_tuple_lengths.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_usolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_grow_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_start_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_2by2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_col_to_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_defaults.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_lunz.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_determinant.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_qsymbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_info.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_matrix.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_perm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_status.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_triplet_to_col.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_symbolic.c
)

target_compile_definitions(umf_DINT_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_objs PRIVATE
    DINT
)

target_compile_options(umf_DINT_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_objs PRIVATE amd)

target_include_directories(umf_DINT_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_analyze.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_apply_order.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_colamd.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_free.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_fsize.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_is_permutation.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_malloc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_realloc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_report_perm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_singletons.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_blas3_update.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_build_tuples.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_create_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_dump.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_extend_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_garbage_collection.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_get_memory.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_init_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_init.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_wrapup.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_local_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_lsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_head_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_free_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_init_memoryspace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_row_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale_column.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_set_stats.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_symbolic_usage.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_tuple_lengths.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_usolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_grow_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_start_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_2by2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_col_to_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_defaults.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_lunz.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_determinant.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_qsymbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_info.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_matrix.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_perm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_status.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_triplet_to_col.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_symbolic.c
)

target_compile_definitions(umf_DLONG_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_objs PRIVATE
    DLONG
)

target_compile_options(umf_DLONG_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_objs PRIVATE amd)

target_include_directories(umf_DLONG_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf__NONE__objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_timer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_tictoc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_global.c
)

target_compile_definitions(umf__NONE__objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf__NONE__objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf__NONE__objs PRIVATE
    _NONE_
)

target_compile_options(umf__NONE__objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf__NONE__objs PRIVATE amd)

target_include_directories(umf__NONE__objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DINT_CONJUGATE_SOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
)

target_compile_definitions(umf_DINT_CONJUGATE_SOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_CONJUGATE_SOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_CONJUGATE_SOLVE_objs PRIVATE
    DINT
    CONJUGATE_SOLVE
)

target_compile_options(umf_DINT_CONJUGATE_SOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_CONJUGATE_SOLVE_objs PRIVATE amd)

target_include_directories(umf_DINT_CONJUGATE_SOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DINT_DO_MAP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_DINT_DO_MAP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_DO_MAP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_DO_MAP_objs PRIVATE
    DINT
    DO_MAP
)

target_compile_options(umf_DINT_DO_MAP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_DO_MAP_objs PRIVATE amd)

target_include_directories(umf_DINT_DO_MAP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DINT_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_DINT_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_DO_VALUES_objs PRIVATE
    DINT
    DO_VALUES
)

target_compile_options(umf_DINT_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_DINT_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DINT_DO_MAP_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_DINT_DO_MAP_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_DO_MAP_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_DO_MAP_DO_VALUES_objs PRIVATE
    DINT
    DO_MAP
    DO_VALUES
)

target_compile_options(umf_DINT_DO_MAP_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_DO_MAP_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_DINT_DO_MAP_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DINT_FIXQ_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
)

target_compile_definitions(umf_DINT_FIXQ_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_FIXQ_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_FIXQ_objs PRIVATE
    DINT
    FIXQ
)

target_compile_options(umf_DINT_FIXQ_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_FIXQ_objs PRIVATE amd)

target_include_directories(umf_DINT_FIXQ_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DINT_DROP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
)

target_compile_definitions(umf_DINT_DROP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_DROP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_DROP_objs PRIVATE
    DINT
    DROP
)

target_compile_options(umf_DINT_DROP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_DROP_objs PRIVATE amd)

target_include_directories(umf_DINT_DROP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DINT_WSOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
)

target_compile_definitions(umf_DINT_WSOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DINT_WSOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DINT_WSOLVE_objs PRIVATE
    DINT
    WSOLVE
)

target_compile_options(umf_DINT_WSOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DINT_WSOLVE_objs PRIVATE amd)

target_include_directories(umf_DINT_WSOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_CONJUGATE_SOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
)

target_compile_definitions(umf_DLONG_CONJUGATE_SOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_CONJUGATE_SOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_CONJUGATE_SOLVE_objs PRIVATE
    DLONG
    CONJUGATE_SOLVE
)

target_compile_options(umf_DLONG_CONJUGATE_SOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_CONJUGATE_SOLVE_objs PRIVATE amd)

target_include_directories(umf_DLONG_CONJUGATE_SOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_DO_MAP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_DLONG_DO_MAP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_DO_MAP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_DO_MAP_objs PRIVATE
    DLONG
    DO_MAP
)

target_compile_options(umf_DLONG_DO_MAP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_DO_MAP_objs PRIVATE amd)

target_include_directories(umf_DLONG_DO_MAP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_DLONG_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_DO_VALUES_objs PRIVATE
    DLONG
    DO_VALUES
)

target_compile_options(umf_DLONG_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_DLONG_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_DO_MAP_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_DLONG_DO_MAP_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_DO_MAP_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_DO_MAP_DO_VALUES_objs PRIVATE
    DLONG
    DO_MAP
    DO_VALUES
)

target_compile_options(umf_DLONG_DO_MAP_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_DO_MAP_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_DLONG_DO_MAP_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_FIXQ_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
)

target_compile_definitions(umf_DLONG_FIXQ_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_FIXQ_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_FIXQ_objs PRIVATE
    DLONG
    FIXQ
)

target_compile_options(umf_DLONG_FIXQ_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_FIXQ_objs PRIVATE amd)

target_include_directories(umf_DLONG_FIXQ_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_DROP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
)

target_compile_definitions(umf_DLONG_DROP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_DROP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_DROP_objs PRIVATE
    DLONG
    DROP
)

target_compile_options(umf_DLONG_DROP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_DROP_objs PRIVATE amd)

target_include_directories(umf_DLONG_DROP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_DLONG_WSOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
)

target_compile_definitions(umf_DLONG_WSOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_DLONG_WSOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_DLONG_WSOLVE_objs PRIVATE
    DLONG
    WSOLVE
)

target_compile_options(umf_DLONG_WSOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_DLONG_WSOLVE_objs PRIVATE amd)

target_include_directories(umf_DLONG_WSOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_CONJUGATE_SOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
)

target_compile_definitions(umf_ZINT_CONJUGATE_SOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_CONJUGATE_SOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_CONJUGATE_SOLVE_objs PRIVATE
    ZINT
    CONJUGATE_SOLVE
)

target_compile_options(umf_ZINT_CONJUGATE_SOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_CONJUGATE_SOLVE_objs PRIVATE amd)

target_include_directories(umf_ZINT_CONJUGATE_SOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_DO_MAP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_ZINT_DO_MAP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_DO_MAP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_DO_MAP_objs PRIVATE
    ZINT
    DO_MAP
)

target_compile_options(umf_ZINT_DO_MAP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_DO_MAP_objs PRIVATE amd)

target_include_directories(umf_ZINT_DO_MAP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_ZINT_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_DO_VALUES_objs PRIVATE
    ZINT
    DO_VALUES
)

target_compile_options(umf_ZINT_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_ZINT_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_blas3_update.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_build_tuples.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_create_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_dump.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_extend_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_garbage_collection.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_get_memory.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_init_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_init.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_wrapup.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_local_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_lsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_head_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_free_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_init_memoryspace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_row_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale_column.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_set_stats.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_symbolic_usage.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_tuple_lengths.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_usolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_grow_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_start_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_2by2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_col_to_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_defaults.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_lunz.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_determinant.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_qsymbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_info.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_matrix.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_perm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_status.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_triplet_to_col.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_symbolic.c
)

target_compile_definitions(umf_ZINT_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_objs PRIVATE
    ZINT
)

target_compile_options(umf_ZINT_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_objs PRIVATE amd)

target_include_directories(umf_ZINT_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_DO_MAP_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_ZINT_DO_MAP_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_DO_MAP_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_DO_MAP_DO_VALUES_objs PRIVATE
    ZINT
    DO_MAP
    DO_VALUES
)

target_compile_options(umf_ZINT_DO_MAP_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_DO_MAP_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_ZINT_DO_MAP_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_FIXQ_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
)

target_compile_definitions(umf_ZINT_FIXQ_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_FIXQ_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_FIXQ_objs PRIVATE
    ZINT
    FIXQ
)

target_compile_options(umf_ZINT_FIXQ_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_FIXQ_objs PRIVATE amd)

target_include_directories(umf_ZINT_FIXQ_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_DROP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
)

target_compile_definitions(umf_ZINT_DROP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_DROP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_DROP_objs PRIVATE
    ZINT
    DROP
)

target_compile_options(umf_ZINT_DROP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_DROP_objs PRIVATE amd)

target_include_directories(umf_ZINT_DROP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZINT_WSOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
)

target_compile_definitions(umf_ZINT_WSOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZINT_WSOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZINT_WSOLVE_objs PRIVATE
    ZINT
    WSOLVE
)

target_compile_options(umf_ZINT_WSOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZINT_WSOLVE_objs PRIVATE amd)

target_include_directories(umf_ZINT_WSOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_CONJUGATE_SOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
)

target_compile_definitions(umf_ZLONG_CONJUGATE_SOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_CONJUGATE_SOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_CONJUGATE_SOLVE_objs PRIVATE
    ZLONG
    CONJUGATE_SOLVE
)

target_compile_options(umf_ZLONG_CONJUGATE_SOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_CONJUGATE_SOLVE_objs PRIVATE amd)

target_include_directories(umf_ZLONG_CONJUGATE_SOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_DO_MAP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_ZLONG_DO_MAP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_DO_MAP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_DO_MAP_objs PRIVATE
    ZLONG
    DO_MAP
)

target_compile_options(umf_ZLONG_DO_MAP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_DO_MAP_objs PRIVATE amd)

target_include_directories(umf_ZLONG_DO_MAP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_ZLONG_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_DO_VALUES_objs PRIVATE
    ZLONG
    DO_VALUES
)

target_compile_options(umf_ZLONG_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_ZLONG_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_blas3_update.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_build_tuples.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_create_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_dump.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_extend_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_garbage_collection.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_get_memory.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_init_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_init.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_kernel_wrapup.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_local_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_lsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_ltsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_element.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_head_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_alloc_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_free_tail_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_mem_init_memoryspace.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_row_search.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale_column.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_set_stats.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_symbolic_usage.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_tuple_lengths.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_usolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_utsolve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_valid_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_grow_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_start_front.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_2by2.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_col_to_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_defaults.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_free_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_lunz.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_get_determinant.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_qsymbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_info.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_matrix.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_perm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_status.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_triplet.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_report_vector.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_transpose.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_triplet_to_col.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_scale.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_numeric.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_load_symbolic.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_save_symbolic.c
)

target_compile_definitions(umf_ZLONG_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_objs PRIVATE
    ZLONG
)

target_compile_options(umf_ZLONG_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_objs PRIVATE amd)

target_include_directories(umf_ZLONG_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_DO_MAP_DO_VALUES_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_triplet.c
)

target_compile_definitions(umf_ZLONG_DO_MAP_DO_VALUES_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_DO_MAP_DO_VALUES_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_DO_MAP_DO_VALUES_objs PRIVATE
    ZLONG
    DO_MAP
    DO_VALUES
)

target_compile_options(umf_ZLONG_DO_MAP_DO_VALUES_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_DO_MAP_DO_VALUES_objs PRIVATE amd)

target_include_directories(umf_ZLONG_DO_MAP_DO_VALUES_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_FIXQ_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_assemble.c
)

target_compile_definitions(umf_ZLONG_FIXQ_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_FIXQ_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_FIXQ_objs PRIVATE
    ZLONG
    FIXQ
)

target_compile_options(umf_ZLONG_FIXQ_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_FIXQ_objs PRIVATE amd)

target_include_directories(umf_ZLONG_FIXQ_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_DROP_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umf_store_lu.c
)

target_compile_definitions(umf_ZLONG_DROP_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_DROP_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_DROP_objs PRIVATE
    ZLONG
    DROP
)

target_compile_options(umf_ZLONG_DROP_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_DROP_objs PRIVATE amd)

target_include_directories(umf_ZLONG_DROP_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umf_ZLONG_WSOLVE_objs OBJECT
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/umfpack_solve.c
)

target_compile_definitions(umf_ZLONG_WSOLVE_objs PUBLIC BLAS_UNDERSCORE)
if((DEFINED UMFPACK_DEFINE_IVDEP) AND (DEFINED UMFPACK_DEFINE_NOVECTOR))
    target_compile_definitions(umf_ZLONG_WSOLVE_objs PRIVATE
        ${UMFPACK_DEFINE_IVDEP}
        ${UMFPACK_DEFINE_NOVECTOR}
    )
endif()

target_compile_definitions(umf_ZLONG_WSOLVE_objs PRIVATE
    ZLONG
    WSOLVE
)

target_compile_options(umf_ZLONG_WSOLVE_objs PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

target_link_libraries(umf_ZLONG_WSOLVE_objs PRIVATE amd)

target_include_directories(umf_ZLONG_WSOLVE_objs PRIVATE ${config_dir} ${CMAKE_CURRENT_SOURCE_DIR}/Include)

add_library(umfpack
    $<TARGET_OBJECTS:umf_DINT_objs>
    $<TARGET_OBJECTS:umf_DLONG_objs>
    $<TARGET_OBJECTS:umf__NONE__objs>
    $<TARGET_OBJECTS:umf_DINT_CONJUGATE_SOLVE_objs>
    $<TARGET_OBJECTS:umf_DINT_DO_MAP_objs>
    $<TARGET_OBJECTS:umf_DINT_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_DINT_DO_MAP_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_DINT_FIXQ_objs>
    $<TARGET_OBJECTS:umf_DINT_DROP_objs>
    $<TARGET_OBJECTS:umf_DINT_WSOLVE_objs>
    $<TARGET_OBJECTS:umf_DLONG_CONJUGATE_SOLVE_objs>
    $<TARGET_OBJECTS:umf_DLONG_DO_MAP_objs>
    $<TARGET_OBJECTS:umf_DLONG_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_DLONG_DO_MAP_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_DLONG_FIXQ_objs>
    $<TARGET_OBJECTS:umf_DLONG_DROP_objs>
    $<TARGET_OBJECTS:umf_DLONG_WSOLVE_objs>
    $<TARGET_OBJECTS:umf_ZINT_CONJUGATE_SOLVE_objs>
    $<TARGET_OBJECTS:umf_ZINT_DO_MAP_objs>
    $<TARGET_OBJECTS:umf_ZINT_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_ZINT_objs>
    $<TARGET_OBJECTS:umf_ZINT_DO_MAP_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_ZINT_FIXQ_objs>
    $<TARGET_OBJECTS:umf_ZINT_DROP_objs>
    $<TARGET_OBJECTS:umf_ZINT_WSOLVE_objs>
    $<TARGET_OBJECTS:umf_ZLONG_CONJUGATE_SOLVE_objs>
    $<TARGET_OBJECTS:umf_ZLONG_DO_MAP_objs>
    $<TARGET_OBJECTS:umf_ZLONG_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_ZLONG_objs>
    $<TARGET_OBJECTS:umf_ZLONG_DO_MAP_DO_VALUES_objs>
    $<TARGET_OBJECTS:umf_ZLONG_FIXQ_objs>
    $<TARGET_OBJECTS:umf_ZLONG_DROP_objs>
    $<TARGET_OBJECTS:umf_ZLONG_WSOLVE_objs>
)

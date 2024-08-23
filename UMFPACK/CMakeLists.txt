# check the compiler to determine the pragma to use
if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
    set(SUPPORT_GCC_IVDEP TRUE)
    set(SUPPORT_GCC_NOVECTOR TRUE)
elseif(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    set(SUPPORT_LOOP_IVDEP TRUE)
    set(SUPPORT_LOOP_NOVECTOR TRUE)
elseif((CMAKE_C_COMPILER_ID STREQUAL "Clang") OR ((CMAKE_C_COMPILER_ID STREQUAL "AppleClang")))
    set(SUPPORT_LOOP_VECTORIZE TRUE)
    set(SUPPORT_LOOP_NOVECTORIZE TRUE)
elseif((CMAKE_C_COMPILER_ID STREQUAL "IntelLLVM") OR (CMAKE_C_COMPILER_ID STREQUAL "Intel"))
    set(SUPPORT_IVDEP TRUE)
    set(SUPPORT_NOVECTOR TRUE)
endif()

# setup the define to set correct pragma
if(SUPPORT_IVDEP)
    set(UMFPACK_DEFINE_IVDEP "SUPPORT_IVDEP")
elseif(SUPPORT_LOOP_IVDEP)
    set(UMFPACK_DEFINE_IVDEP "SUPPORT_LOOP_IVDEP")
elseif(SUPPORT_GCC_IVDEP)
    set(UMFPACK_DEFINE_IVDEP "SUPPORT_GCC_IVDEP")
elseif(SUPPORT_LOOP_VECTORIZE)
    set(UMFPACK_DEFINE_IVDEP "SUPPORT_LOOP_VECTORIZE")
endif()

if(SUPPORT_NOVECTOR)
    set(UMFPACK_DEFINE_NOVECTOR "SUPPORT_NOVECTOR")
elseif(SUPPORT_LOOP_NOVECTOR)
    set(UMFPACK_DEFINE_NOVECTOR "SUPPORT_LOOP_NOVECTOR")
elseif(SUPPORT_GCC_NOVECTOR)
    set(UMFPACK_DEFINE_NOVECTOR "SUPPORT_GCC_NOVECTOR")
elseif(SUPPORT_LOOP_NOVECTORIZE)
    set(UMFPACK_DEFINE_NOVECTOR "SUPPORT_LOOP_NOVECTORIZE")
endif()

# umfpack needs fPIC to use some globals in amd when build as shared
if(UNIX AND BUILD_SHARED_LIBS)
    add_compile_options("-fPIC")
endif()

# get the lists
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/umfpack.cmake)

target_include_directories(umfpack 
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Include>
        $<INSTALL_INTERFACE:${INSTALL_INCLUDE_DIR}>
    PRIVATE
        ${config_dir}
)

# link to trailing underscore BLAS names
target_compile_definitions(umfpack PUBLIC BLAS_UNDERSCORE)

target_link_libraries(umfpack PRIVATE amd BLAS::BLAS)

target_compile_options(umfpack PRIVATE 
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:GNU>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-implicit-function-declaration>
    $<$<OR:$<C_COMPILER_ID:Clang>,$<C_COMPILER_ID:IntelLLVM>>:-Wno-deprecated-declarations -Wno-implicit-const-int-float-conversion -Wno-pass-failed -Wno-array-parameter>
)

# set name of output library
set_target_properties(umfpack PROPERTIES OUTPUT_NAME ${lib_prefix}umfpack)

# install includes
install(FILES ${umf_public_headers} DESTINATION ${INSTALL_INCLUDE_DIR})

if(BUILD_DEMOS)
    add_subdirectory(Demo)
endif()
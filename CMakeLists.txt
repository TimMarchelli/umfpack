cmake_minimum_required(VERSION 3.22)

project(umfpack C)

# options
option(BUILD_DEMOS "Build AMD and UMFPACK demos." OFF)
option(BUILD_SHARED_LIBS "Build shared libraries (.dll/.so) instead of static ones (.lib/.a)" ON)

# default install location vars and configuration build tool
include(CTest)
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# configuration directory for global header
set(config_dir ${CMAKE_CURRENT_SOURCE_DIR}/UFconfig)

# set lib prefix for libraries in windows
if(WIN32)
    set(lib_prefix "lib")
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
endif()

# set debug "d" postfix to all libraries
set(CMAKE_DEBUG_POSTFIX "d")

# find BLAS package
find_package(BLAS REQUIRED)
set(BLAS_IMPORT_LIB BLAS::BLAS)

# logic to determine type of BLAS and import it directly if possible. Importing directly populates more 
# information about the import library than FindBLAS does. This is important in windows where we need to 
# know the location of the imported DLL.
if(BLAS_LIBRARIES MATCHES "[Oo][Pp][Ee][Nn][Bb][Ll][Aa][Ss]")
    message(STATUS "--Using OpenBLAS import library.")
    find_package(OpenBLAS REQUIRED)
    set(BLAS_IMPORT_LIB OpenBLAS::OpenBLAS)

# add more logic to directly import other BLAS implementations
endif()

# modify install targets
set(INSTALL_RUNTIME_DIR ${CMAKE_INSTALL_BINDIR})
set(INSTALL_CONFIG_DIR  ${CMAKE_INSTALL_LIBDIR}/cmake/umfpack)
set(INSTALL_LIBRARY_DIR ${CMAKE_INSTALL_LIBDIR})
set(INSTALL_INCLUDE_DIR ${CMAKE_INSTALL_INCLUDEDIR}/umfpack)

# rpath
if(NOT APPLE)
    set(CMAKE_INSTALL_RPATH $ORIGIN)
endif()

# build the libraries
add_subdirectory(AMD)
add_subdirectory(UMFPACK)

# add an alias
add_library(umfpack::umfpack ALIAS umfpack)

# set versions
set_target_properties(amd PROPERTIES
    SOVERSION 2
    VERSION 2.2.0
)

set_target_properties(umfpack PROPERTIES 
    SOVERSION 5
    VERSION   5.1.0
)

# set a project config file to enable linking to libraries in the build directory
set(PROJECT_CONFIG_FILE "${CMAKE_BINARY_DIR}/umfpackConfig.cmake")
configure_package_config_file(cmake/umfpackConfig.cmake.in
    ${PROJECT_CONFIG_FILE}
    INSTALL_DESTINATION ${INSTALL_CONFIG_DIR}
)

# install library
install(TARGETS umfpack
    EXPORT umfpack-targets
    RUNTIME DESTINATION ${INSTALL_RUNTIME_DIR}
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR}
)

# install includes
install(FILES ${config_dir}/UFconfig.h AMD/Include/amd.h DESTINATION ${INSTALL_INCLUDE_DIR})

# install the configs
install(FILES
    ${PROJECT_CONFIG_FILE}
    DESTINATION ${INSTALL_CONFIG_DIR}
)

install(EXPORT umfpack-targets 
    FILE umfpack-targets.cmake 
    NAMESPACE umfpack::
    DESTINATION ${INSTALL_CONFIG_DIR}
)
# add demo targets
add_executable(amd_demo amd_demo.c)
target_link_libraries(amd_demo PRIVATE amd)
target_include_directories(amd_demo PRIVATE ${config_dir})

add_executable(amd_demo2 amd_demo2.c)
target_link_libraries(amd_demo2 PRIVATE amd)
target_include_directories(amd_demo2 PRIVATE ${config_dir})

add_executable(amd_l_demo amd_l_demo.c)
target_link_libraries(amd_l_demo PRIVATE amd)
target_include_directories(amd_l_demo PRIVATE ${config_dir})

add_executable(amd_simple amd_simple.c)
target_link_libraries(amd_simple PRIVATE amd)
target_include_directories(amd_simple PRIVATE ${config_dir})

add_custom_command(TARGET amd_demo POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy -t $<TARGET_FILE_DIR:amd_demo> $<TARGET_RUNTIME_DLLS:amd_demo>
    COMMAND_EXPAND_LISTS
)
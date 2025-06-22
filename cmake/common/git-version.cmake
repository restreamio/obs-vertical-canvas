# Git-based version generation module

include_guard(GLOBAL)

# Find Git
find_package(Git QUIET)

if(GIT_FOUND)
    # Get git describe output
    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --tags --dirty --always --long
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_DESCRIBE
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )
    
    # Get commit hash
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )
    
    # Get commit count
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-list --count HEAD
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_COUNT
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )
    
    if(GIT_DESCRIBE)
        # Parse version from git describe (format: v1.2.3-4-gabcdef or 1.2.3-4-gabcdef)
        if(GIT_DESCRIBE MATCHES "^v?([0-9]+)\\.([0-9]+)\\.([0-9]+)(-([0-9]+)-g([0-9a-f]+))?(-dirty)?$")
            set(GIT_VERSION_MAJOR ${CMAKE_MATCH_1})
            set(GIT_VERSION_MINOR ${CMAKE_MATCH_2})
            set(GIT_VERSION_PATCH ${CMAKE_MATCH_3})
            set(GIT_VERSION_TWEAK ${CMAKE_MATCH_5})
            set(GIT_VERSION_COMMIT ${CMAKE_MATCH_6})
            set(GIT_VERSION_DIRTY ${CMAKE_MATCH_7})
            
            # Build version string (CMake VERSION must be numeric only)
            if(GIT_VERSION_TWEAK AND GIT_VERSION_TWEAK GREATER 0)
                # Version with commit count: 1.2.3.4
                set(GIT_VERSION_STRING "${GIT_VERSION_MAJOR}.${GIT_VERSION_MINOR}.${GIT_VERSION_PATCH}.${GIT_VERSION_TWEAK}")
            else()
                # Clean tag version: 1.2.3
                set(GIT_VERSION_STRING "${GIT_VERSION_MAJOR}.${GIT_VERSION_MINOR}.${GIT_VERSION_PATCH}")
            endif()
            
            # Store full version with suffix separately
            set(GIT_VERSION_FULL_STRING ${GIT_VERSION_STRING})
            if(GIT_VERSION_DIRTY)
                set(GIT_VERSION_FULL_STRING "${GIT_VERSION_STRING}-dirty")
            endif()
            
        else()
            # Fallback for non-tagged commits
            set(GIT_VERSION_STRING "0.0.0.${GIT_COMMIT_COUNT}")
            set(GIT_VERSION_MAJOR 0)
            set(GIT_VERSION_MINOR 0)
            set(GIT_VERSION_PATCH 0)
            set(GIT_VERSION_TWEAK ${GIT_COMMIT_COUNT})
        endif()
        
        set(GIT_VERSION_HASH ${GIT_COMMIT_HASH})
        
        message(STATUS "Git version: ${GIT_VERSION_STRING} (${GIT_DESCRIBE})")
    endif()
endif()

# Export variables for use in current scope
set(PLUGIN_GIT_VERSION ${GIT_VERSION_STRING})
set(PLUGIN_GIT_HASH ${GIT_VERSION_HASH})
set(PLUGIN_GIT_FULL ${GIT_DESCRIBE})
set(PLUGIN_BUILD_FROM_GIT ${GIT_FOUND})
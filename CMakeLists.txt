cmake_minimum_required(VERSION 3.12)
project(oss-Octopus)

include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)

add_custom_target(universe ALL)
add_custom_target(tests)
add_custom_target(clean-submodules)

option(BUILD_ALWAYS "Always try to build the target (will also re-execute the install pass)" ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")

set(STAMPS_DIR "${CMAKE_BINARY_DIR}/stamps" CACHE STRING "The directory that will contain the stamps")
set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/output" CACHE STRING "Where to temporarily install everything")
set(PKG_DIR "${CMAKE_BINARY_DIR}/output/packages" CACHE STRING "Where to temporarily install packages")

# Setting compilers
set(REVEN_C_COMPILER "${CMAKE_C_COMPILER}")
set(REVEN_CXX_COMPILER "${CMAKE_CXX_COMPILER}")

# Creating the directories
file(MAKE_DIRECTORY "${OUTPUT_DIR}/include")
file(MAKE_DIRECTORY "${OUTPUT_DIR}/lib")
file(MAKE_DIRECTORY "${PKG_DIR}")

option(BUILD_PANDA "Enable the build of PANDA" ON)
option(BUILD_BOCHS "Enable the build of BOCHS" ON)

message("BUILD_PANDA: ${BUILD_PANDA}")
message("BUILD_BOCHS: ${BUILD_BOCHS}")

if (CMAKE_GENERATOR MATCHES "Makefiles")
    set(make_command "$(MAKE)")
    set(real_make_command "$(MAKE)")
elseif (CMAKE_GENERATOR MATCHES "Ninja")
    set(make_command "ninja")
    set(real_make_command "make")
else()
    set(make_command "make")
    set(real_make_command "make")
endif()

##########
# Common #
##########

add_custom_target(common)
add_dependencies(universe common)

################################################################ rvnjsonresource

# Build the submodule
ExternalProject_Add(rvnjsonresource
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnjsonresource
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnjsonresource
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnjsonresource)

ExternalProject_Get_Property(rvnjsonresource BINARY_DIR)
set(RVNJSONRESOURCE_BINARY_DIR ${BINARY_DIR})

# # Test the submodule
# ExternalProject_Add_StepTargets(rvnjsonresource NO_DEPENDS test)
# add_dependencies(tests rvnjsonresource-test)

# Clean the submodule
add_custom_target(clean-rvnjsonresource)

add_custom_target(clean-rvnjsonresource-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnjsonresource-*
    COMMENT "Deleting rvnjsonresource stamps"
)
add_dependencies(clean-rvnjsonresource clean-rvnjsonresource-stamps)

add_custom_target(clean-rvnjsonresource-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNJSONRESOURCE_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnjsonresource"
)
add_dependencies(clean-rvnjsonresource clean-rvnjsonresource-build)

add_dependencies(clean-submodules clean-rvnjsonresource)

################################################################ rvnbinresource

# Build the submodule
ExternalProject_Add(rvnbinresource
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnbinresource
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnbinresource
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnbinresource)

ExternalProject_Get_Property(rvnbinresource BINARY_DIR)
set(RVNBINRESOURCE_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvnbinresource NO_DEPENDS test)
add_dependencies(tests rvnbinresource-test)

# Clean the submodule
add_custom_target(clean-rvnbinresource)

add_custom_target(clean-rvnbinresource-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnbinresource-*
    COMMENT "Deleting rvnbinresource stamps"
)
add_dependencies(clean-rvnbinresource clean-rvnbinresource-stamps)

add_custom_target(clean-rvnbinresource-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNBINRESOURCE_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnbinresource"
)
add_dependencies(clean-rvnbinresource clean-rvnbinresource-build)

add_dependencies(clean-submodules clean-rvnbinresource)

################################################################ rvnsqlite

# Build the submodule
ExternalProject_Add(rvnsqlite
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnsqlite
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnsqlite
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnsqlite)

ExternalProject_Get_Property(rvnsqlite BINARY_DIR)
set(RVNSQLITE_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvnsqlite NO_DEPENDS test)
add_dependencies(tests rvnsqlite-test)

# Clean the submodule
add_custom_target(clean-rvnsqlite)

add_custom_target(clean-rvnsqlite-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnsqlite-*
    COMMENT "Deleting rvnsqlite stamps"
)
add_dependencies(clean-rvnsqlite clean-rvnsqlite-stamps)

add_custom_target(clean-rvnsqlite-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNSQLITE_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnsqlite"
)
add_dependencies(clean-rvnsqlite clean-rvnsqlite-build)

add_dependencies(clean-submodules clean-rvnsqlite)

################################################################ rvnmetadata

# Build the submodule
ExternalProject_Add(rvnmetadata
    DEPENDS rvnsqlite rvnbinresource rvnjsonresource
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnmetadata
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnmetadata
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnmetadata)

ExternalProject_Get_Property(rvnmetadata BINARY_DIR)
set(RVNMETADATA_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvnmetadata NO_DEPENDS test)
add_dependencies(tests rvnmetadata-test)

# Clean the submodule
add_custom_target(clean-rvnmetadata)

add_custom_target(clean-rvnmetadata-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnmetadata-*
    COMMENT "Deleting rvnmetadata stamps"
)
add_dependencies(clean-rvnmetadata clean-rvnmetadata-stamps)

add_custom_target(clean-rvnmetadata-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNMETADATA_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnmetadata"
)
add_dependencies(clean-rvnmetadata clean-rvnmetadata-build)

add_dependencies(clean-submodules clean-rvnmetadata)

################################################################ rvnbintrace

# Build the submodule
ExternalProject_Add(rvnbintrace
    DEPENDS rvnmetadata rvnbinresource
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnbintrace
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnbintrace
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnbintrace)

ExternalProject_Get_Property(rvnbintrace BINARY_DIR)
set(RVNBINTRACE_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvnbintrace NO_DEPENDS test)
add_dependencies(tests rvnbintrace-test)

# Clean the submodule
add_custom_target(clean-rvnbintrace)

add_custom_target(clean-rvnbintrace-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnbintrace-*
    COMMENT "Deleting rvnbintrace stamps"
)
add_dependencies(clean-rvnbintrace clean-rvnbintrace-stamps)

add_custom_target(clean-rvnbintrace-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNBINTRACE_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnbintrace"
)
add_dependencies(clean-rvnbintrace clean-rvnbintrace-build)

add_dependencies(clean-submodules clean-rvnbintrace)

################################################################ rvnblock

# Build the submodule
ExternalProject_Add(rvnblock
    DEPENDS rvnmetadata rvnsqlite
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnblock
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnblock
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnblock)

ExternalProject_Get_Property(rvnblock BINARY_DIR)
set(RVNBLOCK_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvnblock NO_DEPENDS test)
add_dependencies(tests rvnblock-test)

# Clean the submodule
add_custom_target(clean-rvnblock)

add_custom_target(clean-rvnblock-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnblock-*
    COMMENT "Deleting rvnblock stamps"
)
add_dependencies(clean-rvnblock clean-rvnblock-stamps)

add_custom_target(clean-rvnblock-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNBLOCK_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnblock"
)
add_dependencies(clean-rvnblock clean-rvnblock-build)

add_dependencies(clean-submodules clean-rvnblock)

################################################################ rvnmemhistwriter

# Build the submodule
ExternalProject_Add(rvnmemhistwriter
    DEPENDS rvnsqlite rvnmetadata
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnmemhistwriter
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnmemhistwriter
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnmemhistwriter)

ExternalProject_Get_Property(rvnmemhistwriter BINARY_DIR)
set(RVNMEMHISTWRITER_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvnmemhistwriter NO_DEPENDS test)
add_dependencies(tests rvnmemhistwriter-test)

# Clean the submodule
add_custom_target(clean-rvnmemhistwriter)

add_custom_target(clean-rvnmemhistwriter-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnmemhistwriter-*
    COMMENT "Deleting rvnmemhistwriter stamps"
)
add_dependencies(clean-rvnmemhistwriter clean-rvnmemhistwriter-stamps)

add_custom_target(clean-rvnmemhistwriter-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNMEMHISTWRITER_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnmemhistwriter"
)
add_dependencies(clean-rvnmemhistwriter clean-rvnmemhistwriter-build)

add_dependencies(clean-submodules clean-rvnmemhistwriter)

################################################################ rvnsyncpoint

# Build the submodule
ExternalProject_Add(rvnsyncpoint
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnsyncpoint
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnsyncpoint
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}
    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"
)
add_dependencies(common rvnsyncpoint)

ExternalProject_Get_Property(rvnsyncpoint BINARY_DIR)
set(RVNSYNCPOINT_BINARY_DIR ${BINARY_DIR})

# rvnsyncpoint doesn't have tests

# Clean the submodule
add_custom_target(clean-rvnsyncpoint)

add_custom_target(clean-rvnsyncpoint-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnsyncpoint-*
    COMMENT "Deleting rvnsyncpoint stamps"
)
add_dependencies(clean-rvnsyncpoint clean-rvnsyncpoint-stamps)

add_custom_target(clean-rvnsyncpoint-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNSYNCPOINT_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnsyncpoint"
)
add_dependencies(clean-rvnsyncpoint clean-rvnsyncpoint-build)

add_dependencies(clean-submodules clean-rvnsyncpoint)

################################################################ rvncorevirtualbox

# Build the submodule
ExternalProject_Add(rvncorevirtualbox
    PREFIX ${CMAKE_BINARY_DIR}/common/rvncorevirtualbox
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvncorevirtualbox
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvncorevirtualbox)

ExternalProject_Get_Property(rvncorevirtualbox BINARY_DIR)
set(RVNCOREVIRTUALBOX_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvncorevirtualbox NO_DEPENDS test)
add_dependencies(tests rvncorevirtualbox-test)


# Clean the submodule
add_custom_target(clean-rvncorevirtualbox)

add_custom_target(clean-rvncorevirtualbox-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvncorevirtualbox-*
    COMMENT "Deleting rvncorevirtualbox stamps"
)
add_dependencies(clean-rvncorevirtualbox clean-rvncorevirtualbox-stamps)

add_custom_target(clean-rvncorevirtualbox-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNCOREVIRTUALBOX_BINARY_DIR} --target clean
    COMMENT "Make clean in rvncorevirtualbox"
)
add_dependencies(clean-rvncorevirtualbox clean-rvncorevirtualbox-build)

add_dependencies(clean-submodules clean-rvncorevirtualbox)

################################################################ rvnvmicomm

# Build the submodule
ExternalProject_Add(rvnvmicomm
    PREFIX ${CMAKE_BINARY_DIR}/common/rvnvmicomm
    STAMP_DIR ${STAMPS_DIR}
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/common/rvnvmicomm
    INSTALL_DIR ${OUTPUT_DIR}
    BUILD_ALWAYS ${BUILD_ALWAYS}

    CMAKE_ARGS
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR}
    CMAKE_CACHE_ARGS "-DCMAKE_C_COMPILER:STRING=${REVEN_C_COMPILER}" "-DCMAKE_CXX_COMPILER:STRING=${REVEN_CXX_COMPILER}"

    TEST_EXCLUDE_FROM_MAIN 1
)
add_dependencies(common rvnvmicomm)

ExternalProject_Get_Property(rvnvmicomm BINARY_DIR)
set(RVNVMICOMM_BINARY_DIR ${BINARY_DIR})

# Test the submodule
ExternalProject_Add_StepTargets(rvnvmicomm NO_DEPENDS test)
add_dependencies(tests rvnvmicomm-test)

# Clean the submodule
add_custom_target(clean-rvnvmicomm)

add_custom_target(clean-rvnvmicomm-stamps
    COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/rvnvmicomm-*
    COMMENT "Deleting rvnvmicomm stamps"
)
add_dependencies(clean-rvnvmicomm clean-rvnvmicomm-stamps)

add_custom_target(clean-rvnvmicomm-build
    COMMAND ${CMAKE_COMMAND} --build ${RVNVMICOMM_BINARY_DIR} --target clean
    COMMENT "Make clean in rvnvmicomm"
)
add_dependencies(clean-rvnvmicomm clean-rvnvmicomm-build)

add_dependencies(clean-submodules clean-rvnvmicomm)

#########
# Panda #
#########

if(BUILD_PANDA)
    # Build the submodule
    ExternalProject_Add(panda
        DEPENDS rvnbintrace rvnblock rvnmemhistwriter rvnvmicomm
        PREFIX ${CMAKE_BINARY_DIR}/panda
        STAMP_DIR ${STAMPS_DIR}
        SOURCE_DIR ${CMAKE_SOURCE_DIR}/panda
        INSTALL_DIR ${OUTPUT_DIR}
        BUILD_ALWAYS ${BUILD_ALWAYS}

        CONFIGURE_COMMAND
            <SOURCE_DIR>/configure
                --disable-vhost-net
                --disable-strip
                --enable-libusb
                --target-list=x86_64-softmmu
                --prefix=${OUTPUT_DIR}
                --cc=${CMAKE_C_COMPILER}
                --cxx=${CMAKE_CXX_COMPILER}
                --extra-ldflags=-L${OUTPUT_DIR}/lib
                --extra-cflags=-I${OUTPUT_DIR}/include
                --extra-plugins-path=${CMAKE_SOURCE_DIR}/reven-panda-plugins
                --disable-debug-info
    )
    add_dependencies(universe panda)

    ExternalProject_Get_Property(panda BINARY_DIR)
    set(PANDA_BINARY_DIR ${BINARY_DIR})

    ExternalProject_Get_Property(panda SOURCE_DIR)
    set(PANDA_SOURCE_DIR ${SOURCE_DIR})

    # Step to copy the panda plugins, since `make install` doesn't care about them
    ExternalProject_Add_Step(panda install-plugins
        COMMAND mkdir -p ${OUTPUT_DIR}/bin/panda/plugins/ && cp -p
            x86_64-softmmu/panda/plugins/panda_reven_icount.so
            x86_64-softmmu/panda/plugins/panda_reven_memory_history.so
            x86_64-softmmu/panda/plugins/panda_reven_tracer_bin.so
            x86_64-softmmu/panda/plugins/panda_reven_metadata.so
            x86_64-softmmu/panda/plugins/panda_reven_blocks.so
            ${OUTPUT_DIR}/bin/panda/plugins/
        WORKING_DIRECTORY <BINARY_DIR>
        DEPENDEES build
        ALWAYS 0
    )

    # Step to cleanup the mess after the build / install
    ExternalProject_Add_Step(panda cleanup
        COMMAND find <BINARY_DIR>/.. -type d -empty -delete
        DEPENDEES install
        ALWAYS 0
    )

    # panda's tests are broken

    # Clean the submodule
    add_custom_target(clean-panda)

    add_custom_target(clean-panda-stamps
        COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/panda-*
        COMMENT "Deleting panda stamps"
    )
    add_dependencies(clean-panda clean-panda-stamps)

    add_custom_target(clean-panda-build
        COMMAND ${real_make_command} -C ${PANDA_BINARY_DIR} clean
        COMMENT "Make clean in panda"
    )
    add_dependencies(clean-panda clean-panda-build)

    add_dependencies(clean-submodules clean-panda)
endif()

#########
# Bochs #
#########

if(BUILD_BOCHS)
    # Build the submodule
    ExternalProject_Add(bochs
        DEPENDS rvnbintrace rvnmemhistwriter rvnsqlite rvnsyncpoint rvncorevirtualbox
        PREFIX ${CMAKE_BINARY_DIR}/bochs
        STAMP_DIR ${STAMPS_DIR}
        SOURCE_DIR ${CMAKE_SOURCE_DIR}/bochs
        INSTALL_DIR ${OUTPUT_DIR}
        BUILD_ALWAYS ${BUILD_ALWAYS}

        CONFIGURE_COMMAND
            export CC=${CMAKE_C_COMPILER} &&
            export CXX=${CMAKE_CXX_COMPILER} &&
            export LDFLAGS=-L${OUTPUT_DIR}/lib &&
            export CFLAGS=-O3 &&
            export CXXFLAGS=-I${OUTPUT_DIR}/include\ -O3 &&
            <SOURCE_DIR>/configure
                --prefix=${OUTPUT_DIR}
                --enable-x86-64
                --enable-x86-debugger
                --enable-fast-function-calls
                --enable-all-optimizations
                --enable-protection-keys
                --enable-fpu
                --enable-avx
                --enable-evex
                --enable-trace-linking
                --enable-debugger
                --enable-vmx=2
                --enable-smp
                --enable-instrumentation="instrument/stubs"
                --enable-show-ips=no
                --with-nogui

        # `make install` in Bochs MUST NOT be multithreaded
        INSTALL_COMMAND make install
    )
    add_dependencies(universe bochs)

    ExternalProject_Get_Property(bochs BINARY_DIR)
    set(BOCHS_BINARY_DIR ${BINARY_DIR})

    ExternalProject_Get_Property(bochs SOURCE_DIR)
    set(BOCHS_SOURCE_DIR ${SOURCE_DIR})

    # bochs doesn't have tests

    # Clean the submodule
    add_custom_target(clean-bochs)

    add_custom_target(clean-bochs-stamps
        COMMAND ${CMAKE_COMMAND} -E remove ${STAMPS_DIR}/bochs-*
        COMMENT "Deleting bochs stamps"
    )
    add_dependencies(clean-bochs clean-bochs-stamps)

    add_custom_target(clean-bochs-build
        COMMAND ${real_make_command} -C ${BOCHS_BINARY_DIR} all-clean
        COMMENT "Make clean in bochs"
    )
    add_dependencies(clean-bochs clean-bochs-build)

    add_dependencies(clean-submodules clean-bochs)
endif()

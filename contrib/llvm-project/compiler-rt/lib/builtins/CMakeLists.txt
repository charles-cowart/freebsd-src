# Minimal CMake configuration for compiler-rt builtins on FreeBSD.
# Architecture-specific directories included; RISC-V support removed.

add_subdirectory(aarch64)
add_subdirectory(arm)
add_subdirectory(avr)
add_subdirectory(hexagon)
add_subdirectory(i386)
add_subdirectory(loongarch)
add_subdirectory(ppc)
add_subdirectory(sparc64)
add_subdirectory(ve)
add_subdirectory(x86_64)

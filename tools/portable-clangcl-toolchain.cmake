# Portable toolchain: clang-cl + lld-link + xwin-splatted Windows SDK/CRT,
# for building without a system-installed Visual Studio and without admin
# rights. Header/lib search paths are provided via the INCLUDE/LIB
# environment variables (set by tools/portable-build-env.ps1), exactly as a
# real "x64 Native Tools Command Prompt" would, so clang-cl picks them up
# automatically.
#
# Intended to be chain-loaded from the vcpkg toolchain:
#   -DCMAKE_TOOLCHAIN_FILE=<buildenv>/scripts/buildsystems/vcpkg.cmake
#   -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=tools/portable-clangcl-toolchain.cmake

set(LLVM_ROOT "C:/bin/llvm" CACHE PATH "Portable LLVM/clang-cl root")

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR AMD64)

set(CMAKE_C_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")
set(CMAKE_CXX_COMPILER "${LLVM_ROOT}/bin/clang-cl.exe")
set(CMAKE_LINKER "${LLVM_ROOT}/bin/lld-link.exe")
set(CMAKE_RC_COMPILER "${LLVM_ROOT}/bin/llvm-rc.exe")
set(CMAKE_MT "${LLVM_ROOT}/bin/llvm-mt.exe")
set(CMAKE_AR "${LLVM_ROOT}/bin/llvm-lib.exe")

set(CMAKE_C_COMPILER_TARGET x86_64-pc-windows-msvc)
set(CMAKE_CXX_COMPILER_TARGET x86_64-pc-windows-msvc)

# Make clang-cl report the same _MSC_VER as the MSVC 14.44 (VS2022, toolset
# 143) headers/libs it is actually compiling against. Without this, clang-cl
# defaults to emulating _MSC_VER 1929 (VS2019, toolset 142), which Mixxx's
# CMakeLists rejects, and which would also mismatch the vcpkg deps' ABI.
string(APPEND CMAKE_C_FLAGS_INIT " -fmsc-version=1944")
string(APPEND CMAKE_CXX_FLAGS_INIT " -fmsc-version=1944")

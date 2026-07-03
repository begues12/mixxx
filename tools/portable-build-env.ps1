# Sets up a portable Windows build environment for Mixxx using clang-cl +
# lld-link + an xwin-splatted Windows SDK/CRT, requiring no admin rights and
# no installed Visual Studio. Dot-source this script, then run cmake/ninja:
#
#   . .\tools\portable-build-env.ps1
#   cmake --preset portable        # (or the explicit cmake line printed below)
#   cmake --build build
#
# Adjust the *_VER variables below if you extracted different SDK/MSVC versions.

$ErrorActionPreference = "Stop"

$LlvmRoot   = "C:\bin\llvm"
$Sdk        = "C:\bin\winsdk"
$CMakeBin   = "C:\bin\cmake\bin"
$NinjaBin   = "C:\bin\ninja"

# Detect the (single) MSVC and Windows Kit versions that xwin splatted.
$MsvcVer = (Get-ChildItem "$Sdk\VC\Tools\MSVC" -Directory | Select-Object -First 1).Name
$KitVer  = (Get-ChildItem "$Sdk\Windows Kits\10\Include" -Directory | Select-Object -First 1).Name
$Msvc    = "$Sdk\VC\Tools\MSVC\$MsvcVer"
$Kit     = "$Sdk\Windows Kits\10"

$env:INCLUDE = @(
    "$Msvc\include"
    "$Kit\Include\$KitVer\ucrt"
    "$Kit\Include\$KitVer\um"
    "$Kit\Include\$KitVer\shared"
    "$Kit\Include\$KitVer\winrt"
    "$Kit\Include\$KitVer\cppwinrt"
) -join ';'

$env:LIB = @(
    "$Msvc\lib\x64"
    "$Kit\Lib\$KitVer\ucrt\x64"
    "$Kit\Lib\$KitVer\um\x64"
) -join ';'

$env:PATH = @(
    "$LlvmRoot\bin"
    $NinjaBin
    $CMakeBin
    "$Kit\bin\$KitVer\x64"
    $env:PATH
) -join ';'

# Mixxx build environment (vcpkg prebuilt dependencies).
$MixxxRoot = Split-Path $PSScriptRoot -Parent
$env:MIXXX_VCPKG_ROOT = "$MixxxRoot\buildenv\mixxx-deps-2.6-x64-windows-aa78b5a"
$env:VCPKG_TARGET_TRIPLET = "x64-windows"
$env:CMAKE_GENERATOR = "Ninja"

Write-Host "Portable build env ready:" -ForegroundColor Green
Write-Host "  MSVC $MsvcVer, Windows SDK $KitVer, clang-cl @ $LlvmRoot"
Write-Host "  MIXXX_VCPKG_ROOT = $env:MIXXX_VCPKG_ROOT"
Write-Host ""
Write-Host "Configure with:" -ForegroundColor Cyan
Write-Host "  cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo ``"
Write-Host "    -DCMAKE_TOOLCHAIN_FILE=`"$env:MIXXX_VCPKG_ROOT\scripts\buildsystems\vcpkg.cmake`" ``"
Write-Host "    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=`"$MixxxRoot\tools\portable-clangcl-toolchain.cmake`" ``"
Write-Host "    -DVCPKG_TARGET_TRIPLET=x64-windows"

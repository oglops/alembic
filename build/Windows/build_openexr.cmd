@echo off
setlocal

if NOT "%ALEMBIC_ROOT%" == "" if NOT "%ALEMBIC_OUT%" == "" goto AlembicDefined
echo ALEMBIC_ROOT and ALEMBIC_OUT must be defined!!!
goto :eof
:AlembicDefined

if /i "%1" == "db:" (
	set DB=_db
	set config=Debug
	shift
) ELSE (
	set DB=
	set config=Release
)

if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	set SYS=i64
	set arch=x64
) ELSE (
	set SYS=x86
	set arch=Win32
)

set srcRoot=%ALEMBIC_ROOT%\contrib\%OPENEXR_VER%

@echo on

pushd %srcRoot%
IF exist build (
	rmdir /S /Q build
)
md build & cd build

:: need to have zlib and half.dll
set "PATH=%ALEMBIC_OUT%\%ILMBASE_VER%\lib;%PATH%"
cmake -DCMAKE_INSTALL_PREFIX=%ALEMBIC_OUT%\%OPENEXR_VER% -DBUILD_SHARED_LIBS=off -DDISABLE_WARNING="/W1 /wd4244 /wd4267 /wd4018 /wd4800 /wd4996 /wd4819" -G %BUILD_GENERATOR% -DZLIB_ROOT=%ALEMBIC_OUT%\%ZLIB_VER% -DILMBASE_PACKAGE_PREFIX=%ALEMBIC_OUT%\%ILMBASE_VER% ..
msbuild   %srcRoot%\build\zlib.sln /p:Configuration=Release;Platform=%ARCH% /m
msbuild   %srcRoot%\build\INSTALL.vcxproj /p:Configuration=Release;Platform=%ARCH%


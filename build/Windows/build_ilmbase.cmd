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

REM ***************************************************************
REM IlmBase SLN & VCPROJ files *must* be modified for static libs
REM ***************************************************************

set srcRoot=%ALEMBIC_ROOT%\contrib\%ILMBASE_VER%


@echo off

pushd %srcRoot%
IF exist build (
	rmdir /S /Q build
)
md build & cd build

cmake -DCMAKE_INSTALL_PREFIX=%ALEMBIC_OUT%\%ILMBASE_VER% -DBUILD_SHARED_LIBS=off -DDISABLE_WARNING="/W1 /wd4244 /wd4305 /wd4530" -G %BUILD_GENERATOR% ..

msbuild   ilmbase.sln /p:Configuration=Release;Platform=%ARCH% /m
msbuild   INSTALL.vcxproj  /p:Configuration=Release;Platform=%ARCH%


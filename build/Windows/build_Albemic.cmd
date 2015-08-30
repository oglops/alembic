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
	set config=RelWithDebInfo
)

if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
	set SYS=i64
	set arch=x64
) ELSE (
	set SYS=x86
	set arch=Win32
)

::set buildArg="%config%|%arch%"
::set outDir=%ALEMBIC_OUT%\%SYS%
set srcRoot=%ALEMBIC_ROOT%\..\alembic_build
set srcDir=%srcRoot%

@echo on

pushd %srcDir%

msbuild   ALEMBIC.sln /p:Configuration=Release;Platform=%ARCH% /m 
msbuild INSTALL.vcxproj /p:Configuration=Release;Platform=%ARCH%

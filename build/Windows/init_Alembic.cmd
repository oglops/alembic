@echo off

if NOT "%ALEMBIC_ROOT%" == "" if NOT "%ALEMBIC_OUT%" == "" goto AlembicDefined
echo ALEMBIC_ROOT and ALEMBIC_OUT must be defined!!!
goto :eof
:AlembicDefined

setlocal
if /i "%1" == "db:" (
	set DB=_db
	shift
) ELSE (
	set DB=
)



::set luxSrc=U:\Luxology\source

::set rootOut=%ALEMBIC_OUT%
::set platOut=%rootOut%\%SYS%

::set BOOST_ROOT=%rootOut%\boost
::set ILMBASE_ROOT=%platOut%\IlmBase
::set OPENEXR_ROOT=%ALEMBIC_ROOT%\contrib\openexr-1.6.1

::set HDF5_ROOT=%ALEMBIC_ROOT%\contrib\hdf5-1.8.9\src
::set MAYA_ROOT=%ALEMBIC_ROOT%\contrib\maya2011

REM ******************************************************************************************
REM We always use the MT libraries, so comment out the next line if you want MTd libs for debug
REM ******************************************************************************************
::set Luxology_flags=/MT /U _DEBUG
set Luxology_flags=/MT /U 

REM ******************************************************************************************
REM Corrections to vars in bootstrap script
REM ******************************************************************************************
set warnFlags=/W1 /wd4267 /wd4800 /wd4018 /wd4244  /wd4251 /wd4819 /wd4150 /wd4005 %Luxology_flags%
set ccflags=%warnFlags% /D_WINDOWS /W3 /Zm1000
set cppflags=%ccflags% /EHsc /GR

::set BASE_ARGS= --with-maya=%MAYA_ROOT% --generator=%BUILD_GENERATOR%
set BASE_ARGS= --enable-pyalembic --generator=%BUILD_GENERATOR%

set HDF_ARGS=--hdf5_include_dir=%LOCAL_ROOT%\%HDF_VER%\include --hdf5_hdf5_library=%LOCAL_ROOT%\%HDF_VER%\lib\hdf5.lib 


:: in ilmbase it is named as Imath-2_2.lib
set "IMATHLIB_SUFFIX="
IF NOT "_%ILMBASE_LIB_SUFFIX%_"=="__" (
	set "IMATHLIB_SUFFIX=-%ILMBASE_LIB_SUFFIX%"
)


set ILM_ARGS=--ilmbase_include_dir=%ALEMBIC_OUT%\%ILMBASE_VER%\include\OpenEXR --ilmbase_imath_library=%ALEMBIC_OUT%\%ILMBASE_VER%\lib\Imath%IMATHLIB_SUFFIX%.lib --pyilmbase_include_dir=%ALEMBIC_OUT%\%PYILMBASE_VER%\include --pyilmbase_pyimath_library=%ALEMBIC_OUT%\%PYILMBASE_VER%\lib\PyImath.lib --pyilmbase_pyimath_module=%ALEMBIC_OUT%\%PYILMBASE_VER%\lib\python2.7\site-packages\imathmodule.lib 

set BOOST_ARGS=--boost_include_dir=%LOCAL_ROOT%\%BOOST_VER% --boost_thread_library=%LOCAL_ROOT%\%BOOST_VER%\%BOOST_LIB_VER%\boost_thread-%BOOST_VC_VER%-mt-%BOOST_VER_NUM%.lib --boost_python_library=%LOCAL_ROOT%\%BOOST_VER%\%BOOST_LIB_VER%\boost_python-%BOOST_VC_VER%-mt-%BOOST_VER_NUM%.lib

set ZLIB_ARGS=--zlib_include_dir=%ALEMBIC_OUT%\%ZLIB_VER%\include --zlib_library=%ALEMBIC_OUT%\%ZLIB_VER%\lib\zlib.lib

:: additional args such as --with-maya --with-prman --with-arnold
set ADDITIONAL_ARGS="" ::--with-maya="%MAYA_ROOT%"

:: set alembic_build folder in the same level as ALEMBIC_ROOT
for %%i in ("%ALEMBIC_ROOT%\..") do set "folder=%%~fi"
set ALEMBIC_BUILD_DIR=%folder%\alembic_build

@echo on
::set "INCLUDE=;%LOCAL_ROOT%\extra\include;%INCLUDE%"
::set "LIB=%LOCAL_ROOT%\extra\lib;%LIB%"

:: this env var will be used by findilmbase.cmake
set ILMBASE_ROOT=%LOCAL_ROOT%\%ILMBASE_VER%


pushd %ALEMBIC_ROOT%
rmdir /S /Q %ALEMBIC_BUILD_DIR% 
python %ALEMBIC_ROOT%\build\bootstrap\alembic_bootstrap.py %BASE_ARGS% %HDF_ARGS% %ILM_ARGS% %BOOST_ARGS% %ZLIB_ARGS% %ADDITIONAL_ARGS% --cflags="%ccflags%" --cxxflags="%cppflags%" %ALEMBIC_BUILD_DIR% 

::python %ALEMBIC_ROOT%\build\bootstrap\alembic_bootstrap.py %BASE_ARGS% %HDF_ARGS% %ILM_ARGS% %BOOST_ARGS% %ZLIB_ARGS% %ALEMBIC_BUILD_DIR% 

popd


::rmdir /S /Q D:\source\test\alembic_build & python D:\source\test\alembic-1_05_08\build\bootstrap\alembic_bootstrap.py  

::--zlib_include_dir=D:\xx\include --zlib_library=D:\xx\lib\zlibwapi.lib 

::--boost_include_dir=C:\local\boost_1_55_0  
::--boost_thread_library=C:\local\boost_1_55_0\lib64-msvc-11.0\libboost_thread-vc110-mt-1_55.lib 
::--boost_python_library=C:\local\boost_1_55_0\lib64-msvc-11.0\libboost_python-vc110-mt-1_55.lib 

::--generator="Visual Studio 11 Win64" 

::--hdf5_include_dir=D:\source\alembic-1_05_08\contrib\hdf5-1.8.5-patch1\include 
::--hdf5_hdf5_library=D:\source\alembic-1_05_08\contrib\hdf5-1.8.5-patch1\lib\hdf5.lib 

::--ilmbase_include_dir=D:\xxx\include 
::--ilmbase_imath_library=D:\xxx\lib\Imath-2_2.lib 

::--pyilmbase_include_dir=D:\xxxx_pyilmbase\include 
::--pyilmbase_pyimath_library=D:\xxxx_pyilmbase\lib\PyImath.lib 
::--pyilmbase_pyimath_module=D:\xxxx_pyilmbase\lib\python2.7\site-packages\imathmodule.lib 
::--enable-pyalembic D:\source\test\alembic_build
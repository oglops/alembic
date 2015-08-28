##-*****************************************************************************
##
## Copyright (c) 2009-2015,
##  Sony Pictures Imageworks Inc. and
##  Industrial Light & Magic, a division of Lucasfilm Entertainment Company Ltd.
##
## All rights reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are
## met:
## *       Redistributions of source code must retain the above copyright
## notice, this list of conditions and the following disclaimer.
## *       Redistributions in binary form must reproduce the above
## copyright notice, this list of conditions and the following disclaimer
## in the documentation and/or other materials provided with the
## distribution.
## *       Neither the name of Industrial Light & Magic nor the names of
## its contributors may be used to endorse or promote products derived
## from this software without specific prior written permission.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
## A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
## OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
## LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
## DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
## THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##
##-*****************************************************************************

# If you know the HDF5 root and there aren't any default versions of HDF5 in
# the default system paths use:
# cmake '-UHDF5_*' -DHDF5_ROOT:STRING=<path/to/hdf5> .
#
# For more info:
# cmake --help-module FindHDF5

#-******************************************************************************
# FindHDF5 uses these as hints about search locations
#-******************************************************************************
message("========================= in AlembicHDF5.cmake =========================")
file(TO_CMAKE_PATH "$ENV{LOCAL_ROOT}" LOCAL_ROOT_CMAKE)
set (HDF5_ROOT "${LOCAL_ROOT_CMAKE}/$ENV{HDF_VER}")
# set(ENV{HDF5_DIR} "${HDF5_ROOT}/cmake/hdf5")

IF (DEFINED HDF5_ROOT)
    MESSAGE(STATUS "Using HDF5_ROOT: ${HDF5_ROOT}")
    # set HDF5_ROOT in the env so FindHDF5.cmake can find it
    SET(ENV{HDF5_ROOT} ${HDF5_ROOT})
ENDIF()

#-******************************************************************************
# Find HDF5
#-******************************************************************************

SET(HDF5_USE_STATIC_LIBRARIES ${USE_STATIC_HDF5})

FIND_PACKAGE(HDF5 COMPONENTS C HL)

#-******************************************************************************
# Wrap it all up
#-******************************************************************************

IF (HDF5_FOUND)
    SET(ALEMBIC_HDF5_LIB ${HDF5_C_LIBRARIES})
    SET(ALEMBIC_HDF5_HL_LIB ${HDF5_CXX_LIBRARIES})

    # windows returns dll? 
    list(GET HDF5_LIBRARIES 0 ALEMBIC_HDF5_LIB )
    list(GET HDF5_LIBRARIES 1 ALEMBIC_HDF5_HL_LIB)   
    STRING(REGEX REPLACE "bin/hdf5.dll" "lib/hdf5.lib"  ALEMBIC_HDF5_LIB  ${ALEMBIC_HDF5_LIB} )
    STRING(REGEX REPLACE "bin/hdf5_hl.dll" "lib/hdf5_hl.lib"  ALEMBIC_HDF5_HL_LIB ${ALEMBIC_HDF5_HL_LIB})
    set(ALEMBIC_HDF5_LIBS ${ALEMBIC_HDF5_LIB} ${ALEMBIC_HDF5_HL_LIB})
    set(HDF5_LIBRARIES ${ALEMBIC_HDF5_LIBS} )

    MESSAGE(STATUS "HDF5_INCLUDE_DIRS: ${HDF5_INCLUDE_DIRS}")
    MESSAGE(STATUS "HDF5_LIBRARIES: ${HDF5_LIBRARIES}")
ELSE()
    MESSAGE(STATUS "HDF5 not found.")
ENDIF()


message("HDF5_CXX_LIBRARIES:${HDF5_CXX_LIBRARIES}")
message("HDF5_C_LIBRARIES:${HDF5_C_LIBRARIES}")
message("HDF5_ROOT:${HDF5_ROOT}")
#message("LOCAL_ROOT:${LOCAL_ROOT}")
#message("HDF_VER:${HDF_VER}")
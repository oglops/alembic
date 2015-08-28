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

FIND_PACKAGE(PyIlmBase)

IF (PYILMBASE_FOUND)
    SET(ALEMBIC_PYILMBASE_INCLUDE_DIRECTORY ${ALEMBIC_PYILMBASE_INCLUDE_DIRECTORY})
    SET(ALEMBIC_PYILMBASE_LIBRARIES ${ALEMBIC_PYILMBASE_LIBS})
    SET(ALEMBIC_PYILMBASE_FOUND 1 CACHE STRING "Set to 1 if PyIlmBase is found, 0 otherwise")
ELSE()
    SET(ALEMBIC_PYILMBASE_FOUND 0 CACHE STRING "Set to 1 if PyIlmBase is found, 0 otherwise")
ENDIF()


message("========================= in AlembicPyIlmBase.cmake =========================")
message("ALEMBIC_PYILMBASE_INCLUDE_DIRECTORY:${ALEMBIC_PYILMBASE_INCLUDE_DIRECTORY}")
message("ALEMBIC_PYILMBASE_FOUND:${ALEMBIC_PYILMBASE_FOUND}")
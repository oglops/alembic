"""A setuptools based setup module.
See:
https://packaging.python.org/en/latest/distributing.html
https://github.com/pypa/sampleproject
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages
# To use a consistent encoding
from codecs import open
from os import path
import os,sys

here = path.abspath(path.dirname(__file__))

# Get the long description from the relevant file
with open(path.join(here, 'DESCRIPTION.rst'), encoding='utf-8') as f:
    long_description = f.read()

alembic_out_dir=os.environ['ALEMBIC_OUT']
local_root_dir=os.environ['LOCAL_ROOT']

pyilmbbase_lib_dir=os.path.join(alembic_out_dir,os.environ['PYILMBASE_VER'],'lib')
python_ver_str='python%s' % '.'.join(str(s) for s in sys.version_info[:2])
pyilmbbase_module_dir=os.path.join(pyilmbbase_lib_dir,python_ver_str,'site-packages')
boost_lib_dir=os.path.join(local_root_dir,os.environ['BOOST_VER'],'lib64-msvc-11.0')
alembic_lib_dir=os.path.join(alembic_out_dir,os.environ['ALEMBIC_VER'],'lib')

data_files=[os.path.join(pyilmbbase_lib_dir,'PyIex.dll'),
            os.path.join(pyilmbbase_lib_dir,'PyImath.dll'),
            os.path.join(pyilmbbase_module_dir,'iex.pyd'),
            os.path.join(pyilmbbase_module_dir,'imath.pyd'),
            os.path.join(pyilmbbase_module_dir,'imathnumpy.pyd'),
            os.path.join(boost_lib_dir,'boost_python-vc110-mt-1_55.dll'),
            os.path.join(alembic_lib_dir,'alembic.pyd'),
            os.path.join(alembic_lib_dir,'alembicgl.pyd'),
            os.path.join(alembic_lib_dir,'Alembic.dll'),
            os.path.join(alembic_lib_dir,'AlembicAbcOpenGL.dll'),
            ]

setup(
    name='PyAlembic',

    # Versions should comply with PEP440.  For a discussion on single-sourcing
    # the version across setup.py and the project code, see
    # https://packaging.python.org/en/latest/single_source_version.html
    version='1.5.8',

    description='PyAlembic for windows prebuilt binary',
    long_description=long_description,

    # The project's main homepage.
    url='https://github.com/oglops/alembic',

    # Author details
    author='The Tree Widget Guy',
    author_email='oglops@gmail.com',

    # Choose your license
    license='MIT',

    # See https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        # How mature is this project? Common values are
        #   3 - Alpha
        #   4 - Beta
        #   5 - Production/Stable
        'Development Status :: 3 - Alpha',

        # Indicate who your project is intended for
        'Intended Audience :: Developers',
        'Topic :: PyQT Development :: Alembic Related Tools',

        # Pick your license as you wish (should match "license" above)
        'License :: OSI Approved :: MIT License',

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        'Programming Language :: Python :: 2.7',

    ],

    # What does your project relate to?
    keywords='Alembic PyQT',

    # You can just specify the packages manually here if your project is
    # simple. Or you can use find_packages().
    # packages=find_packages(
    #     exclude=['contrib', 'docs', 'tests*']),

    # List run-time dependencies here.  These will be installed by pip when
    # your project is installed. For an analysis of "install_requires" vs pip's
    # requirements files see:
    # https://packaging.python.org/en/latest/requirements.html
    # install_requires=['peppercorn'],

    # List additional groups of dependencies here (e.g. development
    # dependencies). You can install these using the following syntax,
    # for example:
    # $ pip install -e .[dev,test]
    # extras_require={
    #     'dev': ['check-manifest'],
    #     'test': ['coverage'],
    # },

    # If there are data files included in your packages that need to be
    # installed, specify them here.  If using Python 2.6 or less, then these
    # have to be included in MANIFEST.in as well.
    # package_data={
    #     'sample': ['package_data.dat'],
    #     #'dlls':[r'C:\localx\PyIlmBase-2.2.0\lib\PyIex.dll'],
    # },

    # Although 'package_data' is the preferred approach, in some case you may
    # need to place data files outside of your packages. See:
    # http://docs.python.org/3.4/distutils/setupscript.html#installing-additional-files # noqa
    # In this case, 'data_file' will be installed into '<sys.prefix>/my_data'
    data_files=#[('my_data', ['data/data_file'])]
    data_files,

    # To provide executable scripts, use entry points in preference to the
    # "scripts" keyword. Entry points provide cross-platform support and allow
    # pip to create the appropriate form of executable for the target platform.
    # entry_points={
    #     'console_scripts': [
    #         'sample=sample:main',
    #     ],
    # },
)
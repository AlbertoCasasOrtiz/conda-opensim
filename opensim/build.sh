#!/bin/bash

# TODO: Dependencies should be separate packages...
mkdir opensim_dependencies_build
cd opensim_dependencies_build
cmake ../dependencies/ -LAH \
      -DCMAKE_INSTALL_PREFIX="$PREFIX" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10 \
      -DSUPERBUILD_ezc3d=ON \
      -DSUPERBUILD_adolc=OFF \
      -DSUPERBUILD_casadi=OFF \
      -DSUPERBUILD_colpack=OFF \
      -DSUPERBUILD_ipopt=OFF
make -j8
cd ..

cp -r $PREFIX/simbody/libexec/simbody/* $PREFIX/bin/

# TODO: Tests are missing!
mkdir opensim_build
cd opensim_build
cmake ../ \
      -DCMAKE_INSTALL_PREFIX="$PREFIX" \
      -DCMAKE_BUILD_TYPE=Release \
      -DOPENSIM_DEPENDENCIES_DIR="$PREFIX" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10 \
      -DBUILD_PYTHON_WRAPPING=ON \
      -DOPENSIM_DISABLE_LOG_FILE=ON \
      -DOPENSIM_PYTHON_CONDA=ON \
      -DOPENSIM_C3D_PARSER=ezc3d \
      -DBUILD_TESTING=OFF \
      -DTROPTER_WITH_SNOPT=OFF \
      -DTROPTER_WITH_OPENMP=OFF \
      -DOPENSIM_WITH_TROPTER=OFF \
      -DOPENSIM_WITH_CASADI=OFF
make -j8
make install

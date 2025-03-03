
# Remove existing installs
pip uninstall -y decord || true
[[ -d ./build ]] && rm -r ./build

# Make the C++ stuff
mkdir build && cd build
cmake .. -DUSE_CUDA=0 -DCMAKE_BUILD_TYPE=Debug -DFFMPEG_DIR=$FFMPEG
cmake --build . --parallel 16

# Install python bindings
cd ..
# install with setuptools
python setup.py install --user bdist_wheel
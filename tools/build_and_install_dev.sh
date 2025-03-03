
# Remove existing installs
pip uninstall -y decord || true
[[ -d ./build ]] && rm -r ./build

# Make the C++ stuff
mkdir build && cd build
cmake .. -DUSE_CUDA=0 -DCMAKE_BUILD_TYPE=Debug -DFFMPEG_DIR=$FFMPEG
cmake --build . --parallel 16

# Install python bindings
cd ../python
# option 1: add python path to $PYTHONPATH, you will need to install numpy separately
pwd=$PWD
echo "PYTHONPATH=$PYTHONPATH:$pwd" >> ~/.bashrc
source ~/.bashrc
# option 2: install with setuptools
python setup.py install --user bdist_wheel
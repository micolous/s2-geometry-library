#!/bin/sh -x
# Continuous integration script for Travis

# Add flags for openssl and Python on osx
if [ "${TRAVIS_OS_NAME}" == "osx" ]; then
	export OPENSSL_ROOT_DIR="/usr/local/opt/openssl"
    if [ "${OPENSSL_VER}" == "1.1" ]; then
	    export OPENSSL_ROOT_DIR="/usr/local/opt/openssl@1.1"
    fi
	export PATH="/usr/bin:${PATH}"
fi

# Build the library and install it.
echo "## Building and installing libs2..."
cd geometry
cmake .
make -j3
sudo make install

if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
	sudo ldconfig -v | grep libs2
fi

# Build and run the C++ tests
echo "## Building and running the C++ tests..."
cd tests
cmake .
make -j3
./tests || exit 1

if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
	# We really want to use the system version of Python.  Travis'
	# has broken distutils paths, and assumes a virtualenv.
	PATH="/usr/bin:${PATH}"
	which python2.7
	python2.7 -V
fi

# Build and install the Python bindings
echo "## Building and installing the Python bindings..."
cd ../python
cmake .
make VERBOSE=1
sudo make install VERBOSE=1

# Run extra debug for OSX
if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
	otool -L _s2.so

	# Handle System Integrity Protection
	for l in s2 s2cellid s2util
	do
		otool -L /usr/local/lib/lib${l}.dylib
		install_name_tool -change "@rpath/lib${l}.dylib" "/usr/local/lib/lib${l}.dylib" "_s2.so"
	done

	otool -L _s2.so
fi

# Run the Python tests
echo "## Running the Python tests..."
python2.7 -v -c 'import s2'
python2.7 test.py || exit 1


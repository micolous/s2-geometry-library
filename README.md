# s2-geometry-library

**Not maintained anymore. Please use upstream fork
https://github.com/yjwong/s2-geometry-library.**


[![Build Status](https://travis-ci.org/micolous/s2-geometry-library.svg?branch=master)](https://travis-ci.org/micolous/s2-geometry-library)

* License: Apache 2.0 (see `COPYING`)
* Upstream: https://code.google.com/archive/p/s2-geometry-library/ (unmaintained)
* With fixes from [micolous](https://github.com/micolous/), [silicontrip](https://github.com/silicontrip/) and [yjwong](https://github.com/yjwong/).
* Presentation: https://docs.google.com/presentation/d/1Hl4KapfAENAOf4gv-pSngKwvS_jwNVHRPZTTDzXXn6Q/view?pli=1
* Documentation: none provided by upstream, read the presentation; other ports have better documentation


This package has Python bindings which target Python 2.7.  You can also use it as a C++ library.

In Python code, `import s2`.

## Dependencies

You'll need the development (-dev or -devel) versions of these libraries in order to build the library.

- OpenSSL (used for [BIGNUM](https://www.openssl.org/docs/manmaster/crypto/bn.html) functions)

You'll need these build-time dependencies:

- CMake 3.1 or later
- SWIG (must be `swig` in your PATH)

A C++ compiler supporting C++11 (g++ 4.8 or later, clang 3.3 or later) is also required.

### Mac OS X specific notes

Make sure you are using python.org Python, and that it is the default in your path (not Apple's Python or Macports Python).

Other dependencies will need to be installed with MacPorts using the `+universal` build flag.

Make sure `/opt/local/bin` and `/Library/Frameworks/Python.framework/Versions/2.7/bin` are not only listed in `$PATH`, but also in `/etc/paths` before `/usr/bin` (otherwise Python bindings will fail to build).

## Building
### The Linux From Scratch way (also for OSX)

```console
cd geometry
cmake .
make -j3
sudo make install
```

Then to install Python 2.7 bindings:

```console
cd python
cmake .
make
sudo make install
```


### As a Debian package

This is currently broken, and needs to be ported to cmake.

```console
apt-get install python-dev debhelper libgflags-dev cdbs swig build-essential fakeroot autoconf libtool pkg-config
./autogen.sh
pushd ..
tar jcf s2_1.0.0.orig.tar.bz2 s2-geometry-library/ --exclude=.git
popd
dpkg-buildpackage -rfakeroot
```

## Installing the Debian package

Once built:

```console
dpkg -i ../libs2*.deb ../python-s2*.deb
```

## Running the tests (Python)

```console
python test.py
```


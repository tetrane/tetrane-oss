# Tetrane OSS

Open Source Software modified or written by Tetrane https://www.tetrane.com for the REVEN product.

## Content

This repository uses submodules to provide a dependency aware build and keep track of software versions used by REVEN releases.

### Common

Tetrane libraries used by PANDA plugins and Bochs to generate execution traces for REVEN.

### PANDA

Forked from https://github.com/panda-re/panda

Modified replay callbacks to enable plugins to generate a REVEN-compatible trace.

- PANDA can be built standalone.
- reven-panda-plugins depends on the common/rvn* libs.

### VirtualBox

Forked from https://www.virtualbox.org/

Modified to record a trace composed of the initial state and hardware events.

Can be built standalone.

### Bochs

Forked from http://bochs.sourceforge.net

Replays a trace recorded by Virtualbox to generate a REVEN-compatible trace.

Depends on common/rvn* libs.

## Build

Build is only supported for Debian Buster.

One can use the `.gitlab-ci.yml` file as a reference for building.

Common dependencies:

- python3 # used by installer.py to install build dependencies
- build-essential
- cmake
- ninja-build

More dependencies are installed by the `installer.py` script.

```
apt install build-essential cmake ninja-build python3 wget
wget https://github.com/tetrane/dependencies_installer/raw/master/installer.py
python3 installer.py .
mkdir build && cd build
cmake -G Ninja ..
ninja
```

Build artifacts are produced in the `output/` directory.

## License

- Bochs is licensed under the GNU LGPL
- PANDA is licensed under the GPLv2
- virtualbox is licenced under the GPLv2
- common/ modules are licensed under either of GPLv2 or MIT X11 derived 
Tetrane's license at your option

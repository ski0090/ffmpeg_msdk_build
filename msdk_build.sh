export PKG_CONFIG_PATH=~/msdk/lib/x86_64-linux-gnu/pkgconfig
export LD_LIBRARY_PATH=~/msdk/lib
export PREFIX=~/msdk

echo Getting all the dependencies...
sudo apt install -y autoconf \
automake \
build-essential \
cmake \
git-core \
libass-dev \
libfreetype6-dev \
libgnutls28-dev \
libmp3lame-dev \
libsdl2-dev \
libtool \
libva-dev \
libvdpau-dev \
libvorbis-dev \
libxcb1-dev \
libxcb-shm0-dev \
libxcb-xfixes0-dev \
meson \
ninja-build \
pkg-config \
texinfo \
wget \
yasm \
zlib1g-dev

sudo apt install libunistring-dev
sudo apt install nasm

echo Getting libx264...
sudo apt install libx264-dev

echo Getting libx265...
sudo apt install libx265-dev libnuma-dev

echo Getting libvpx...
sudo apt install libvpx-dev

echo Getting aac...
sudo apt install libfdk-aac-dev

echo Getting libopus...
sudo apt install libopus-dev

sudo apt install -y autoconf automake build-essential cmake git-core libass-dev libfreetype6-dev libgnutls28-dev libmp3lame-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev meson ninja-build pkg-config texinfo wget yasm zlib1g-dev

mkdir -pv ~/codes && cd ~/codes
echo "Build libva"
git clone https://github.com/intel/libva.git
cd ~/codes/libva/
git checkout 1333034
mkdir -pv build 
cd build
meson .. -Dprefix=$PREFIX -Dlibdir=lib/x86_64-linux-gnu
ninja
sudo ninja install
cd ~/codes

echo "Build libva-utils"
git clone https://github.com/intel/libva-utils.git
cd ~/codes/libva-utils
git checkout cdf39e1
meson build --prefix=$PREFIX
cd build
ninja
sudo ninja install
cd ~/codes

echo "Build gmmlib"
git clone https://github.com/intel/gmmlib.git
cd ~/codes/gmmlib
git checkout 506c8e1
mkdir build 
cd build
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release ..
make -j"$(nproc)"
sudo make install
cd ~/codes

echo "Build media-drive"
sudo apt install autoconf libtool libdrm-dev xorg xorg-dev openbox libx11-dev libgl1-mesa-glx libgl1-mesa-dev
git clone https://github.com/intel/media-driver.git
cd ~/codes/media-driver
git checkout e461c05
mkdir ~/codes/build_media
cd ~/codes/build_media
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX ../media-driver
make -j"$(nproc)"
sudo make install
cd ~/codes

echo "Build msdk"
git clone https://github.com/Intel-Media-SDK/MediaSDK.git msdk
cd ~/codes/msdk
git checkout d057770
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make -j"$(nproc)"
sudo make install
cd ~/codes

echo export PKG_CONFIG_PATH=$HOME/msdk/lib/x86_64-linux-gnu/pkgconfig:$HOME/msdk/lib/pkgconfig:$HOME/ffmpeg_build/lib/pkgconfig
echo export LD_LIBRARY_PATH=$HOME/msdk/lib
echo export PATH=$HOME/bin:$HOME/msdk/bin:$PATH
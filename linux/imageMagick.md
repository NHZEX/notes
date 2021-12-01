## 安装环境
```bash
DEV_IM_VER="7.1.0-16"
wget -c -t 5 https://download.imagemagick.org/ImageMagick/download/ImageMagick-${DEV_IM_VER}.tar.xz -O ImageMagick-${DEV_IM_VER}.tar.xz \
&& mkdir -p ./imageMagick \
&& tar -xvf ImageMagick-${DEV_IM_VER}.tar.xz -C ./imageMagick --strip-components=1 && cd ./imageMagick \
&& ./configure \
&& make clean \
&& make -j \
&& sudo make install \
&& sudo ldconfig /usr/local/lib
```
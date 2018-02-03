FROM ibmfunctions/action-nodejs-v8

RUN apt-get update \
&& apt-get install -y --no-install-recommends build-essential cmake \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir opencv \
&& cd opencv \
&& wget https://github.com/Itseez/opencv/archive/3.4.0.zip --no-check-certificate -O opencv-3.4.0.zip \
&& wget https://github.com/Itseez/opencv_contrib/archive/3.4.0.zip --no-check-certificate -O opencv_contrib-3.4.0.zip \
&& unzip opencv-3.4.0.zip \
&& unzip opencv_contrib-3.4.0.zip \
&& mkdir opencv-3.4.0/build \
&& cd opencv-3.4.0/build \
&& cmake -D CMAKE_BUILD_TYPE=RELEASE -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.0/modules -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF -D BUILD_opencv_apps=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. \
&& make -j 4 \
&& make install \
&& echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf \
&& ldconfig \
&& cd ../../../ \
&& rm -rf opencv \
&& apt-get purge -y build-essential \
&& apt-get autoremove -y --purge

RUN npm install opencv4nodejs

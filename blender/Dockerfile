FROM ubuntu:18.04
RUN apt-get update && apt-get install -y curl ca-certificates bzip2 \
    python3 \
    libavcodec-extra57 \
    libavdevice57 \
    libavformat57 \
    libavutil55 \
    libboost-locale1.65.1 \
    libfftw3-double3 \
    libfontconfig1 \
    libfreetype6 \
    libgcc1 \
    libgl1 \
    libglew2.0 \
    libglu1-mesa \
    libglu1 \
    libgomp1 \
    libilmbase12 \
    libjack-jackd2-0 \
    libjemalloc1 \
    libjpeg8 \
    libopenal1 \
    libopencolorio1v5 \
    libopenexr22 \
    libopenimageio1.7 \
    libopenjp2-7 \
    libopenvdb5.0 \
    libpcre3 \
    libpng16-16 \
    libpython3.6 \
    libsndfile1 \
    libspnav0 \
    libswscale4 \
    libtbb2 \
    libtiff5 \
    libx11-6 \
    libxfixes3 \
    libxi6 \
    libxml2 \
    libxxf86vm1 \
    zlib1g
RUN curl -o /tmp/blender.tar.bz2 -sSL https://mirror.clarkson.edu/blender/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2 && \
    mkdir -p /opt/blender && \
    cd /tmp && tar jxf blender.tar.bz2 --strip-components=1 -C /opt/blender && \
    rm -rf /tmp/blender*
RUN echo "PATH=$PATH:/opt/blender" >> /etc/profile
COPY master.blend /
COPY worker.blend /
COPY master.py /
COPY worker.py /
COPY run.sh /usr/local/bin/run
EXPOSE 8000
CMD ["/usr/local/bin/run"]

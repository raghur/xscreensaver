FROM ubuntu:focal as build

RUN apt update && \
    TZ=Asia/Kolkata DEBIAN_FRONTEND=noninteractive \
    apt install -y autotools-dev bc debhelper dh-autoreconf dpkg-dev fortune-mod intltool \
    libgl1-mesa-dev libgl-dev libglade2-dev libgle-dev libglu1-mesa-dev \
    xlibmesa-glu-dev  libglu-dev libgtk2.0-dev libjpeg-dev libpam0g-dev \
    libpng-dev libx11-dev libxext-dev libxinerama-dev libxml2-dev \
    libxmu-dev libxrandr-dev libxss-dev libxt-dev libxtst-dev libxxf86vm-dev \
    pkg-config quilt x11proto-core-dev xbitmaps xutils-dev
ADD . /xscreensaver
WORKDIR /xscreensaver
RUN ./configure && make -j 13 && \
    find * -perm -u+rwx -mmin -1 -type f |xargs tar -cvjf xscreensaver.tar.bz2


FROM scratch as export
COPY --from=build /xscreensaver/xscreensaver.tar.bz2 /bin


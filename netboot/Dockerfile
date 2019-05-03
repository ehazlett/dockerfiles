FROM ubuntu:18.10 as ipxe
RUN apt-get update && apt-get install -y --no-install-recommends git \
	build-essential \
	ca-certificates \
	curl \
	make \
	binutils \
	perl \
	liblzma-dev \
	mtools \
	genisoimage \
	syslinux
RUN git clone https://git.ipxe.org/ipxe.git && \
	cd ipxe/src && \
	make bin/undionly.kpxe

FROM ehazlett/terra-iso:latest as terra
FROM alpine:latest
ARG TERRA_VERSION
RUN apk add -U syslinux dnsmasq curl python
RUN mkdir /tftp && \
	cp /usr/share/syslinux/pxelinux.0 /tftp/ && \
	cp -r /usr/share/syslinux/libmenu.c32 \
		/usr/share/syslinux/menu.c32 \
		/usr/share/syslinux/memdisk \
		/usr/share/syslinux/ldlinux.c32 \
		/usr/share/syslinux/libutil.c32 /tftp/ && \
	mkdir /tftp/pxelinux.cfg
# ubuntu 18.10
RUN curl -sSL http://archive.ubuntu.com/ubuntu/dists/cosmic-updates/main/installer-amd64/current/images/netboot/netboot.tar.gz -o /tmp/netboot.tar.gz && \
	tar zxf /tmp/netboot.tar.gz -C /var/tmp/ && \
	cd /var/tmp/ && \
	mkdir -p /tftp/ubuntu-18.10 && \
	cp ./ubuntu-installer/amd64/linux /tftp/ubuntu-18.10/linux && \
	cp ./ubuntu-installer/amd64/initrd.gz /tftp/ubuntu-18.10/initrd.gz
# run
ADD run.sh /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]

FROM scratch
# terra
COPY --from=terra /terra.iso /tftp/terra/terra.iso
# ipxe
COPY --from=ipxe /ipxe/src/bin/undionly.kpxe /tftp/undionly.kpxe
ADD boot.ipxe /tftp/boot.ipxe
ADD boot.ipxe.cfg /tftp/boot.ipxe.cfg
ADD menu.ipxe /tftp/menu.ipxe

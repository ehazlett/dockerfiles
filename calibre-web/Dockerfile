FROM alpine:latest
ENV CALIBRE_COMMIT=4b301a79618dcd7aeca104887bfbd3a1f88d908c
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	file \
	fontconfig-dev \
	freetype-dev \
	g++ \
	gcc \
	ghostscript-dev \
	lcms2-dev \
	libjpeg-turbo-dev \
	libpng-dev \
	libtool \
	libwebp-dev \
	libxml2-dev \
	libxslt-dev \
	make \
	perl-dev \
	python2-dev \
	tiff-dev \
	xz \
	zlib-dev && \
  apk add --no-cache \
	python \
	py2-pip \
	fontconfig \
	freetype \
	ghostscript \
	imagemagick6 \
	jq \
	lcms2 \
	libjpeg-turbo \
	libltdl \
	libpng \
	libwebp \
	libxml2 \
	libxslt \
	tiff \
	zlib && \
 mkdir -p \
	/app/calibre-web && \
 curl -o \
 /tmp/calibre-web.tar.gz -L \
	https://github.com/janeczku/calibre-web/archive/${CALIBRE_COMMIT}.tar.gz && \
 tar xf \
 /tmp/calibre-web.tar.gz -C \
	/app/calibre-web --strip-components=1 && \
 cd /app/calibre-web && \
 pip install --no-cache-dir -U -r \
	requirements.txt && \
 pip install --no-cache-dir -U -r \
	optional-requirements.txt && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

EXPOSE 8083
VOLUME /books /config
CMD ["python", "/app/calibre-web/cps.py"]

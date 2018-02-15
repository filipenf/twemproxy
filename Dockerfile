FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install libtool make automake supervisor curl python2.7 python-pip -qy
RUN apt-get install libyaml-0-2 -yq
RUN apt-get install -y memcached

ADD . src

# Install twemproxy
RUN cd src && autoreconf -fvi && ./configure --enable-debug=log && \
	make && mv src/nutcracker /usr/local/bin/nutcracker && \
	cd ../ && rm -rf src

# install pip deps
RUN pip install pyaml==14.05.7 boto==2.32.0

# Configuration
RUN mkdir -p /etc/nutcracker
RUN mkdir -p /var/log/nutcracker

EXPOSE 3000 22222 22123 11211 22121

RUN apt-get remove libtool make automake curl -yq

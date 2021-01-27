FROM debian:latest
MAINTAINER janthomae@janthomae.de
RUN apt-get update && \
    apt -y install git make automake libtool pkg-config libaio-dev && \
    apt -y install default-libmysqlclient-dev libssl-dev && \
    apt -y install libpq-dev && \
    git clone https://github.com/derkork/sysbench.git sysbench && \
    cd sysbench && \
    git checkout feature/tls-support && \
    ./autogen.sh && \
    ./configure --with-mysql --with-pgsql && \
    make -j && \
    make install && \
    cd .. && \
    rm -rf sysbench

WORKDIR /
ENTRYPOINT sysbench

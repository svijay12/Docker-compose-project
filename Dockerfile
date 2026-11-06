FROM ubuntu:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
      ca-certificates \
      cmake \
      gcc \
      g++ \
      git \
      libconfuse-dev \
      libssl-dev \
      make && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/svijay12/Docker-compose-project.git

WORKDIR /src

RUN cmake -B build \
 && cmake --build build \
 && cmake --install build

RUN mkdir -p /etc/postsrsd

COPY postsrsd.conf /etc/postsrsd/postsrsd.conf
COPY secrets /etc/postsrsd/secrets

EXPOSE 10001 10002

CMD ["/usr/local/sbin/postsrsd","-f","/etc/postsrsd/postsrsd.conf"]

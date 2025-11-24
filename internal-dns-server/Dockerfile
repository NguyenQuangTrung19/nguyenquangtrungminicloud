FROM ubuntu:22.04
RUN apt-get update && apt-get install -y bind9 dnsutils && rm -rf /var/lib/apt/lists/*
COPY named.conf.options /etc/bind/named.conf.options
COPY named.conf.local   /etc/bind/named.conf.local
COPY db.cloud.local     /var/lib/bind/db.cloud.local
EXPOSE 53/udp
EXPOSE 53/tcp
CMD ["named", "-g"]

FROM ubuntu:latest

ADD install.sh /root
COPY *.patch /tmp

RUN chmod +x /root/*.sh && \
    /bin/bash /root/install.sh


COPY entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1
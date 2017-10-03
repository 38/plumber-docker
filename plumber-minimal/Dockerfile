FROM scratch
COPY busybox /bin/sh
COPY busybox /bin/busybox
COPY install-bin /bin/
RUN  /bin/busybox rm /bin/sh && /bin/busybox ln -s /bin/busybox /bin/sh
COPY build.sh /
RUN  sh /build.sh
RUN echo ${TREE_HASH} > .tree_hash
ENTRYPOINT ["/bin/sh"]

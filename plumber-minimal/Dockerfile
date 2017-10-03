ARG TREE_HASH=undefined
FROM scratch
COPY busybox /bin/sh
COPY busybox /bin/busybox
COPY install-bin /bin/
RUN  /bin/busybox rm /bin/sh && /bin/busybox ln -s /bin/busybox /bin/sh
COPY build.sh /
ENV GIT_TREE_HASH=$TREE_HASH
ENTRYPOINT ["/bin/sh"]

FROM haohou/plumber-minimal
ARG TREE_HASH=undefined
COPY fileserver /fileserver
ENV GIT_TREE_HASH=$TREE_HASH
ENTRYPOINT ["/fileserver/start.sh"]

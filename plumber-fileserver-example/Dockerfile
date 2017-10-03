FROM haohou/plumber-minimal
COPY fileserver /fileserver
ENV GIT_TREE_HASH=$TREE_HASH
ENTRYPOINT ["/fileserver/start.sh"]

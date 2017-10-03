FROM haohou/plumber-minimal
COPY fileserver /fileserver
RUN echo ${TREE_HASH} > .tree_hash
ENTRYPOINT ["/fileserver/start.sh"]

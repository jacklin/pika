FROM jacklin/pika:latest

LABEL maintainer="jacklin@shouyiren.net"
# 双主模式3.4.1之后已经取消
ENV IS_SLAVE='false' \
    IS_DOUBLE_MODE='false' \
    DOUBLE_MASTER_PORT='9221' \
    SLAVEOF='pika-m-0:9221' 
ENV THREAD_NUM='1' \
    THREAD_POOL_SIZE='12' \
    SYNC_THREAD_NUM='6' \
    LOG_PATH='./log/' \
    DB_PATH='./db/' \
    WRITE_BUFFER_SIZE='268435456' \
    ARENA_BLOCK_SIZE='' \
    TIMEOUT='60' \
    REQUIREPASS='' \
    MASTERAUTH='' \
    USERPASS='' \
    USERBLACKLIST='' \
    INSTANCE_MODE='classic' \
    DATABASES='1' \
    DEFAULT_SLOT_NUM='1024' \
    REPLICATION_NUM='0' \
    CONSENSUS_LEVEL='0' \
    DUMP_PREFIX='' \
    DUMP_PATH='./dump/' \
    DUMP_EXPIRE='0' \
    MAXCLIENTS='20000' \
    TARGET_FILE_SIZE_BASE='20971520' \
    EXPIRE_LOGS_DAYS='7' \
    EXPIRE_LOGS_NUMS='10' \
    ROOT_CONNECTION_NUM='2' \
    SLOWLOG_WRITE_ERRORLOG='no' \
    SLOWLOG_LOG_SLOWER_THAN='10000' \
    SLOWLOG_MAX_LEN='128' \
    DB_SYNC_PATH='./dbsync/' \
    DB_SYNC_SPEED='-1' \
    SLAVE_PRIORITY='100' \
    SYNC_WINDOW_SIZE='9000' \
    MAX_CONN_RBUF_SIZE='268435456' \
    WRITE_BINLOG='yes' \
    BINLOG_FILE_SIZE='104857600' \
    MAX_CACHE_STATISTIC_KEYS='0' \
    SMALL_COMPACTION_THRESHOLD='5000' \
    MAX_WRITE_BUFFER_SIZE='10737418240' \
    MAX_WRITE_BUFFER_NUM='2' \
    MAX_CLIENT_RESPONSE_SIZE='1073741824' \
    COMPRESSION='snappy' \
    MAX_BACKGROUND_FLUSHES='1' \
    MAX_BACKGROUND_COMPACTIONS='2' \
    MAX_CACHE_FILES='5000' \
    MAX_BYTES_FOR_LEVEL_MULTIPLIER='10'

COPY conf/ /opt/docker/

RUN set -ex && \
    chmod +x /opt/docker/bin/entrypoint.sh

EXPOSE 9221

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]

# CMD ["/pika/bin/pika", "-c", "/usr/local/etc/pika/pika.conf"]
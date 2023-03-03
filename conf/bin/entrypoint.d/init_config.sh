#!/usr/bin/env bash

if [[ ! -d "/usr/local/etc/pika/" ]]; then
	mkdir -p /usr/local/etc/pika/
fi
cat /opt/docker/pika/pika.conf > /usr/local/etc/pika/pika.conf


# 修改PHP监听端口配置
sed -e "s#<THREAD-NUM>#$THREAD_NUM#" \
-e "s#<THREAD-POOL-SIZE>#$THREAD_POOL_SIZE#" \
-e "s#<SYNC-THREAD-NUM>#$SYNC_THREAD_NUM#" \
-e "s#<LOG-PATH>#$LOG_PATH#" \
-e "s#<DB-PATH>#$DB_PATH#" \
-e "s#<WRITE-BUFFER-SIZE>#$WRITE_BUFFER_SIZE#" \
-e "s#<ARENA-BLOCK-SIZE>#$ARENA_BLOCK_SIZE#" \
-e "s#<TIMEOUT>#$TIMEOUT#" \
-e "s#<REQUIREPASS>#$REQUIREPASS#" \
-e "s#<MASTERAUTH>#$MASTERAUTH#" \
-e "s#<USERPASS>#$USERPASS#" \
-e "s#<USERBLACKLIST>#$USERBLACKLIST#" \
-e "s#<INSTANCE-MODE>#$INSTANCE_MODE#" \
-e "s#<DATABASES>#$DATABASES#" \
-e "s#<DEFAULT-SLOT-NUM>#$DEFAULT_SLOT_NUM#" \
-e "s#<REPLICATION-NUM>#$REPLICATION_NUM#" \
-e "s#<CONSENSUS-LEVEL>#$CONSENSUS_LEVEL#" \
-e "s#<DUMP-PREFIX>#$DUMP_PREFIX#" \
-e "s#<DUMP-PATH>#$DUMP_PATH#" \
-e "s#<DUMP-EXPIRE>#$DUMP_EXPIRE#" \
-e "s#<MAXCLIENTS>#$MAXCLIENTS#" \
-e "s#<TARGET-FILE-SIZE-BASE>#$TARGET_FILE_SIZE_BASE#" \
-e "s#<EXPIRE-LOGS-DAYS>#$EXPIRE_LOGS_DAYS#" \
-e "s#<EXPIRE-LOGS-NUMS>#$EXPIRE_LOGS_NUMS#" \
-e "s#<ROOT-CONNECTION-NUM>#$ROOT_CONNECTION_NUM#" \
-e "s#<SLOWLOG-WRITE-ERRORLOG>#$SLOWLOG_WRITE_ERRORLOG#" \
-e "s#<SLOWLOG-LOG-SLOWER-THAN>#$SLOWLOG_LOG_SLOWER_THAN#" \
-e "s#<SLOWLOG-MAX-LEN>#$SLOWLOG_MAX_LEN#" \
-e "s#<DB-SYNC-PATH>#$DB_SYNC_PATH#" \
-e "s#<DB-SYNC-SPEED>#$DB_SYNC_SPEED#" \
-e "s#<SLAVE-PRIORITY>#$SLAVE_PRIORITY#" \
-e "s#<SYNC-WINDOW-SIZE>#$SYNC_WINDOW_SIZE#" \
-e "s#<MAX-CONN-RBUF-SIZE>#$MAX_CONN_RBUF_SIZE#" \
-e "s#<WRITE-BINLOG>#$WRITE_BINLOG#" \
-e "s#<BINLOG-FILE-SIZE>#$BINLOG_FILE_SIZE#" \
-e "s#<MAX-CACHE-STATISTIC-KEYS>#$MAX_CACHE_STATISTIC_KEYS#" \
-e "s#<SMALL-COMPACTION-THRESHOLD>#$SMALL_COMPACTION_THRESHOLD#" \
-e "s#<MAX-WRITE-BUFFER-SIZE>#$MAX_WRITE_BUFFER_SIZE#" \
-e "s#<MAX-WRITE-BUFFER-NUM>#$MAX_WRITE_BUFFER_NUM#" \
-e "s#<MAX-CLIENT-RESPONSE-SIZE>#$MAX_CLIENT_RESPONSE_SIZE#" \
-e "s#<COMPRESSION>#$COMPRESSION#" \
-e "s#<MAX-BACKGROUND-FLUSHES>#$MAX_BACKGROUND_FLUSHES#" \
-e "s#<MAX-BACKGROUND-COMPACTIONS>#$MAX_BACKGROUND_COMPACTIONS#" \
-e "s#<MAX-CACHE-FILES>#$MAX_CACHE_FILES#" \
-e "s#<MAX-BYTES-FOR-LEVEL-MULTIPLIER>#$MAX_BYTES_FOR_LEVEL_MULTIPLIER#" \
/opt/docker/pika/pika.conf > /usr/local/etc/pika/pika.conf

#
if [[ ${IS_SLAVE} == 'true' ]]; then
	echo "# replication" >> /usr/local/etc/pika/pika.conf
	echo "${SLAVEOF}" >> /usr/local/etc/pika/pika.conf
else
	if [[ ${IS_DOUBLE_MODE} == 'true' ]]; then
		hostname=`hostname`
		hostid=`expr ${hostname: -1} + 1`
		server_id=${hostid}
		echo "server-id : ${server_id}" >> /usr/local/etc/pika/pika.conf
		if [[ $server_id == 1 ]]; then
			#double_master_ip="${hostname%?}1"
			double_master_ip=`ping -c 1 ${hostname%?}1 |grep PING |awk -F " " '{print $3}' |sed  's/(//g' |sed 's/)//g'`
			double_master_server_id=2
		else
			# double_master_ip="${hostname%?}0"
			double_master_ip=`ping -c 1 ${hostname%?}0 |grep PING |awk -F " " '{print $3}' |sed  's/(//g' |sed 's/)//g'`
			double_master_server_id=1
		fi
		echo "double-master-ip : ${double_master_ip}"	>> /usr/local/etc/pika/pika.conf
	 	echo "double-master-port : ${DOUBLE_MASTER_PORT}"   >> /usr/local/etc/pika/pika.conf
	 	echo "double-master-server-id : ${double_master_server_id}"   >> /usr/local/etc/pika/pika.conf
	fi
fi


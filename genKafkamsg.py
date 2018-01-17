#!/usr/bin/python
# (c) copyright Martin Lurie 2016
# sample code - not supported
import os
import sys 
import time

from kafka import ( KafkaClient, KeyedProducer, RoundRobinPartitioner)
# to make automation simpler put kafka on the name node so the
# hostname below is just the namenode
mykafka = os.environ['KAFKANODE']+ ":9092"
kafka = KafkaClient(mykafka)
# HashedPartitioner is default (currently uses python hash())
producer = KeyedProducer(kafka)
for line in sys.stdin:
    	line = line.strip()
	producer.send_messages(b'medevents', b'key2',bytes(line) )
	# only print when debugging
	# print line
	# generate 100 events per second
	#time.sleep(.01)
	# generate 10 events per second
	time.sleep(.1)
	# 
	#time.sleep(.001)

#!/usr/bin/python
# (c) copyright Martin Lurie 2016
# sample code - not supported
import sys 
import time

from kafka import ( KafkaClient, KeyedProducer, RoundRobinPartitioner)
kafka = KafkaClient('merlin:9092')
# HashedPartitioner is default (currently uses python hash())
producer = KeyedProducer(kafka)
for line in sys.stdin:
    	line = line.strip()
	producer.send_messages(b'medevents', b'key2',bytes(line) )
	print line
	# generate 100 events per second
	#time.sleep(.01)
	# generate 10 events per second
	time.sleep(.1)
	# 
	#time.sleep(.001)

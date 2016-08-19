# start kafka message publication and 
# create flume sink to log events
xterm -hold /home/marty/edrive/bigData/FDAadverseEventsData/ascii/250kafka2flumechanneldirect &
#
# now also start spark streaming to do real time counts
#spark-submit /home/marty/edrive/src/spark/streaming/SparkStreamingKafkaCount.py 2> /dev/null
spark-submit /home/marty/edrive/src/spark/streaming/SparkStreamingKafkaCountWindow.py 2> /dev/null 

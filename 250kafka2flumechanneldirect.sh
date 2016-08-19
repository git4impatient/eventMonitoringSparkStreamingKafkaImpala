# (c) 2016 Copyright Martin Lurie
# sample code - not supported
#
#./gokafkamsg.sh &
cat eventlist2.txt | ./genKafkamsg.py&
hadoop fs -rm -r medevents
hadoop fs -mkdir medevents
flume-ng agent -n flume1 -f directKafkaChannel.properties 

exit

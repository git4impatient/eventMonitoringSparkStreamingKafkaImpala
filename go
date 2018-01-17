echo $USER
echo $$
echo $HOSTNAME
pwd
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM590948.zip
 jar -xvf UCM590948.zip
# the file we want is the demographics in this example  DEMO17Q3.txt
mv ascii/DEMO17Q3.txt .

# find the namenode - our config has the kafka listener on the same address
# if we find the namenode we have found the kafka node :-)
export NAMENODE=$(hdfs getconf -namenodes| head -1)
echo $NAMENODE
export KAFKANODE=$NAMENODE
export ZKNODE=$NAMENODE
chmod +x genKafkamsg.py 


# start kafka message publication and 
cat DEMO17Q3.txt | ./genKafkamsg.py &
# clean out prior run
hadoop fs -rm -r medevents
# create directory for next run
hadoop fs -mkdir medevents

# variable subsitution not working in flume props here is the workaround
cp directKafkaChannel.properties.template directKafkaChannel.properties
sed -i  "s/KAFKANODE/$KAFKANODE/" directKafkaChannel.properties 
sed -i  "s/ZKNODE/$ZKNODE/" directKafkaChannel.properties 
sed -i  "s/USER/$USER/" directKafkaChannel.properties 
# run flume in flafka config to store all events as they come in
flume-ng agent -n flume1 -f directKafkaChannel.properties  > flumeMsg.out 2>&1 &
sleep 10
hadoop fs -ls /user/$USER/medevents

xterm -hold /home/marty/edrive/bigData/FDAadverseEventsData/ascii/250kafka2flumechanneldirect &
#
# now also start spark streaming to do real time counts
#spark-submit /home/marty/edrive/src/spark/streaming/SparkStreamingKafkaCount.py 2> /dev/null
spark-submit /home/marty/edrive/src/spark/streaming/SparkStreamingKafkaCountWindow.py 2> /dev/null 

import sys
import pprint
import os

mynn = os.environ['NAMENODE']+ ":8020"
mykafka = os.environ['KAFKANODE']+ ":9092"
mycpdir = os.environ['USER']+ ":9092"
print "mynn is " + mynn + " mykafka is " + mykafka


from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils
sc = SparkContext(appName="PythonStreamingDirectKafkaWordCount")
ssc = StreamingContext(sc, 5)
ssc.checkpoint("hdfs:///user/marty/streamingcheckpoints")   # set checkpoint directory
print ssc

kvs = KafkaUtils.createDirectStream(ssc, ['medevents'], {"metadata.broker.list": mykafka})

try:
   lines = kvs.map(lambda x: x[1])
   country = lines.map(lambda line: line.split("$")[-2]) 
   pairs = country.map(lambda countrycode: (countrycode, 1)) 
   countryCounts = pairs.reduceByKey(lambda a, b: a+b)
   print "current Country counts:"
   print "last 40 seconds of country counts every 20 seconds"
   # print 5 lines of the countryCounts from the current window
   print "current reporting countryCounts last 20 seconds"
   countryCounts.pprint(num=5)
   # look back over 40 seconds, every 20 seconds print out the action from the last 40 seconds
   # of this data, print 15 lines
   print " look back over 40 seconds, every 20 seconds print out the action from the last 40 seconds"
   windowedCountryCounts = pairs.reduceByKeyAndWindow(lambda x, y: x + y, lambda x, y: x - y, 40, 20)
   windowedCountryCounts.filter(lambda q: int(q[1])>5).pprint(num=15)
except IndexError:
    print "###################################################################  index error  "



ssc.start()
ssc.awaitTermination()

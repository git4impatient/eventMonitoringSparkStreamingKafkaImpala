Event Monitoring with Spark Streaming Kafka, and Impala

We'll use the FDA Adverse Drug Reaction data and send it to an Apache Kafka message broker with a python
client. To monitor The events as they occur we'll use Spark Streaming to subscribe to the
Kafka message topic. We'll compare current values vs a window of prior events. Multiple
subscribers is a key benefit of using a Kafka Message Broker topic. Flafka will subscribe to the
same topic as Spark Streaming and persist the messages for SQL analysis. For summary
reporting of events we'll fire up Impala and use SQL. To make things look nice we'll connect
Microsoft Excel to Impala to get a histogram of the data. For investigating specific patients
we'll simulate multiple case workers running queries with the JMeter test harness. Since there
are auditing and security requirements for medical data we'll illustrate some capabilities of
Cloudera Navigator and Cloudera Manager.

Any data file can be fed to the genKafakMessage.py.  Stock market data etc can be re-played to simulate real time events.

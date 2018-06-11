set kafkaBatchLocation=\TEST_playground\kafka\bin\windows
start "zookeeper" /D %kafkaBatchLocation% zookeeper-server-start.bat ..\..\config\zookeeper.properties
TIMEOUT /T 30
rm -r C:\tmp\kafka-logs
start "kafka" /D %kafkaBatchLocation% kafka-server-start.bat ..\..\config\server.properties
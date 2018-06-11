# Cloud Application with Spring Cloud Stream and Apache Kafka
Cloud-ready application based on Spring Cloud Stream and Apache Kafka (as a messaging system).

## Pre Requirements
* Java 8
* Downloaded kafka (unarchived somewhere)

## Build and run
First of all launch zookeeper & kafka, simply run the batch file **/info/run_KafkaAndZookeeper.bat**

Then launch the apps with the following sequence is:
1) discovery
2) configuration
3) event-processor
4) http-request-consumer
5) gateway

In the spring boot run configuration run those apps with this **Environment Variables**:
* **for** _event-processor, http-request-consumer, gateway_  **use:**
REGISTRY_SERVICE_ZONE=http://localhost:8080/eureka/;
CONFIGURATION_SERVICE_NAME=configuration

* **for** _discovery, configuration_  **use:**
REGISTRY_SERVICE_ZONE=http://localhost:8080/eureka/;


[source link:](https://medium.com/zenitech/cloud-application-with-spring-cloud-stream-and-apache-kafka-4a7086194834)
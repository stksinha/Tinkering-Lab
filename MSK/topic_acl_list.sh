#!/bin/bash

# Usage: ./topic_acl_list.sh <BROKER_HOST:PORT> <TOPIC_NAME>
# Example: ./topic_acl_list.sh localhost:9092 my-topic

BROKER=$1
TOPIC=$2

if [ -z "$BROKER" ] || [ -z "$TOPIC" ]; then
   echo "Usage:$0 <BROKER_HOST:PORT> <TOPIC_NAME>"
   exit 1
fi

echo "Listing acls of '$TOPIC' on broker '$BROKER'..."
export KAFKA_HEAP_OPTS="-Xmx1G -Xms512M"

#Listing acls for topics
/opt/kafka/kafka/bin/kafka-acls.sh \
--bootstrap-server "$BROKER" \
--list \
--topic "$TOPIC" \
--command-config /opt/kafka/kafka/config/client.properties

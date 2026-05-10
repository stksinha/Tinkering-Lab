#!/bin/bash

# Usage: ./topic_list.sh <BROKER_HOST:PORT>
# Example: ./topic_list.sh localhost:9092

BROKER=$1

if [ -z "$BROKER" ]; then
   echo "Usage:$0 <BROKER_HOST:PORT>"
   exit 1
fi

echo "Listen topics on broker '$BROKER'..."
export KAFKA_HEAP_OPTS="-Xmx1G -Xms512M"

#Listing topics
/opt/kafka/kafka/bin/kafka-topics.sh \
--bootstrap-server "$BROKER" \
--list \
--command-config /opt/kafka/kafka/config/client.properties

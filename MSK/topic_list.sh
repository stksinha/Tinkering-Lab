#!/bin/bash

# Configuration
KAFKA_PATH="/opt/kafka/kafka"
CLIENT_CONFIG="$KAFKA_PATH/config/client.properties"

# Usage: ./topic_list.sh <BROKER_HOST:PORT>
# Example: ./topic_list.sh localhost:9092

BROKER=$1

if [ -z "$BROKER" ]; then
   echo "Usage:$0 <BROKER_HOST:PORT>"
   exit 1
fi

echo "--- Fetching Topic List from '$BROKER' ---"
export KAFKA_HEAP_OPTS="-Xmx1G -Xms512M"

#Listing topics
$KAFKA_PATH/bin/kafka-topics.sh \
--bootstrap-server "$BROKER" \
--list \
--command-config "$CLIENT_CONFIG"

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "Error: Could not retrieve topic list. Check your connection/config."
    exit 1
fi

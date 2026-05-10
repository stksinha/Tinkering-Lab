#!/bin/bash

# Configuration
KAFKA_PATH="/opt/kafka/kafka"
CLIENT_CONFIG="$KAFKA_PATH/config/client.properties"

# Usage: ./set_retention.sh <BROKER_HOST:PORT> <TOPIC_NAME> <RETENTION_HOURS>
# Example: ./set_retention.sh localhost:9092 my-topic 72

BROKER=$1
TOPIC=$2
HOURS=$3

# Check for missing arguments
if [ -z "$BROKER" ] || [ -z "$TOPIC" ] || [ -z "$HOURS" ]; then
  echo "Usage: $0 <BROKER_HOST:PORT> <TOPIC_NAME> <RETENTION_HOURS>"
  exit 1
fi

# Safety Check: Prevent zero or invalid negative numbers
if [ "$HOURS" -eq 0 ]; then
    echo "ERROR: Retention cannot be 0. This would delete all data immediately."
    echo "If you want infinite retention, use -1."
    exit 1
elif [ "$HOURS" -lt -1 ]; then
    echo "ERROR: Invalid retention period ($HOURS). Use -1 for infinite or a positive integer for hours."
    exit 1
fi

# Convert hours to milliseconds
if [ "$HOURS" -eq -1 ]; then
    MS=-1
    echo "--- Setting Retention to INFINITE for '$TOPIC' ---"
else
    MS=$((HOURS * 60 * 60 * 1000))
    echo "--- Updating Retention for '$TOPIC' ---"
    echo "Target: $HOURS hours ($MS ms)"
fi

export KAFKA_HEAP_OPTS="-Xmx1G -Xms512M"
# Apply retention configuration
$KAFKA_PATH/bin/kafka-configs.sh \
  --bootstrap-server "$BROKER" \
  --alter \
  --entity-type topics \
  --entity-name "$TOPIC" \
  --add-config retention.ms=$MS \
  --command-config "$CLIENT_CONFIG"

# Check success and verify
if [ $? -eq 0 ]; then
    echo -e "\n--- Current Configuration for '$TOPIC' ---"
    $KAFKA_PATH/bin/kafka-configs.sh \
      --bootstrap-server "$BROKER" \
      --describe \
      --entity-type topics \
      --entity-name "$TOPIC" \
      --command-config "$CLIENT_CONFIG"
else
    echo "Error: Failed to update configuration."
    exit 1
fi

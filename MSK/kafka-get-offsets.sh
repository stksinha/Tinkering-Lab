#!/bin/bash

# Configuration
KAFKA_PATH="/opt/kafka/kafka"
CLIENT_CONFIG="$KAFKA_PATH/config/client.properties"

# Usage: ./kafka-get-offsets.sh <BROKER_HOST:PORT> <TOPIC_NAME> [PARTITION] [TIME]
# TIME options: -1 (latest), -2 (earliest)
BROKER=$1
TOPIC=$2
PARTITION=${3:-""}  # Optional: defaults to all partitions if empty
TIME=${4:-"-1"}     # Optional: defaults to latest (-1)

if [ -z "$BROKER" ] || [ -z "$TOPIC" ]; then
    echo "Usage: $0 <BROKER_HOST:PORT> <TOPIC_NAME> [PARTITION_ID] [TIME]"
    echo "Time: -1 for Latest (default), -2 for Earliest"
    exit 1
fi

# Set partition flag if a specific partition was requested
PARTITION_FLAG=""
if [ -not -z "$PARTITION" ]; then
    PARTITION_FLAG="--partitions $PARTITION"
fi

echo "--- Fetching offsets for '$TOPIC' (Time: $TIME) ---"
export KAFKA_HEAP_OPTS="-Xmx512M -Xms256M"

# Execution
$KAFKA_PATH/bin/kafka-run-class.sh kafka.tools.GetOffsetShell \
  --bootstrap-server "$BROKER" \
  --topic "$TOPIC" \
  $PARTITION_FLAG \
  --time "$TIME" \
  --command-config "$CLIENT_CONFIG" | column -t -s ':'

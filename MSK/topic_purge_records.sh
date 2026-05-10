#!/bin/bash

# Configuration
KAFKA_PATH="/opt/kafka/kafka"
CLIENT_CONFIG="$KAFKA_PATH/config/client.properties"

# Usage: ./topic_purge_records.sh <BROKER> <TOPIC> <PARTITION> <OFFSET>
BROKER=$1
TOPIC=$2
PARTITION=$3
OFFSET=$4

if [ -z "$BROKER" ] || [ -z "$TOPIC" ] || [ -z "$PARTITION" ] || [ -z "$OFFSET" ]; then
  echo "Usage: $0 <BROKER_HOST:PORT> <TOPIC_NAME> <PARTITION> <OFFSET>"
  exit 1
fi

# Create a temporary JSON file
JSON_FILE="delete_${TOPIC}_${PARTITION}.json"

cat < "$JSON_FILE"
{
  "partitions": [
    {
      "topic": "$TOPIC",
      "partition": $PARTITION,
      "offset": $OFFSET
    }
  ],
  "version": 1
}
EOF

echo "--- Purging records for '$TOPIC' (Partition $PARTITION) up to offset $OFFSET ---"
export KAFKA_HEAP_OPTS="-Xmx512M -Xms256M"

# Execute deletion
$KAFKA_PATH/bin/kafka-delete-records.sh \
  --bootstrap-server "$BROKER" \
  --offset-json-file "$JSON_FILE" \
  --command-config "$CLIENT_CONFIG"

if [ $? -eq 0 ]; then
  echo "Successfully submitted delete request."
else
  echo "Error: Deletion failed."
fi

# Clean up the temporary file
rm "$JSON_FILE"

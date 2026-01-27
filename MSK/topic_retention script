

# Usage: ./set_retention.sh <BROKER_HOST:PORT> <TOPIC_NAME> <RETENTION_HOURS>
# Example: ./set_retention.sh localhost:9092 my-topic 72

BROKER=$1
TOPIC=$2
HOURS=$3

if [ -z "$BROKER" ] || [ -z "$TOPIC" ] || [ -z "$HOURS" ]; then
  echo "Usage: $0 <BROKER_HOST:PORT> <TOPIC_NAME> <RETENTION_HOURS>"
  exit 1
fi

# Convert hours to milliseconds
MS=$((HOURS * 60 * 60 * 1000))

echo "Setting retention.ms=$MS for topic '$TOPIC' on broker '$BROKER'..."
export KAFKA_HEAP_OPTS="-Xmx1G -Xms512M"
# Apply retention configuration
/opt/kafka/kafka/bin/kafka-configs.sh \
  --bootstrap-server "$BROKER" \
  --alter \
  --entity-type topics \
  --entity-name "$TOPIC" \
  --add-config retention.ms=$MS \
  --command-config /opt/kafka/kafka/config/client.properties

# Verify configuration
echo "Verifying configuration..."
/opt/kafka/kafka/bin/kafka-configs.sh \
  --bootstrap-server "$BROKER" \
  --describe \
  --entity-type topics \
  --entity-name "$TOPIC" \
  --command-config /opt/kafka/kafka/config/client.properties

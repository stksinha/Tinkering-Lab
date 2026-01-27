

# Usage: ./create_topic.sh <BROKER_HOST:PORT> <TOPIC_NAME> <REPLICATION_FACTOR> <PARTITIONS>
# Example: ./create_topic.sh localhost:9092 my-topic 2 1

BROKER=$1
TOPIC=$2
REPLICATION_FACTOR=$3
PARTITIONS=$4

if [ -z "$BROKER" ] || [ -z "$TOPIC" ] || [ -z "REPLICATION_FACTOR" ] || [ -z "PARTITIONS" ]; then
  echo "Usage: $0 <BROKER_HOST:PORT> <TOPIC_NAME> <REPLICATION_FACTOR> <PARTITIONS>"
  exit 1
fi

echo "Creating topic '$TOPIC' on broker '$BROKER' with replication-factor '$REPLICATION_FACTOR' and partitions '$PARTITIONS'..."
export KAFKA_HEAP_OPTS="-Xmx1G -Xms512M"
# Create topic
/opt/kafka/kafka/bin/kafka-topics.sh \
  --bootstrap-server "$BROKER" \
  --create \
  --topic "$TOPIC" \
  --replication-factor "$REPLICATION_FACTOR"
  --partitions "$PARTITIONS" \
  --command-config /opt/kafka/kafka/config/client.properties

# List topics
echo "Listing topics..."
/opt/kafka/kafka/bin/kafka-configs.sh \
  --bootstrap-server "$BROKER" \
  --list \
  --command-config /opt/kafka/kafka/config/client.properties

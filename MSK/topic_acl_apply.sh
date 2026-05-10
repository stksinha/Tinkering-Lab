#!/bin/bash

# Configuration
KAFKA_PATH="/opt/kafka/kafka"
CLIENT_CONFIG="$KAFKA_PATH/config/client.properties"

# Usage: ./topic_acl_apply.sh <BROKER> <TOPIC> <OPERATION> <USER> <ALLOW/DENY>
BROKER=$1
TOPIC=$2
OPERATION=$3
USER=$4
TYPE=$(echo "$5" | tr '[:lower:]' '[:upper:]') # Convert to uppercase for consistency

# Check for all 5 arguments
if [ -z "$BROKER" ] || [ -z "$TOPIC" ] || [ -z "$OPERATION" ] || [ -z "$USER" ] || [ -z "$TYPE" ]; then
   echo "Usage: $0 <BROKER_HOST:PORT> <TOPIC_NAME> <OPERATION> <USER> <ALLOW|DENY>"
   exit 1
fi

# Determine which flag to use
if [ "$TYPE" == "DENY" ]; then
    PRINCIPAL_FLAG="--deny-principal"
else
    # Defaulting to Allow if not explicitly set to DENY
    PRINCIPAL_FLAG="--allow-principal"
    TYPE="ALLOW" 
fi

echo "--- Applying $TYPE ACL for '$TOPIC' ---"
echo "Broker:    $BROKER"
echo "Principal: User:$USER"
echo "Operation: $OPERATION"

export KAFKA_HEAP_OPTS="-Xmx1G -Xms512M"

# Applying ACLs using the dynamic flag
$KAFKA_PATH/bin/kafka-acls.sh \
--bootstrap-server "$BROKER" \
--add \
--topic "$TOPIC" \
"$PRINCIPAL_FLAG" "User:$USER" \
--operation "$OPERATION" \
--command-config "$CLIENT_CONFIG"

# Check success and list results
if [ $? -eq 0 ]; then
    echo -e "\n--- Current ACLs for '$TOPIC' ---"
    $KAFKA_PATH/bin/kafka-acls.sh \
    --bootstrap-server "$BROKER" \
    --list \
    --topic "$TOPIC" \
    --command-config "$CLIENT_CONFIG"
else
    echo "Error: Failed to apply ACLs. Please check your connection and client.properties."
    exit 1
fi

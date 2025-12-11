#!/usr/bin/env bash

# Get IDs and names of running instances owned by SimonasJocys
IDS=$(aws ec2 describe-instances \
  --filters \
    "Name=instance-state-name,Values=running" \
    "Name=tag:Owner,Values=SimonasJocys" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text
)

NAMES=$(aws ec2 describe-instances \
  --filters \
    "Name=instance-state-name,Values=running" \
    "Name=tag:Owner,Values=SimonasJocys" \
  --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" \
  --output text
)

if [ -z "$IDS" ]; then
  echo "No running EC2 instances to stop."
else
  echo "Stopping instances: $NAMES"
  aws ec2 stop-instances --instance-ids $IDS > /dev/null
fi

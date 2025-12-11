#!/usr/bin/env bash
id="$1"
aws ec2 start-instances --instance-ids "$id"
sleep 1
out="$(aws ec2 describe-instances --instance-ids "$id" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)"
ssh -i '~/.ssh/simonas_macos.pem' ubuntu@$out


#!/usr/bin/env bash
aws ec2 start-instances --instance-ids i-07a19971a869d7ab2
sleep 1
out="$(aws ec2 describe-instances --instance-ids i-07a19971a869d7ab2 --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)"
ssh -i '~/.ssh/simonas_macos.pem' ubuntu@$out


NAMES=$(aws ec2 describe-instances \
  --filters \
    "Name=instance-state-name,Values=running" \
    "Name=tag:Owner,Values=SimonasJocys" \
    --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" \
  --output text
  )
# maybe add nicer format, colors?
if [ -z "$NAMES" ]; then
  echo "Running EC2: none" 
else
  echo "Running EC2: $NAMES"
fi
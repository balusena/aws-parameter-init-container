#!/bin/bash

# Loop through each parameter in $PARAMETERS
for param in ${PARAMETERS}; do
  # Extract SHELL_VAR and PARAM using awk
  SHELL_VAR=$(echo "$param" | awk -F, '{print $1}')
  PARAM=$(echo "$param" | awk -F, '{print $2}')

  # Use aws-cli to retrieve the parameter value from AWS SSM
  PASS=$(aws ssm get-parameter --name "$PARAM" --with-decryption --query 'Parameter.Value' --output text)

  # Export the variable with the retrieved value
  echo "export $SHELL_VAR=$PASS" >> /data/params
done

# Print the contents of /data/params
cat /data/params



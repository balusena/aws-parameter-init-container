#!/bin/bash

# Purpose: This script retrieves parameters from AWS SSM Parameter Store, decrypts them, and exports them as shell variables.

# Loop through each parameter in ${PARAMETERS}
for param in ${PARAMETERS} ; do
  # Extract shell variable name and parameter name from the comma-separated string
  SHELL_VAR=$(echo $param | awk -F , '{print $1}')
  PARAM=$(echo $param | awk -F , '{print $2}')

  # Retrieve the parameter value from AWS SSM Parameter Store, decrypt it, and store it in PASS variable
  PASS=$(aws ssm get-parameter --name $PARAM --with-decryption --query 'Parameter.Value' --output text 2>/dev/null)

  # If PASS is empty, use the parameter name as the value
  if [ -z "$PASS" ]; then
    PASS=${PARAM}
  fi

  # Export the shell variable with the parameter value and append it to /data/params file
  echo export $SHELL_VAR=$PASS >>/data/params
done

# Display the contents of /data/params file
cat /data/params


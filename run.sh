for param in ${PARAMETERS} ; do
  SHELL_VAR=$(echo $param | awk -F , '{print $1}')
  PARAM=$(echo $param | awk -F , '{print $2}')
  PASS=$(aws ssm get-parameter --name $PARAM --with-decryption --query 'Parameter.Value' --output text 2>/dev/null)
  if [ -z "$PASS" ]; then
    PASS=${PARAM}
  fi
  echo export $SHELL_VAR=\"$PASS\" >>/data/params
done

cat /data/params
for param in ${PARAMETERS} ; do
  SHELL_VAR=$(echo $param | awk -F , '{print $1}')
  PARAM=$(echo $param | awk -F , '{print $2}')
  PASS=${aws ssm get-parameter --name $param --with-decryption --query 'Parameter.Value' --output text}
  echo export $SHELL_VAR=$PASS >>params
done

cat params


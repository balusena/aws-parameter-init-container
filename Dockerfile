FROM        amazon/aws-cli
COPY        run.sh /
ENTRYPOINT  [ "bash", "/run.sh" ]

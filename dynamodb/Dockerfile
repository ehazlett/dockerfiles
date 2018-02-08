FROM openjdk:7
RUN mkdir -p opt/dynamodb
WORKDIR /opt/dynamodb
RUN wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz -q -O - | tar -xz
EXPOSE 8000
ENTRYPOINT ["java", "-jar", "DynamoDBLocal.jar"]

# First stage: complete build environment
FROM maven:3.8.5-openjdk-8 AS builder
# To resolve dependencies in a safe way (no re-download when the source code changes)
ADD ./pom.xml pom.xml
VOLUME ["../m2", "./.m2"]
#RUN  mvn clean package -Dmaven.repo.local=./.m2
ADD ./src src/
ADD ./configuration configuration/
# package jar
RUN mvn -Dmaven.repo.local=./.m2 install -Dmaven.test.skip=true
From openjdk:8
# copy jar from the first stage
COPY --from=builder target/spring-boot-helloworld-0.0.1-SNAPSHOT.jar spring-boot-helloworld-0.0.1-SNAPSHOT.jar
EXPOSE 8080
CMD ["java", "-jar", "spring-boot-helloworld-0.0.1-SNAPSHOT.jar"] 

FROM alpine/git as clone
WORKDIR /tmp
RUN git clone https://github.com/Karumien/perf-service

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /tmp
COPY --from=clone /tmp/perf-service /tmp
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /tmp
COPY --from=build /tmp/target/perf-service-1.0.0-SNAPSHOT.jar /tmp
EXPOSE 2201
CMD ["java -jar perf-service-1.0.0-SNAPSHOT.jar"]

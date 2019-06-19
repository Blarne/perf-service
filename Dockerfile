FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/Karumien/perf-service

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/perf-service /app
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/perf-service-1.0.0-SNAPSHOT.jar /app
EXPOSE 2201
CMD ["java -jar perf-service-1.0.0-SNAPSHOT.jar"]

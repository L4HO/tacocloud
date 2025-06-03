# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests # -DskipTests는 테스트를 건너뛰고 빌드 속도를 높일 수 있습니다.

# Stage 2: Create the final image
FROM openjdk:17-slim
WORKDIR /app

# COPY --from=build /app/target/taco-cloud-0.0.1-SNAPSHOT.jar taco.jar
COPY --from=build /app/target/lec25.3-0.0.1-SNAPSHOT.jar taco.jar
EXPOSE 8085
ENTRYPOINT ["java", "-jar", "taco.jar"]

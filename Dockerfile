# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests # -DskipTests는 테스트를 건너뛰고 빌드 속도를 높일 수 있습니다.

# Stage 2: Create the final image
FROM openjdk:17-slim
WORKDIR /app
# pom.xml의 artifactId와 version에 맞춰 파일 이름을 정확히 지정해야 합니다.
# 예를 들어, artifactId가 "taco-cloud"이고 version이 "0.0.1-SNAPSHOT"이라면,
# 생성되는 JAR 파일은 보통 "taco-cloud-0.0.1-SNAPSHOT.jar" 입니다.
COPY --from=build /app/target/taco-cloud-0.0.1-SNAPSHOT.jar taco.jar
EXPOSE 8085
ENTRYPOINT ["java", "-jar", "taco.jar"]

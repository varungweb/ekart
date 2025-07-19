# Stage 1: Build
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy source code
COPY . .

# Build the app and skip tests
RUN chmod +x scripts/mvnw && mvn clean package -DskipTests

# Stage 2: Run
FROM openjdk:8u151-jdk-alpine3.7
WORKDIR $APP_HOME
ENV APP_HOME /usr/src/app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8070
ENTRYPOINT ["java", "-jar", "app.jar"]
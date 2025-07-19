# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy source code
COPY . .

# Build the app and skip tests
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# Stage 2: Run
FROM openjdk:8u151-jdk-alpine3.7
WORKDIR $APP_HOME
ENV APP_HOME /usr/src/app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8070
ENTRYPOINT ["java", "-jar", "app.jar"]
# ENTRYPOINT exec java -jar app.jar


# FROM eclipse-temurin:17-jre
# WORKDIR /app

# # Copy jar from the builder stage
# COPY --from=build /app/target/*.jar app.jar

# # Expose port
# EXPOSE 8070

# # Run the application
# ENTRYPOINT ["java", "-jar", "app.jar"]

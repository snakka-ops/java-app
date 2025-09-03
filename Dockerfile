FROM maven:3.8.7-eclipse-temurin-17 as builder 
WORKDIR /app
COPY . .
RUN mvn package

FROM eclipse-temurin:17
WORKDIR /app
COPY --from=builder /app/target/java-app-1.0-SNAPSHOT.jar .
CMD ["java", "-jar", "java-app-1.0-SNAPSHOT.jar"]

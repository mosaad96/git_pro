# Use the official OpenJDK image as a base
FROM openjdk:11-jdk

# Set the working directory
WORKDIR /app

# Copy the JAR file from the host to the container
COPY target/java-maven-app-1.1.0-SNAPSHOT.jar /app/myapp.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "myapp.jar"]


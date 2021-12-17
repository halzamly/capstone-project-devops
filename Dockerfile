FROM maven:3.6.3-jdk-11

# Create a working directory
WORKDIR /app

# Copy source code to working directory
COPY target/*.jar app.jar

# Expose port 80
EXPOSE 80

# Run app.py at container launch
CMD ["java","-jar","app.jar"]
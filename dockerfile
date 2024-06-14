# Use the official WildFly image from the Docker Hub
FROM jboss/wildfly:latest

# Set the working directory
WORKDIR /opt/jboss/wildfly

# Expose the management and application ports
EXPOSE 7070 9990

# Add a custom script to deploy your application (optional)
COPY deploy.sh /opt/jboss/wildfly/bin/deploy.sh
RUN chmod +x /opt/jboss/wildfly/bin/deploy.sh

# Start WildFly in standalone mode
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]


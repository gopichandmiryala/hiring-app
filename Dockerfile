FROM tomcat:9.0.108-jre21
# Define environment variables for Nexus repository and the artifact to download
ENV NEXUS_REPO_URL="http://3.83.83.128:8081/repository/hiringapp"
ENV ARTIFACT_PATH="in/javahome/hiring/0.1/hiring-0.1.war"

# Download the WAR file from Nexus and copy it to the Tomcat webapps directory
ADD $NEXUS_REPO_URL$ARTIFACT_PATH /usr/local/tomcat/webapps/hiring.war

# Expose port 8080 (Tomcat's default port)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

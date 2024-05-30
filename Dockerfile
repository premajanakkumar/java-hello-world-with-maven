# Dockerfile for Apache Tomcat
FROM tomcat:9.0

# Copy the WAR file into the webapps directory
COPY target/*.jar /usr/local/tomcat/webapps/

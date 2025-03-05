FROM maven:3.8.5-openjdk-17 AS builder

WORKDIR /java-app

RUN git clone https://github.com/kishore-kumar-kk/java_project .

RUN mvn clean package

FROM tomcat:10.1-jdk17

WORKDIR /usr/local/tomcat/webapps/

COPY --from=builder /java-app/target/*.war opskill.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

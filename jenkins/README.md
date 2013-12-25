# Jenkins Container

## How to use

 1. git clone
 1. cd dockerfiles/jenkins
 1. docker build -t ${your_container_name} .
 1. docker run -t -d -p 8080 ${your_container_name} /usr/bin/java -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080 --ajp13Port=-1
 1. IP = `docker inspect ${container ID} | jq '.[].NetworkSettings.IPAddress' | cut -d\" -f2`
 1. Please access http://${IP}:8080/

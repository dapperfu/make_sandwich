# Config
JAVA?=/usr/lib/jvm/java-8-openjdk-amd64/bin/java
HTTP_PORT?=8080

# Environment
export JENKINS_HOME?=$(realpath ${MK_DIR}/.jenkins)

# Targets
.PHONY: jenkins
jenkins: jenkins.war
	${JAVA} -jar ${<} --httpPort=${HTTP_PORT}

jenkins.war:
	curl --remote-name --location http://mirrors.jenkins.io/war-stable/latest/jenkins.war


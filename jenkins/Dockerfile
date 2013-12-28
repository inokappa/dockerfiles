FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get install sudo
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get update
RUN apt-get -y install jenkins
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/jenkinsadmin -m -s /bin/bash jenkinsadmin
RUN echo jenkinsadmin:${your_password} | chpasswd
RUN echo 'jenkinsadmin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
EXPOSE 8080
CMD ["/usr/bin/java","-jar","/usr/share/jenkins/jenkins.war"]

FROM centos
MAINTAINER YOHEI KAWAHARA inokappa
RUN wget -O /etc/yum.repos.d/cloudera-cdh4.repo http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/cloudera-cdh4.repo
RUN yum -y install java-1.7.0-openjdk sudo openssh-server zookeeper zookeeper-server
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
# Please change your password
RUN echo sandbox:sandox | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
#EXPOSE 
#
#CMD ["",""]

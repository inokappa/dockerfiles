FROM centos
#
MAINTAINER YOHEI KAWAHARA inokappa 
#
RUN yum -y update
RUN yum -y install httpd openssh-server mysql-server ntpd
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sshuser -m -s /bin/bash sshuser
RUN echo sshuser:sshuser | chpasswd
RUN echo 'sshuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

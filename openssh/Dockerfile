FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install sudo openssh-server
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sshuser -m -s /bin/bash sshuser
RUN echo sshuser:${your_password} | chpasswd
RUN echo 'sshuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
#ENTRYPOINT ["/usr/sbin/sshd","-D"]

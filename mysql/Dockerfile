#
FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install build-essential wget openssh-server sudo mysql-server
#
ADD mysql.conf /etc/monit/conf.d/td-agent.conf
RUN mv /etc/monit/monitrc.d/openssh-server /etc/monit/conf.d/openssh-server.conf
ADD monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
# Please change your password
RUN echo sandbox:your_password | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
# for norikra
#EXPOSE 26571 
#EXPOSE 26578 
## for fluentd
#EXPOSE 24220
#EXPOSE 24224
## for nginx
#EXPOSE 80
# for ssh
#EXPOSE 22
# for monit
#EXPOSE 2812
#CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]

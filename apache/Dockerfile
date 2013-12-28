FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install sudo apache2 openssh-server
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sshuser -m -s /bin/bash sshuser
RUN echo sshuser:${your_password} | chpasswd
RUN echo 'sshuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
EXPOSE 80
env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_RUN_DIR     /var/run/apache2
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_LOG_DIR     /var/log/apache2
env LANG               C
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

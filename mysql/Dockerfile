#
FROM inokappa/ubuntu
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
#
<<<<<<< HEAD
ADD mysql.conf /etc/monit/conf.d/td-agent.conf
RUN mv /etc/monit/monitrc.d/openssh-server /etc/monit/conf.d/openssh-server.conf
ADD monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc
=======
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install openssh-server sudo mysql-server
RUN (/usr/bin/mysqld_safe &); sleep 3; echo "GRANT ALL PRIVILEGES ON *.* to root@'%';" | mysql -u root
RUN (/usr/bin/mysqld_safe &); sleep 3; echo "GRANT REPLICATION SLAVE ON *.* TO repl@'%' IDENTIFIED BY 'password';" | mysql -u root
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf
ADD replication.cnf /etc/mysql/conf.d/
>>>>>>> 160ea9420430e4260f750986b58871e8b1ae0bd2
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
# Please change your password
RUN echo sandbox:sandox | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#
FROM centos
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN echo "NETWORKING=yes" >/etc/sysconfig/network
#
RUN yum -y update
RUN rpm --import http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/RPM-GPG-KEY-EPEL-6
RUN cd /tmp/ && wget http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN cd /tmp/ && rpm -Uvh epel-release-6-8.noarch.rpm
#
RUN yum -y install graphite-web mysql mysql-server MySQL-python python-carbon monit vim telnet expect
#
ADD graphite/local_settings.py /etc/graphite-web/local_settings.py
ADD graphite/initial_data.json /etc/graphite-web/initial_data.json
#
RUN /etc/init.d/mysqld start && \
  mysql -e "CREATE USER 'graphite'@'localhost' IDENTIFIED BY 'passw0rd';" -u root && \
  mysql -e "GRANT ALL PRIVILEGES ON graphite.* TO 'graphite'@'localhost';" -u root && \
  mysql -e "CREATE DATABASE graphite;" -u root && \
  mysql -e 'FLUSH PRIVILEGES;' -u root && \
  export LANG="en_US.UTF-8" && \
  cd /etc/graphite-web && \
  /usr/lib/python2.6/site-packages/graphite/manage.py syncdb --noinput && \
  sleep 1
#
ADD monit/monit.conf /etc/monit.conf
RUN chown root:root /etc/monit.conf && chmod 600 /etc/monit.conf
ADD monit/httpd /etc/monit.d/
ADD monit/mysqld /etc/monit.d/
ADD monit/carbon-cache /etc/monit.d/
RUN chown root:root /etc/monit.d/* && chmod 600 /etc/monit.d/*
#
EXPOSE 3306 2003 2004 7002 80 2812
CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit.conf"]

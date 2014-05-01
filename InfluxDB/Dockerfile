FROM centos
MAINTAINER YOHEI KAWAHARA inokappa
RUN yum -y install wget sudo openssh-server
RUN cd /tmp/ && wget http://s3.amazonaws.com/influxdb/influxdb-latest-1.x86_64.rpm
RUN cd /tmp/ && rpm -ivh influxdb-latest-1.x86_64.rpm
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
# Please change your password
RUN echo sandbox:sandox | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
# 8083 is http admin interface
# 8086 is http api interface
# 8099 is cluster interface(maybe)
EXPOSE 8083 8086 8099 22
#
CMD ["/usr/bin/influxdb","-pidfile", "/opt/influxdb/shared/influxdb.pid","-config","/opt/influxdb/shared/config.toml"]

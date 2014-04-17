FROM centos
RUN yum -y install sudo
RUN cd /tmp/ && wget http://s3.amazonaws.com/influxdb/influxdb-latest-1.x86_64.rpm
RUN cd /tmp/ && rpm -ivh influxdb-latest-1.x86_64.rpm

#
FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install build-essential wget sudo ruby1.9.3 rubygems redis-server erlang-nox puppet openssh-server
RUN gem install json --no-ri --no-rdoc -V
RUN puppet module install sensu/sensu
ADD rabbitmq_certs_install.sh /root/
RUN chmod 755 /root/rabbitmq_certs_install.sh && /root/rabbitmq_certs_install.sh
RUN /root/rabbitmq_certs_install.sh
#
ADD puppet/site.pp /etc/puppet/manifests/
ADD puppet/fileserver.conf /etc/puppet/
RUN mkdir -p /etc/puppet/files/sensu
RUN cp /tmp/ssl_certs/client/cert.pem /etc/puppet/files/sensu/
RUN cp /tmp/ssl_certs/client/key.pem /etc/puppet/files/sensu/
#
RUN cd /etc/puppet && puppet apply manifests/site.pp
#
RUN cp /tmp/ssl_certs/client/cert.pem /etc/sensu/ssl/
RUN cp /tmp/ssl_certs/client/key.pem /etc/sensu/ssl/
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
RUN echo sandbox:sandbox | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
ADD start.sh /root/
RUN chmod 755 /root/start.sh
# for ssh
#EXPOSE 22
# for all process management via monit (in the future)
#EXPOSE 2812
#CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]

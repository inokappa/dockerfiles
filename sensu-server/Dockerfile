#
FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install build-essential wget sudo ruby1.9.3 rubygems redis-server erlang-nox puppet openssh-server
RUN gem install json --no-ri --no-rdoc -V
RUN puppet module install sensu/sensu
ADD rabbitmq_install.sh /root/
RUN chmod 755 /root/rabbitmq_install.sh && /root/rabbitmq_install.sh
ADD site.pp /etc/puppet/manifests/
RUN cd /etc/puppet && puppet apply --verbose manifests/site.pp
ADD config.json /etc/sensu/
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
# Please change your password
RUN echo sandbox:sandbox | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
# for sensu dashboard
EXPOSE 80
# for ssh
EXPOSE 22
# for monit
#EXPOSE 2812
#CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]

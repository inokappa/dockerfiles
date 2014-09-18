#
FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install build-essential wget sudo ruby1.9.3 rubygems redis-server erlang-nox puppet openssh-server
RUN gem install json --no-ri --no-rdoc -V
RUN puppet module install sensu/sensu
#
ADD puppet/site.pp /etc/puppet/manifests/
ADD puppet/fileserver.conf /etc/puppet/
RUN mkdir -p /etc/puppet/files/sensu
#
RUN cd /etc/puppet && puppet apply manifests/site.pp
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
RUN echo sandbox:sandbox | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
ADD start.sh /root/
RUN chmod 755 /root/start.sh

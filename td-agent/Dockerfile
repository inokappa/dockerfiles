FROM inokappa/wheezy-7.2-basic
#
RUN apt-get update
RUN apt-get -y install build-essential wget libxslt1.1 libyaml-0-2 openssh-server sudo nginx monit
#
RUN cd /tmp/ && wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
RUN cd /tmp/ && dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
RUN cd /tmp/ && wget http://packages.treasure-data.com/debian/pool/contrib/t/td-agent/td-agent_1.1.18-1_amd64.deb
RUN cd /tmp/ && dpkg -i td-agent_1.1.18-1_amd64.deb
RUN /usr/lib/fluent/ruby/bin/gem install fluent-plugin-norikra --no-ri --no-rdoc -V
RUN /usr/lib/fluent/ruby/bin/gem install fluent-plugin-elasticsearch --no-ri --no-rdoc -V
RUN /usr/lib/fluent/ruby/bin/gem install fluent-plugin-mongo --no-ri --no-rdoc -V
ADD td-agent.conf.example /etc/td-agent/td-agent.conf
ADD td-agent.conf /etc/monit/conf.d/td-agent.conf
ADD nginx.conf /etc/monit/conf.d/nginx.conf
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/tdagent -m -s /bin/bash tdagent
RUN echo tdagent:${your_password} | chpasswd
RUN echo 'tdagent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
EXPOSE 24220
EXPOSE 24224
EXPOSE 80
CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]

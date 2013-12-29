#
FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install build-essential wget openjdk-7-jdk libxslt1.1 libyaml-0-2 openssh-server sudo nginx monit
#
RUN cd /tmp && wget http://jruby.org.s3.amazonaws.com/downloads/1.7.9/jruby-bin-1.7.9.tar.gz
RUN cd /tmp/ && tar zxvf jruby-bin-1.7.9.tar.gz && cp -rf /tmp/jruby-1.7.9 /usr/local/jruby
ENV PATH $PATH:/usr/local/jruby/bin
RUN /usr/local/jruby/bin/jgem install norikra --no-ri --no-rdoc -V
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
ADD norikra.conf /etc/monit/conf.d/norikra.conf
RUN mv /etc/monit/monitrc.d/openssh-server /etc/monit/conf.d/openssh-server.conf
ADD monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc
ADD norikractl /usr/local/bin/norikractl
RUN chmod +x /usr/local/bin/norikractl
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
# Please change your password
RUN echo sandbox:your_password | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
# for norikra
EXPOSE 26571 
EXPOSE 26578 
# for fluentd
EXPOSE 24220
EXPOSE 24224
# for nginx
EXPOSE 80
# for ssh
EXPOSE 22
# for monit
EXPOSE 2812
CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]

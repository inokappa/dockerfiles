FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install build-essential wget openjdk-7-jdk libxslt1.1 libyaml-0-2 openssh-server sudo
#
RUN cd /tmp && wget http://jruby.org.s3.amazonaws.com/downloads/1.7.9/jruby-bin-1.7.9.tar.gz
RUN cd /tmp/ && tar zxvf jruby-bin-1.7.9.tar.gz && cp -rf /tmp/jruby-1.7.9 /usr/local/jruby
ENV PATH $PATH:/usr/local/jruby/bin
RUN /usr/local/jruby/bin/jgem install norikra --no-ri --no-rdoc -V
RUN cd /tmp/ && wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
RUN cd /tmp/ && dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
RUN cd /tmp/ && wget http://packages.treasure-data.com/debian/pool/contrib/t/td-agent/td-agent_1.1.18-1_amd64.deb
RUN cd /tmp/ && dpkg -i td-agent_1.1.18-1_amd64.deb
RUN /usr/lib/fluent/ruby/bin/gem install fluent-plugin-norikra --no-ri --no-rdoc -V
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/norikra -m -s /bin/bash norikra
RUN echo norikra:${your_password} | chpasswd
RUN echo 'norikra ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
EXPOSE 26571
EXPOSE 26578
CMD ["/usr/local/jruby/bin/norikra", "start"]

FROM inokappa/ubuntu
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
#
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:brightbox/ruby-ng-experimental
RUN echo "deb http://archive.ubuntu.com/ubuntu/ saucy universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install build-essential g++ libssl-dev nagios3 ruby2.0 ruby2.0-dev monit
RUN htpasswd -cb /etc/nagios3/htpasswd.users nagiosadmin nagiosadmin
RUN gem install nagira --no-ri --no-rdoc -V
RUN mkdir /var/log/nagira
ADD nagira.patch /tmp/nagira.patch
RUN nagira-setup config:config
RUN patch -u --ignore-whitespace /etc/init.d/nagira < /tmp/nagira.patch
#
ADD nagios3.conf.monit /etc/monit/conf.d/nagios3.conf
ADD nagira.conf.monit /etc/monit/conf.d/nagira.conf
ADD apache.conf.monit /etc/monit/conf.d/apache.conf
ADD sshd.conf.monit /etc/monit/conf.d/sshd.conf
ADD monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sandbox -m -s /bin/bash sandbox
RUN echo sandbox:sandbox | chpasswd
RUN echo 'sandbox ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
# for nagira
EXPOSE 4567
# for nagios
EXPOSE 80
# for ssh
EXPOSE 22
# for monit
EXPOSE 2812
#
CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]

FROM debian
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get -y update
RUN apt-get -y install sudo openssh-server
RUN apt-get -y install apache2
RUN apt-get -y install git
RUN apt-get -y install apache2-prefork-dev
RUN apt-get -y install rake
RUN apt-get -y install bison
RUN apt-get -y install libcurl4-openssl-dev
RUN apt-get -y install libhiredis-dev
RUN apt-get -y install libmarkdown2-dev
RUN apt-get -y install libcap-dev
RUN apt-get -y install libcgroup-dev
RUN apt-get -y install libssl-dev
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/sshuser -m -s /bin/bash sshuser
RUN echo sshuser:sshuser | chpasswd
RUN echo 'sshuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
RUN cd /root/ && git clone git://github.com/matsumoto-r/mod_mruby.git
RUN cd /root/mod_mruby && sh build.sh && make install
ADD mruby.load /etc/apache2/mods-available/
ADD mruby.conf /etc/apache2/mods-available/
RUN ln -nfs /etc/apache2/mods-available/mruby.load /etc/apache2/mods-enabled/mruby.load
RUN ln -nfs /etc/apache2/mods-available/mruby.conf /etc/apache2/mods-enabled/mruby.conf
RUN if [ -f /root/mod_mruby/test/test.rb ];then cp /root/mod_mruby/test/test.rb /var/www/ ; fi
RUN if [ ! -d /etc/apache2/hooks ];then mkdir /etc/apache2/hooks ; fi
ADD rewrite.rb /etc/apache2/hooks/
ADD handler.rb /etc/apache2/hooks/
ADD iphone.html /var/www/
ADD android.html /var/www/
#
EXPOSE 80
env APACHE_RUN_USER    www-data
env APACHE_RUN_GROUP   www-data
env APACHE_PID_FILE    /var/run/apache2.pid
env APACHE_RUN_DIR     /var/run/apache2
env APACHE_LOCK_DIR    /var/lock/apache2
env APACHE_LOG_DIR     /var/log/apache2
env LANG               C
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

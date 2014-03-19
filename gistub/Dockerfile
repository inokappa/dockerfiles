FROM centos
MAINTAINER YOHEI KAWAHARA inokara@gmail.com
RUN rpm -i http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y groupinstall "Development tools"
RUN yum -y install libyaml sqlite-devel libyaml-devel zlib-devel openssl-devel git readline-devel
RUN cd /root/ && wget http://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p545.tar.gz
RUN cd /root/ && tar zxvf ruby-1.9.3-p545.tar.gz
RUN cd /root/ruby-1.9.3-p545 && ./configure && make && make install
RUN gem install bundler --no-ri --no-rdoc -V
RUN gem install rb-readline --no-ri --no-rdoc -V
RUN mkdir /var/gistub
RUN cd /var/gistub && git clone git://github.com/seratch/gistub.git -b master
RUN /var/gistub/gistub/bin/bundle install
RUN cd /var/gistub/gistub/ && bin/rake db:migrate
EXPOSE 3000
RUN cd /var/gistub/gistub
CMD /var/gistub/gistub/bin/rails s

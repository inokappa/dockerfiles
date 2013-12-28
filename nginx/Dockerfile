FROM inokappa/wheezy-7.2-basic
#
MAINTAINER YOHEI KAWAHARA inokappa
#
RUN apt-get update
RUN apt-get -y install sudo openssh-server
RUN apt-get -y install nginx
#
RUN mkdir -p /var/run/sshd
RUN useradd -d /home/nginx -m -s /bin/bash nginx
RUN echo nginx:${your_password} | chpasswd
RUN echo 'nginx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
EXPOSE 80
#CMD service nginx start && tail -f /var/log/nginx/error.log
#ENTRYPOINT ["service","nginx","start"]
CMD ["service","nginx","start"]

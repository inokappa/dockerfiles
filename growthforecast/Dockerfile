FROM centos
RUN yum -y install sudo
RUN yum -y install ipa-gothic-fonts ipa-mincho-fonts ipa-pgothic-fonts ipa-pmincho-fonts
RUN yum -y groupinstall "Development Tools"
RUN yum -y install pkgconfig glib2-devel gettext libxml2-devel pango-devel cairo-devel
RUN sed -i 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers
RUN yum -y install cpan
RUN yes '' | cpan App::cpanminus
RUN cpanm -n GrowthForecast
RUN mkdir /var/lib/growthforecast
CMD ["/usr/local/bin/growthforecast.pl","--data-dir","/var/lib/growthforecast"]
EXPOSE 5125

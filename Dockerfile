FROM centos

RUN yum -y install dnsmasq

# centos-docker workaround
RUN echo "NETWORKING=yes" >/etc/sysconfig/network
# /etc/hosts values
RUN echo 'address="/fc2blog-tmp-sandbox.webtext.pw/127.0.0.1"' >> /etc/dnsmasq.d/0hosts

# dnsmasq configuration
RUN echo 'listen-address=127.0.0.1' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf

RUN echo 'user=root' >> /etc/dnsmasq.conf

# google dns
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

RUN service dnsmasq start

# apache install
RUN yum -y install httpd

# sensu-client install
ADD sensu-client/sensu.repo /etc/yum.repos.d/
RUN yum -y install sensu
ADD sensu-client/config.json /etc/sensu/

# use sensu-embedded-ruby like systems-ruby
RUN rm -rf /usr/local/bin
RUN ln -s /opt/sensu/embedded/bin /usr/local/bin

#httpd ready
ADD httpd.conf  /etc/httpd/conf/httpd.conf
RUN mkdir -p /var/www/html/public && chmod 755 /var/www/html/public && chown apache:apache /var/www/html/public
RUN echo '<h2>hello,apache!!</h2>' > /var/www/html/public/index.html

ADD . /tmp/wd-endpoint

#read sensu-server-host, set it to config.json ,sensu-client start and apache start
CMD ruby /tmp/wd-endpoint/json_replace.rb && service sensu-client start && /usr/sbin/apachectl -D FOREGROUND

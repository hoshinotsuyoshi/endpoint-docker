FROM centos

RUN yum -y install dnsmasq

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


#apache
RUN yum -y install httpd

#httpd ready
ADD httpd.conf  /etc/httpd/conf/httpd.conf
RUN mkdir -p /var/www/html/public && chmod 755 /var/www/html/public && chown apache:apache /var/www/html/public
RUN echo '<h2>hello,apache!!</h2>' > /var/www/html/public/index.html



CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

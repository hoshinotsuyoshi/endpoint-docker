FROM centos

#apache
RUN yum -y install httpd

#httpd ready
ADD httpd.conf  /etc/httpd/conf/httpd.conf
RUN mkdir -p /var/www/html/public && chmod 755 /var/www/html/public && chown apache:apache /var/www/html/public
RUN echo '<h2>hello,apache!!</h2>' > /var/www/html/public/index.html

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

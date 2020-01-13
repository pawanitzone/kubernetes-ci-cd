FROM centos:7
MAINTAINER pawanittraining@gmail.com

RUN yum install httpd -y
ADD code/ /var/www/html/

EXPOSE 80

CMD ["-D","FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]


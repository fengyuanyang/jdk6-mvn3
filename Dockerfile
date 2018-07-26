FROM jhouzard/docker-jdk6-mvn3

MAINTAINER OwenYang <coolsealtw@hotmail.com>
RUN apt-get update \
 && apt-get install -y git vim dos2unix libtcnative-1 libapr1 libapr1-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /var/tmp/*

ENV TOMCATVER 7.0.90

RUN (\
  wget -O /tmp/tomcat7.tar.gz http://archive.apache.org/dist/tomcat/tomcat-7/v$TOMCATVER/bin/apache-tomcat-$TOMCATVER.tar.gz && \
  cd /opt && \
  tar zxf /tmp/tomcat7.tar.gz && \
  mv /opt/apache-tomcat* /opt/tomcat && \
  rm /tmp/tomcat7.tar.gz)


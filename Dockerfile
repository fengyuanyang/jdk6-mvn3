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

RUN rm -fr /opt/apache-maven-${MAVEN_VERSION} /opt/maven
ENV MAVEN_VERSION=3.2.5

# Install maven
RUN wget --no-verbose -O /tmp/apache-maven-${MAVEN_VERSION}.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar xzf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt/ \
 && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
 && rm -f /tmp/apache-maven-${MAVEN_VERSION}.tar.gz

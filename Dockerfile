FROM ubuntu:18.10

MAINTAINER OwenYang <coolsealtw@hotmail.com>

ENV MAVEN_VERSION=3.2.5
ENV JAVA_VERSION_MAJOR=6
ENV JAVA_VERSION_MINOR=45
ENV JAVA_VERSION_BUILD=06

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# update dpkg repositories
RUN apt-get update \
 && apt-get install -y wget git vim dos2unix libtcnative-1 libapr1 libapr1-dev nodejs npm \
 && apt-get clean

# Install maven
RUN wget --no-verbose -O /tmp/apache-maven-${MAVEN_VERSION}.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar xzf /tmp/apache-maven-${MAVEN_VERSION}.tar.gz -C /opt/ \
 && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
 && rm -f /tmp/apache-maven-${MAVEN_VERSION}.tar.gz

ENV MAVEN_HOME /opt/maven

# Install java
COPY ./jdk-6u45-linux-x64.bin .
RUN chmod +x jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin \
 && ./jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin \
 && rm jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.bin \
 && mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/oracle-jdk-1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} \
 && ln -s /opt/oracle-jdk-1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/java

ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH

ENV TOMCATVER 7.0.90

RUN (\
  wget -O /tmp/tomcat7.tar.gz http://archive.apache.org/dist/tomcat/tomcat-7/v$TOMCATVER/bin/apache-tomcat-$TOMCATVER.tar.gz && \
  cd /opt && \
  tar zxf /tmp/tomcat7.tar.gz && \
  mv /opt/apache-tomcat* /opt/tomcat && \
  rm /tmp/tomcat7.tar.gz)

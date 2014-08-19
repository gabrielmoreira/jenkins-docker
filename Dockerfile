FROM jpetazzo/dind

ENV HOME /root
ENV JENKINS_HOME /var/jenkins_home

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ADD build-files /build

RUN /build/install_java8 && \
	/build/clean

RUN /build/install_jenkins release && \
    /build/fix_jenkins_23232_bug && \
    /build/clean

RUN /build/install_supervisor && \
    /build/clean
    

VOLUME /var/jenkins_home

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
FROM jpetazzo/dind

# Global envs
ENV HOME /root

# Default locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Build files
ADD build-files /build

# Install Oracle Java 8
RUN /build/install_java8 && \
	/build/clean

# Install Jenkins latest release
RUN /build/install_jenkins release && \
    /build/clean

# Install supervisor
RUN /build/install_supervisor && \
    /build/clean

# App envs
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JENKINS_HOME /var/jenkins_home

VOLUME /var/jenkins_home

# Expose default jenkins port
EXPOSE 8080

# Start supervisor (runs wrapdocker and jenkins)
CMD ["/usr/bin/supervisord"]
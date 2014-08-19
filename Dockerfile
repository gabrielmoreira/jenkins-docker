FROM jpetazzo/dind

ADD build-files /build

RUN /build/upgrade_apt && \
    /build/install_java8 && \
    /build/install_jenkins release && \
    /build/fix_jenkins_23232_bug && \
    /build/startup_jenkins && \
    /build/clean

VOLUME /var/lib/jenkins

EXPOSE 8080

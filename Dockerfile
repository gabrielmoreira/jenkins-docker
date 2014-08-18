FROM jpetazzo/dind

ADD build-files /build

RUN /build/install_java8 && \
    /build/install_jenkins release && \
    /build/clean

VOLUME /var/lib/jenkins

EXPOSE 8080

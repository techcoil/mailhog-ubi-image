FROM registry.access.redhat.com/ubi9/go-toolset:1.20.12-3 as builder
USER root
RUN yum update -y
RUN yum install -y git \
    && mkdir /root/gocode \
    && export GOPATH=/root/gocode \
    && go install "github.com/mailhog/MailHog@v1.0.1"


FROM registry.access.redhat.com/ubi9/ubi-init:9.3-12 as runtime
USER root

ARG MH_UI_USERNAME
ARG MH_UI_PASSWORD

ENV NAME=mailhog \
    CONTAINER_NAME="techcoil/mailhog"

RUN yum update -y \
    && yum install -y httpd-tools \
    && yum clean all -y

RUN mkdir /home/run

WORKDIR /home/run

COPY entrypoint.sh /home/run
COPY --from=builder /root/gocode/bin/MailHog /usr/local/bin/

USER 1001

ENTRYPOINT ["bash", "entrypoint.sh"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025

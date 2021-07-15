FROM centos:8
MAINTAINER by fxl (fxl0206@gmail.com)

COPY sshfile/* /etc/ssh/

RUN mkdir -p /root/.ssh && \
    mv /etc/ssh/authorized_keys /root/.ssh/authorized_keys && \
    chmod 600 /etc/ssh/ssh_host_rsa_key && \
    chmod 600 /etc/ssh/ssh_host_ed25519_key && \
    chmod 600 /etc/ssh/ssh_host_ecdsa_key && \
    chmod 600 /root/.ssh/authorized_keys

RUN yum -y update && yum -y install openssh-server net-tools openssh-clients lrzsz  && \
    sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config && \
    echo "root:123456"|chpasswd && \
    yum clean all

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd","-D"]


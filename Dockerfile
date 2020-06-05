FROM centos:centos7.8.2003
MAINTAINER by lxc (fxl0206@gmail.com)

ADD sshfile/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
ADD sshfile/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
ADD sshfile/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
ADD sshfile/ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
ADD sshfile/authorized_keys /root/.ssh/authorized_keys


RUN mkdir -p /root/.ssh && \
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


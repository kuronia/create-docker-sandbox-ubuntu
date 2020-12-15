FROM ubuntu:20.04
RUN \
  apt-get update && \
  apt-get -y install ssh && \
  apt-get -y install sudo && \
  apt-get -y install iputils-ping && \
  apt-get -y install iproute2 && \
  apt-get -y install vim && \
  apt-get -y install python

ARG USER
ARG PASS

RUN \
  useradd -m $USER && \
  echo "$USER:$PASS" | chpasswd && \
  echo "$USER ALL=(ALL) ALL" >> /etc/sudoers && \
  mkdir /home/${USER}/.ssh

COPY id_rsa.pub /home/${USER}/.ssh/authorized_keys
COPY init.sh /
COPY .bash_profile /home/${USER}

RUN chsh -s /bin/bash ${USER}

CMD /bin/bash
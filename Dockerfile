FROM ubuntu:jammy

RUN apt-get update
RUN apt-get clean
RUN apt-get -y install sudo curl git

# make user, change password to test and make superuser so no password needed for sudo (and enter userspace)
RUN useradd -ms /bin/bash testuser && echo "testuser:test" | chpasswd && adduser testuser sudo 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER testuser

# copy across this repo
COPY . /home/testuser/.dotfiles
WORKDIR /home/testuser/.dotfiles

# run install script
RUN rm ~/.profile
RUN ./install

# enter container with zsh
ENTRYPOINT [ "/bin/zsh" ]
CMD ["-l"]

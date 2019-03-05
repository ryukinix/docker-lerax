FROM debian:9.7
RUN apt-get update && apt-get install sudo git curl bash emacs25-nox -y
RUN curl -sL dotfiles.lerax.me | bash
RUN emacs --daemon # force emacs download packages and quit
RUN apt-get install zsh -y
RUN chsh --shell /bin/zsh
# Set the locale
RUN apt-get install locales -y
RUN sed --in-place '/en_US.UTF-8/s/^#//' /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color
WORKDIR /workspace
ENTRYPOINT ["emacs"]

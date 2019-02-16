FROM debian:9.7
RUN apt-get update && apt-get install sudo git curl bash emacs25-nox -y
RUN curl -sL dotfiles.lerax.me | bash
RUN emacs --daemon # force emacs download packages and quit
RUN apt-get install zsh -y
RUN chsh --shell /bin/zsh
# Set the locale
RUN apt-get install locales -y
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN locale-gen
ENV SHELL=/bin/zsh
WORKDIR /workspace
ENTRYPOINT ["emacs"]

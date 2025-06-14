FROM debian:bookworm
ARG EXTRA_PACKAGES=""
RUN apt-get update && apt-get install sudo git curl bash emacs-nox zsh $EXTRA_PACKAGES -y
RUN chsh --shell /bin/zsh
RUN apt-get install locales -y
RUN sed --in-place '/en_US.UTF-8/s/^#//' /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV SHELL=/bin/zsh
ENV TERM=xterm-256color

# invalidate cache for all stuff below, ensure install last dotfiles version
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN curl -sL dotfiles.lerax.me | bash
RUN emacs --daemon # force emacs download packages and quit
RUN echo "(setq native-comp-deferred-compilation nil)" > /root/.emacs.d/early-init.el
WORKDIR /workspace
ENTRYPOINT ["emacs"]

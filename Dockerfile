FROM alpine:3.9

# tinytex dependencies
RUN apk --no-cache add \
  perl  \
  wget \
  xz \
  tar \
  fontconfig \
  freetype \
  lua \
  gcc

# Create user and related home
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
WORKDIR /home/appuser

# setup path
ENV PATH=/home/appuser/.TinyTeX/bin/x86_64-linuxmusl/:$PATH

# download and install tinytex
RUN wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh

# add tlmgr to path
RUN /home/appuser/.TinyTeX/bin/*/tlmgr path add

# install texlive packages
RUN tlmgr install \
    preview \
    standalone \
    dvisvgm


# Use the official Debian base image
FROM debian:bullseye as builder
ARG BUILD_CONFIG
# Set noninteractive mode for Debian package installations
ENV DEBIAN_FRONTEND=noninteractive
# Set the working directory
WORKDIR /tmux
# Install dependencies
RUN apt-get update && apt-get install -y \
git \
automake \
build-essential \
pkg-config \
libevent-dev \
libncurses5-dev \
bison
# Clone the tmux repository and checkout version 3.4(Versions can be switched)
RUN git clone https://github.com/tmux/tmux.git . && git checkout 3.4
# Generate the configure script
RUN sh autogen.sh
# Configure and build tmux
RUN ./configure $BUILD_CONFIG && make
# Install tmux
RUN make install
# Set the default command to run tmux

CMD ["/bin/bash"]

FROM scratch AS binaries
COPY --from=builder /tmux/tmux /

# Base image with latest Ubuntu
FROM ubuntu:latest

# Prevent timezone prompt
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Define package groups as environment variables
ENV COMMON_DEPS="sudo locales ca-certificates apt-transport-https gnupg lsb-release unzip wget"
ENV BUILD_DEPS="build-essential software-properties-common ncurses-dev file curl"
ENV HOMEBREW_DEPS="git"
ENV EDITOR_DEPS="fonts-powerline fd-find ripgrep"

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    $COMMON_DEPS \
    $BUILD_DEPS \
    $HOMEBREW_DEPS \
    $EDITOR_DEPS \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create a non-root user
ARG USERNAME=developer
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to non-root user for Homebrew installation
USER $USERNAME
WORKDIR /home/$USERNAME

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc \
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install Git and Zsh from Homebrew
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && brew install git zsh

# Install Oh My Zsh
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

COPY --chown=$USERNAME:$USERNAME ./config/zshrc /home/$USERNAME/.zshrc

# Install Neovim using Homebrew
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && brew install neovim

# Install language version managers and tools
# Install uv for Python
RUN curl -fsSL https://astral.sh/uv/install.sh | sh \
    && echo '# uv for Python Management' >> ~/.zshrc \
    && echo 'export PATH="$HOME/.cargo/bin:$PATH"' "\n" >> ~/.zshrc \

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash \
    && echo '# Bun for JavaScript/TypeScript' >> ~/.zshrc \
    && echo 'export BUN_INSTALL="$HOME/.bun"' >> ~/.zshrc \
    && echo 'export PATH="$BUN_INSTALL/bin:$PATH"' "\n" >> ~/.zshrc

# Install rbenv and ruby-build
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install rbenv ruby-build 

# Install jenv for Java support
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install jenv \
    && echo '# jenv for Java Management' >> ~/.zshrc \
    && echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc \
    && echo 'eval "$(jenv init -)"' "\n" >> ~/.zshrc \
    && mkdir -p ~/.jenv/versions
    
# Create directories for config files if they don't exist
RUN mkdir -p /home/$USERNAME/.config/nvim 

# Set up kickstart.nvim
RUN git clone https://github.com/nvim-lua/kickstart.nvim.git /home/$USERNAME/.config/nvim \
    && rm -rf /home/$USERNAME/.config/nvim/.git

# Copy configuration files
COPY --chown=$USERNAME:$USERNAME ./config/welcome.sh /home/$USERNAME/welcome.sh

# Make welcome script executable
RUN chmod +x /home/$USERNAME/welcome.sh

# Add welcome script to .zshrc
RUN echo 'source $HOME/welcome.sh' >> ~/.zshrc

# Create symbolic link for fd-find
RUN mkdir -p /home/$USERNAME/bin \
    && ln -s $(which fdfind) /home/$USERNAME/bin/fd

# Install Mason dependencies for LSP support
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install npm python3 \
    && nvim --headless +PackerInstall +qall \
    && nvim --headless +qall

# Set zsh as default shell
USER root
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && chsh -s $(which zsh) $USERNAME

# Switch back to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# Default command
CMD ["/home/linuxbrew/.linuxbrew/bin/zsh"]


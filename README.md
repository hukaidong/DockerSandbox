# Docker Development Sandbox

A customizable Docker-based development environment that provides a consistent and portable sandbox for testing and development.

## Features

- 🐳 Based on **Ubuntu** with modern tools installed via **Homebrew**
- 🐚 **Zsh** with **Oh My Zsh** as the default shell
- 📝 **Neovim** with **kickstart.nvim** - a powerful, ready-to-use configuration
- 🔄 **Environment Modules** for managing language-specific environments:
  - 🐍 **Python** environment using **uv**
  - 📦 **NodeJS** environment using **Bun**
  - 💎 **Ruby** environment using **rbenv**

## Prerequisites

- Docker Desktop / Docker Engine
- Docker Compose (optional, for multi-container applications)

## Quick Start

### Build the Docker Image

```bash
docker build -t dev-sandbox .
```

### Run the Container

```bash
docker run -it --name my-sandbox dev-sandbox
```

For persistent development, you might want to mount a volume:

```bash
docker run -it --name my-sandbox -v $(pwd)/workspace:/home/developer/workspace dev-sandbox
```

Alternatively, use the provided build script:

```bash
# Build the image
./build.sh build

# Run a container
./build.sh run

# Run with a custom workspace
./build.sh --workspace ~/projects run
```

## Using the Environment

Upon starting the container, you'll be greeted with a welcome message showing available tools and modules.

### Loading Language Environments

The environment comes with pre-configured modules for different programming languages:

```bash
# Load Python environment with uv
module load python

# Load NodeJS environment with Bun
module load nodejs

# Load Ruby environment with rbenv
module load ruby
```

### Using Neovim with kickstart.nvim

The container includes Neovim with the kickstart.nvim configuration:

```bash
nvim file.py  # Open a file with Neovim
```

Key kickstart.nvim features:
- LSP (Language Server Protocol) for code completion and diagnostics
- Treesitter for better syntax highlighting
- Telescope for fuzzy finding (`<space>ff`)
- Which-key for command hints (press `<space>` and wait)
- Git integration
- Debugging capabilities
- And much more!

For full documentation, visit the [kickstart.nvim repository](https://github.com/nvim-lua/kickstart.nvim).

### Installing Additional Packages

You can install additional packages using Homebrew:

```bash
brew install package-name
```

## Customization

### Adding New Modules

To add new modules, create a file in the `config/modulefiles` directory:

```bash
# Create a new module file
touch config/modulefiles/my-module
```

Then edit the file following the Tcl module format like the existing modules.

### Customizing Neovim

Since we're using kickstart.nvim, you can create a `~/.config/nvim/lua/custom` directory in the container to add your own customizations without modifying the core configuration.

For more information, see the [kickstart.nvim customization guide](https://github.com/nvim-lua/kickstart.nvim#customization).

### Customizing Zsh

Modify `config/zshrc` to customize your shell experience. You can add new aliases, functions, or plugins.

## License

MIT 
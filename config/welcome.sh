#!/bin/bash

cat << "EOF"
 ____                 _ _               
/ ___|  __ _ _ __   __| | |__   _____  __
\___ \ / _` | '_ \ / _` | '_ \ / _ \ \/ /
 ___) | (_| | | | | (_| | |_) | (_) >  < 
|____/ \__,_|_| |_|\__,_|_.__/ \___/_/\_\
                                        
Development Sandbox Environment
EOF

echo -e "\n\033[1mWelcome to the Development Sandbox Environment!\033[0m"
echo -e "\nThis container includes the following tools:"
echo -e "  • \033[33mZsh\033[0m with Oh My Zsh as the default shell"
echo -e "  • \033[33mNeovim\033[0m with \033[33mkickstart.nvim\033[0m configuration"
echo -e "  • \033[33mHomebrew\033[0m for package management"
echo -e "  • \033[33mEnvironment Modules\033[0m for managing language environments"

echo -e "\n\033[1mAvailable modules:\033[0m"
echo -e "  • \033[32mmodule load python\033[0m - Python environment with uv"
echo -e "  • \033[32mmodule load nodejs\033[0m - NodeJS environment with bun"
echo -e "  • \033[32mmodule load ruby\033[0m - Ruby environment with rbenv"

echo -e "\n\033[1mUseful commands:\033[0m"
echo -e "  • \033[32mneovim\033[0m or \033[32mnvim\033[0m - Start the Neovim editor with kickstart.nvim"
echo -e "  • \033[32mbrew install <package>\033[0m - Install packages using Homebrew"
echo -e "  • \033[32mmodule avail\033[0m - List all available modules"
echo -e "  • \033[32mmodule list\033[0m - List loaded modules"

echo -e "\n\033[1mAbout kickstart.nvim:\033[0m"
echo -e "Kickstart.nvim provides a modern, feature-rich Neovim configuration with:"
echo -e "  • \033[32mLSP\033[0m - Code completion, diagnostics, and more"
echo -e "  • \033[32mTreesitter\033[0m - Advanced syntax highlighting"
echo -e "  • \033[32mTelescope\033[0m - Fuzzy finder (try \033[32m<space>ff\033[0m)"
echo -e "  • \033[32mWhich-key\033[0m - Command hints (press \033[32m<space>\033[0m and wait)"
echo -e "  • \033[32mMany more features...\033[0m"

echo -e "\nEnjoy your development experience!"
echo -e "-----------------------------------------------------\n" 
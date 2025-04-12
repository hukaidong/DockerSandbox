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
echo -e "  • \033[33mZsh\033[0m with Oh My Zsh as the default shell (Homebrew managed)"
echo -e "  • \033[33mGit\033[0m version control (Homebrew managed)"
echo -e "  • \033[33mNeovim\033[0m with \033[33mkickstart.nvim\033[0m configuration"
echo -e "  • \033[33mHomebrew\033[0m for package management"

echo -e "\n\033[1mLanguage version managers:\033[0m"
echo -e "  • \033[33muv\033[0m for Python package management"
echo -e "  • \033[33mrbenv\033[0m for Ruby version management"
echo -e "  • \033[33mjenv\033[0m for Java version management"
echo -e "  • \033[33mBun\033[0m for JavaScript/TypeScript"

echo -e "\n\033[1mUseful commands:\033[0m"
echo -e "  • \033[32mneovim\033[0m or \033[32mnvim\033[0m - Start the Neovim editor with kickstart.nvim"
echo -e "  • \033[32mbrew install <package>\033[0m - Install packages using Homebrew"
echo -e "  • \033[32mjenv add <path>\033[0m - Add a Java version to jenv"
echo -e "  • \033[32mjenv local/global <version>\033[0m - Set Java version for project or globally"

echo -e "\n\033[1mAbout kickstart.nvim:\033[0m"
echo -e "Kickstart.nvim provides a modern, feature-rich Neovim configuration with:"
echo -e "  • \033[32mLSP\033[0m - Code completion, diagnostics, and more"
echo -e "  • \033[32mTreesitter\033[0m - Advanced syntax highlighting"
echo -e "  • \033[32mTelescope\033[0m - Fuzzy finder (try \033[32m<space>ff\033[0m)"
echo -e "  • \033[32mWhich-key\033[0m - Command hints (press \033[32m<space>\033[0m and wait)"
echo -e "  • \033[32mMany more features...\033[0m"

echo -e "\nEnjoy your development experience!"
echo -e "-----------------------------------------------------\n" 
#!/bin/bash

# Determine the OS
OS=$(grep "^NAME=" /etc/os-release | cut -d '"' -f 2)

# Install fzf based on OS
install_fzf() {
    if [[ $OS == "Ubuntu" ]]; then
        sudo apt-get install -y fzf > /dev/null 2>&1
    elif [[ $OS == "CentOS" ]]; then
        sudo yum install -y fzf > /dev/null 2>&1
    else
        echo "Unsupported OS"
        exit 1
    fi
}

install_fzf

# Menu options
options=(
    "🚆    High-Speed Train"
    "🔥    Blaze of Fire"
    "🐶    Loyal Pet"
    "👀    Eagle Eyes"
    "🗣️     I speak!"
    "🌊    Underwater World"
    "⚠️     Danger"
    "🔮    Wheel of Fortune"
    "🖼️     ASCII Sketch"
    "✨    Who am I?"
    "❌    Quit"
)

# Simple names for each option
simple_names=(
    "train"
    "fire"
    "pet"
    "eyes"
    "speakup"
    "underwater"
    "hacked"
    "fortune"
    "ascii_sketch"
    "text_animation"
)

# Function to install packages based on OS
install_package() {
    local package_name=$1
    if [[ $OS == "Ubuntu" ]]; then
        sudo apt -y install "$package_name" > /dev/null 2>&1
    elif [[ $OS == "CentOS" ]]; then
        sudo yum -y install "$package_name" > /dev/null 2>&1
    else
        echo "Unsupported OS"
    fi
}

# Function to run utilities
run_utility() {
    case "$1" in
        "train")
            install_package "sl"
            echo "Wait for your train...choo choo !!!"
            sl | lolcat
            ;;
        "fire")
            echo "Bringing your fire out..."
            if [[ $OS == "Ubuntu" ]]; then
                install_package "libaa-bin"
            elif [[ $OS == "CentOS" ]]; then
                install_package "aalib"
            fi
            aafire
            ;;
        "pet")
            install_package "oneko"
            echo "Say hi !!!"
            echo "Press Ctrl+c to change pet"
            oneko -sakura -bg white -fg blue
            oneko -dog -bg white -fg brown
            oneko -tora -bg white -fg purple
            oneko -tomoyo -bg white -fg red
            ;;
        "eyes")
            if [[ $OS == "Ubuntu" ]]; then
                install_package "x11-apps"
            elif [[ $OS == "CentOS" ]]; then
                install_package "xeyes"
            fi
            xeyes
            ;;
        "speakup")
            install_package "espeak"
            espeak "Hello $(whoami)" | lolcat
            ;;
        "underwater")
            install_package "asciiquarium"
            asciiquarium | lolcat
            ;;
        "hacked")
            install_package "toilet"
            linuxlogo -logo -a | toilet -f term | lolcat
            toilet 'You are hacked!' | boxes -d cat -a hc -p h8 | lolcat
            ;;
        "fortune")
            install_package "cowsay"
            install_package "fortune"
            fortune | cowsay | lolcat
            ;;
        "ascii_sketch")
            install_package "aview"
            convert "/path/to/your/image.jpg" test.pgm
            aview test.pgm
            ;;
        "text_animation")
            install_package "figlet"
            figlet "Hello, $(whoami)" | lolcat
            ;;
        "quit")
            echo "Exiting the script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Come again!"
            ;;
    esac
}

# Display the fzf menu for selection
selected=$(printf "%s\n" "${options[@]}" | fzf --pointer="*" --border --height=16 --prompt="Select an option: ")

# Get the index of the selected option
selected_index=$(printf "%s\n" "${options[@]}" | grep -n "$selected" | cut -d: -f1)
selected_index=$((selected_index-1))

# Run the selected function
run_utility "${simple_names[$selected_index]}"

#!/bin/bash

# Function to install a package based on OS
install_package() {
    local package_name=$1
    OS=$(grep "^NAME=" /etc/os-release | cut -d '"' -f 2)

    if [[ $OS == "Ubuntu" ]]; then
        sudo apt-get -y install "$package_name" > /dev/null 2>&1
    elif [[ $OS == "CentOS" ]]; then
        sudo yum -y install "$package_name" > /dev/null 2>&1
    else
        echo "Unsupported OS"
    fi
}

# Install necessary packages for the fortune-telling script
install_package "fortune"
install_package "cowsay"
install_package "espeak"
install_package "lolcat"
install_package "toilet"

# Fortune-telling function
fortune_telling() {
    echo "🔮 Welcome to the Fortune Teller! 🔮"
    
    # Get a fortune and save it to a variable
    fortune_text=$(fortune)

    # Display a fancy banner with "Fortune" using toilet and lolcat
    toilet -f big "Fortune" | lolcat
    
    # Print the fortune using cowsay and make it colorful with lolcat
    echo "$fortune_text" | cowsay -f tux | lolcat

    # Read the fortune aloud using espeak
    espeak "$fortune_text"

    # Display the same fortune with toilet and lolcat for extra flair
    echo ""
    echo "Your fortune in fancy text:"
    echo "$fortune_text" | toilet -f term | lolcat
    echo ""
    
    echo "🔮 That’s your fortune! Come back for more wisdom! 🔮"
}

# Display the fortune
fortune_telling


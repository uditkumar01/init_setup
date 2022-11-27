#  gray color
echo -e "\e[1;30mEnter your Name: \e[0m"
read name
echo -e "\e[1;30mEnter your Email: \e[0m"
read email

# run above command using color
echo -e "\e[1;32mGenerating SSH key for $email\e[0m"

# set git config
git config --global user.name "$name"
git config --global user.email "$email"

if [ -z "$name" ] || [ -z "$email" ]; then
    echo "Name or email is empty"
    exit 1
fi

ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
clip < ~/.ssh/id_ed25519.pub

echo ""
echo -e "\e[1;32mSSH key copied to clipboard\e[0m"

start https://github.com/settings/keys
#!/usr/bin/env bash

# Sets up symlinks pointing to the users Espanso config
# Licensed under MIT, (C) Alicia Sykes 2022 <aliciasykes.com>

# Color constants
C_ERR="\033[1;93m⚠️ "
C_UNDER="\e[4m"
C_RESET="\033[0m"
C_BCyan="\033[1;96m"
C_NCYAN='\033[0;96m'
C_LCYAN='\033[0;36m'

# Show help menu
print_help() {
  welcome_msg="\n$C_BCyan Script Add / Remove Symbolic Links to Espanso Config$C_RESET\n"
  welcome_msg="$welcome_msg$C_NCYAN All configuration paramaters are optional\n"
  welcome_msg="$welcome_msg$C_NCYAN Note that -d and -s must come before any other option, if specified\n"
  welcome_msg="$welcome_msg$C_NCYAN  -s [path]\t$C_LCYAN Sets 'ESPANSO_SRC_PATH'," 
  welcome_msg="$welcome_msg which is the path of source files\n"
  welcome_msg="$welcome_msg$C_NCYAN  -d [path]\t$C_LCYAN Sets 'ESPANSO_DEST_PATH',"
  welcome_msg="$welcome_msg the path for destination files\n"
  welcome_msg="$welcome_msg$C_NCYAN  -l\t\t$C_LCYAN Apply symlinks to Espanso dir\n"
  welcome_msg="$welcome_msg$C_NCYAN  -r\t\t$C_LCYAN Removes symlink (original files remain intact)" 
  echo -e $welcome_msg$C_RESET
  exit 1
}

# Check that Espanso is installed
if ! hash "espanso" 2> /dev/null; then
  echo -e "$C_ERR Espanso does not appear to be installed, exiting\033[0m"
  exit 1
fi

# Either uses specified paths, or determines defaults, then checks they exist
set_paths() {
  # Get the Espanso config path, using the espanso CLI
  ESPANSO_DEST_PATH=${ESPANSO_DEST_PATH:=$(espanso path | grep 'Config: ' | sed 's/Config: //g')'/match'}

  # Get the source path for users config
  ESPANSO_SRC_PATH=${ESPANSO_SRC_PATH:=$(pwd)}

  # Ensure the Espanso config destination directory exists
  if [ ! -d $ESPANSO_DEST_PATH ] ; then
    echo -e "$C_ERR Cannot fine Espanso destination directory at $C_UNDER$ESPANSO_DEST_PATH$C_RESET"
    echo -e "\033[0;33mYou can manually specify this path using the -d option$C_RESET"
    exit 0
  fi

  # And check the source directory exisits
  if [ ! -d $ESPANSO_SRC_PATH ] ; then
    echo -e "$C_ERR Cannot fine Espanso source directory at $C_UNDER$ESPANSO_SRC_PATH$C_RESET"
    echo -e "\033[0;33mYou can manually specify this path using the -s option$C_RESET"
    exit 0
  fi
}

# Checks that path is a symlink, then recurisivley removes it
remove_link() {
  set_paths
  if [ -s $ESPANSO_DEST_PATH ] ; then
    echo "will remove $ESPANSO_DEST_PATH"
    find $ESPANSO_DEST_PATH -not -path "default.yml" -type l -delete
  fi
}

# Fetch paths, then make symlink
make_link() {
  set_paths
  echo -e "$C_BCyan Linking $C_UNDER$ESPANSO_SRC_PATH$C_BCyan to $C_UNDER$ESPANSO_DEST_PATH$C_NCYAN..."
  cp -rs "$ESPANSO_SRC_PATH"/* "$ESPANSO_DEST_PATH"/
  exit 1
}

# Run by default, if no flags provided. Asks user if they'd like to make symlinks
ask_to_make_link() {
  read -p "Would you like to symlink to Espanso config directory? (y/N)" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    make_link
  else
    echo -e "\033[1;96mNo worries, another time.$C_LCYAN\nBye for now 👋\033[0m"
    exit 1
  fi
}

# Allow user to pass optional config params
while getopts "hs:d:rl" arg; do
  case $arg in
    s) ESPANSO_SRC_PATH=$OPTARG;;
    d) ESPANSO_DEST_PATH=$OPTARG;;
    r) remove_link;;
    l) make_link;;
    h) print_help;;
    *) print_help;;
  esac
done

# If no option is selected, ask the user if they'd like to make link
ask_to_make_link

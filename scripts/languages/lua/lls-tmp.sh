#!/bin/bash

# Exit the script if any command fails
set -e


git clone https://github.com/LuaLS/lua-language-server
cd lua-language-server

./make.sh

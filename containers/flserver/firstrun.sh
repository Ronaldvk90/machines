#!/usr/bin/env bash

# Freelancer itself.
wine /freelancer/SETUP.EXE

# Ioncross (if present)
if [ -f "/home/ronald/freelancer/IFSO.exe" ]
then
wine /home/ronald/freelancer/IFSO.exe
else
echo -e "\033[0;33mIoncross FLserver Operator not found. You can install it later if you want to. :)\033[0m"
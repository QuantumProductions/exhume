#!/bin/sh
stty -f /dev/tty icanon raw
erl -pa ./ -run thing start -run init -noshell
clear
stty echo echok icanon -raw
echo "ok \n"

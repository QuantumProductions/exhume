#!/bin/sh
stty -f /dev/tty icanon raw
erl -pa ./ -run naive_tcp go -run init stop -noshell
stty echo echok icanon -raw

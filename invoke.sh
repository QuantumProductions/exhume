#!/bin/sh
stty -f /dev/tty icanon raw
erl -pa ./ -run thing start -run init stop -noshell
stty echo echok icanon -raw

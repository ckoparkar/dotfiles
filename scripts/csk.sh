#!/bin/bash

cp ~/.config/awesome/rc.lua.csk ~/.config/awesome/rc.lua

echo 'awesome.restart()' | awesome-client

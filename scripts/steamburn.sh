#!/bin/bash

cp ~/.config/awesome/rc.lua.steamburn ~/.config/awesome/rc.lua

echo 'awesome.restart()' | awesome-client

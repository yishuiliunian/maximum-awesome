#!/bin/sh


insertSecqunce='export PATH=$PATH:/opt/local/bin;'
if [ -f ~/.bashrc ]; then
    grep -q "$insertSecqunce" ~/.bashrc && echo "pass" || echo "$insertSecqunce\n" >> ~/.bashrc
else
    echo ".bashrc file dose not exist, create it"
    echo $insertSecqunce >> ~/.bashrc
fi


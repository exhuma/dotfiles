#!/bin/bash

# Mouse setup
echo "[II] Mouse setup..."
xinput --list | grep pointer
read -p "Pointer Device ID: " MOUSEDEV
xinput list-props ${MOUSEDEV} | grep "Constant Decel"
read -p "Decelleration ID: " DECCEL
xinput set-prop ${MOUSEDEV} ${DECCEL} 2.0

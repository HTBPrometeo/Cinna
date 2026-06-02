#!/bin/sh

IP=$(ip route get 1 | awk '{print $7; exit}')

echo "%{F#0077B6} %{F#ffffff}$IP%{u-}"

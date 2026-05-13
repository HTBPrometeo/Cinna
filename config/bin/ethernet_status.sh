#!/bin/sh

IP=$(ip route get 1 | awk '{print $7; exit}')

echo "%{F#A182FF} %{F#ffffff}$IP%{u-}"

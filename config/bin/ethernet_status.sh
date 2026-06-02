#!/bin/sh

IP=$(ip route get 1 | awk '{print $7; exit}')

echo "%{F#4AC6FF} %{F#ffffff}$IP%{u-}"

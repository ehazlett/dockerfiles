#!/bin/ash
CPU=$(mpstat 1 1 | tail -1 | awk '{ print $3;  }')
MEM=$(free | awk '/buffers\/cache/{print $3/($3+$4) * 100.0;}')

echo -n "$CPU $MEM"

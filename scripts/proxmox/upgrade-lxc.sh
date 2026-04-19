#!/bin/bash
# Cambiar 999 por los vmid que se quiera actualizar separados por espacios
# Añadir esta tarea a cron con crontab -e
# 0 4 * * * root /root/scripts/update-lxc.sh

for ct in 999; do
  pct exec $ct -- apt update -qq
  pct exec $ct -- apt upgrade -y
  pct exec $ct -- apt autoremove -y
  pct exec $ct -- apt clean
done

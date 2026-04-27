Instalar fail2ban

```
sudo apt install fail2ban
```

Verificar con

```
sudo systemctl status fail2ban
```

Se pueden ver los logs en `/var/log/fail2ban.log `

Los archivos de configuración están en /etc/fail2ban
Es mejor crear `fail2ban.local` y `jail.local`, que anulan a los .conf

- /etc/fail2ban/fail2ban.conf - Archivo de confiugración de fail2ban
- /etc/fail2ban/jail.conf - Define que servicios monitorizar y como responder
- /etc/fail2ban/filter.d/ - Filtros
- /etc/fail2ban/action.d - Acciones

### Comandos

#### Estado del servicio

- sudo fail2ban-client status
  Muestra todos los jails activos.

#### Estado de un jail específico

- sudo fail2ban-client status "jail"
  Muestra las IPŝ baneadas, los intentos fallidos, y el estado del jail.

#### Banear y desbanear manualmente

- sudo fail2ban-client set sshd banip 192.168.1.10
  Banear

- sudo fail2ban-client set sshd unbanip 192.168.1.10
  Desbanear

#### Ver logs en tiempo real

- sudo tail -f /var/log/fail2ban.log
- sudo journalctl -u fail2ban -f

#### Consultar configuraciones específicas

- sudo fail2ban-client get sshd maxretry
- sudo fail2ban-client get sshd bantime

#### Recargar configuración

- sudo fail2ban-client reload

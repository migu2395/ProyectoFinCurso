#Nginx Proxy Manager
- [Web](https://nginxproxymanager.com/)
- [Guia](https://nginxproxymanager.com/guide/)
- [Repositorio](https://github.com/NginxProxyManager/nginx-proxy-manager/)

Nginx Proxy Manager es un proxy basado en nginx que se ejecuta en un servidor docker. 
Permite configurar dominios y redirecciones fácilmente. 
Con Let’s Encrypt se puede conseguir un certificado SSL. 

##Instalación
1. [Instalar docker](https://docs.docker.com/install/)
2. Crear un archivo llamado docker-compose.yml como este:

```
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped

    ports:
      # These ports are in format <host-port>:<container-port>
      - '80:80' # Public HTTP Port
      - '443:443' # Public HTTPS Port
      - '81:81' # Admin Web Port
      # Add any other Stream port you want to expose
      # - '21:21' # FTP

    environment:
      TZ: "Europe/Madrid"

      # Uncomment this if you want to change the location of
      # the SQLite DB file within the container
      # DB_SQLITE_FILE: "/data/database.sqlite"

      # Uncomment this if IPv6 is not enabled on your host
      # DISABLE_IPV6: 'true'

    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```
3. Iniciar con:
```docker compose up -d```
4. Acceder a la interfaz de administración por
  [http://ip-del-servidor:81](http://192.168.1.3:81)

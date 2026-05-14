# Jellyfin

- [Web](https://jellyfin.org/)
- [Guía](https://jellyfin.org/docs/)
- [Repositorio](https://github.com/jellyfin/jellyfin)

Jellyfin es un servidor multimedia libre y de código abierto que permite gestionar y reproducir tu colección de películas, series, música y fotos desde cualquier dispositivo. Es una alternativa self-hosted a Plex o Emby, sin suscripciones ni telemetría.

## Instalación

1. [Instalar docker](https://docs.docker.com/install/)
2. Crear la estructura de directorios para la configuración:
   ```
   mkdir -p /srv/jellyfin/config /srv/jellyfin/cache
   ```
3. Crear un archivo llamado `jellyfin-compose.yaml` como este:

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    restart: unless-stopped
    environment:
      - TZ=Europe/Madrid
    volumes:
      - /srv/jellyfin/config:/config
      - /srv/jellyfin/cache:/cache
      - /mnt/WDBlue/Media:/media # Esta línea da acceso al almacenamiento externo a la aplicación
    ports:
      - "8096:8096"
```

4. Iniciar con:
   ```
   docker compose -f jellyfin-compose.yaml up -d
   ```
5. Acceder a la interfaz de administración en
   [http://ip-del-servidor:8096](http://192.168.1.3:8096)

   En el primer acceso se lanzará un asistente de configuración inicial donde se crean el usuario administrador y las bibliotecas multimedia.

## Actualizar

```
docker compose pull
docker compose up -d
```

## Guía de uso

Desde la interfaz web se accede a las principales secciones:

- **Bibliotecas**
  Son las carpetas de medios que Jellyfin indexa y muestra. Se crean durante la configuración inicial o desde *Panel de control > Bibliotecas*. Cada biblioteca tiene un tipo (Películas, Series, Música, Fotos...) y apunta a una o varias carpetas del servidor, en este caso dentro de `/media`.

- **Panel de control**
  Sección de administración desde donde se gestionan usuarios, bibliotecas, plugins, transcodificación y el estado general del servidor. También muestra las reproducciones activas en tiempo real.

- **Usuarios**
  Permite crear cuentas independientes con sus propias bibliotecas visibles, controles parentales y permisos. Útil para compartir el servidor con otras personas sin darles acceso de administrador.

- **Transcodificación**
  Si el dispositivo cliente no soporta el formato original del archivo, Jellyfin puede transcodificar el vídeo al enviarlo. Desde el panel de control se puede configurar la aceleración por hardware (Intel QSV, NVIDIA NVENC, etc.) para reducir el uso de CPU.

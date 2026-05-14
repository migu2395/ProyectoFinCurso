# Portainer

- [Web](https://www.portainer.io/)
- [Guía](https://docs.portainer.io/)
- [Repositorio](https://github.com/portainer/portainer)

Portainer es una interfaz web de gestión de contenedores Docker. Permite administrar imágenes, contenedores, volúmenes, redes y stacks de forma visual, sin necesidad de usar la línea de comandos. Existe en dos variantes: **Community Edition (CE)** gratuita y **Business Edition (BE)** de pago.

Se compone de dos piezas:
- **Server**: la interfaz web principal, instalada en el servidor desde el que se quiere gestionar todo.
- **Agent**: un servicio ligero instalado en cada servidor remoto que se quiera gestionar desde el Server.

## Instalación

### Server

1. [Instalar docker](https://docs.docker.com/install/)
2. Crear un archivo llamado `portainer-compose.yaml` como este:

```yaml
services:
  portainer:
    container_name: portainer
    image: portainer/portainer-ce:sts
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    ports:
      - 9443:9443
      # - 8000:8000  # Descomentar si se usan Edge Agents

volumes:
  portainer_data:
    name: portainer_data

networks:
  default:
    name: portainer_network
```

3. Iniciar con:
   ```
   docker compose -f portainer-compose.yaml up -d
   ```
4. Acceder a la interfaz en
   [https://ip-del-servidor:9443](https://192.168.1.3:9443)

   En el primer acceso se pedirá crear el usuario administrador. El puerto usa **HTTPS** con un certificado autofirmado, por lo que el navegador puede mostrar un aviso de seguridad la primera vez.

---

### Agent

El agent se instala en cada servidor remoto que se quiera gestionar desde el Server. No tiene interfaz propia.

1. Crear un archivo llamado `portainer-agent-compose.yaml` como este:

```yaml
services:
  agent:
    image: portainer/agent:latest
    container_name: portainer_agent
    restart: unless-stopped
    ports:
      - "9001:9001"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/docker/volumes:/var/lib/docker/volumes
```

2. Iniciar con:
   ```
   docker compose -f portainer-agent-compose.yaml up -d
   ```
3. Desde la interfaz del Server, ir a **Environments → Add environment → Agent** e introducir la IP del servidor remoto y el puerto `9001`.

## Actualizar

```
docker compose pull
docker compose up -d
```

Repetir en cada máquina donde haya un agent instalado.

## Guía de uso

Desde la interfaz web del Server se accede a las principales secciones:

- **Home / Environments**
  Muestra todos los entornos conectados (servidor local y agentes remotos). Desde aquí se selecciona el entorno que se quiere gestionar.

- **Stacks**
  Equivalente a los `docker compose`. Permite crear, editar y gestionar stacks directamente desde la interfaz web, subiendo un `compose.yaml` o escribiéndolo en el editor integrado.

- **Containers**
  Lista todos los contenedores del entorno seleccionado. Permite arrancarlos, pararlos, reiniciarlos, ver sus logs y acceder a una consola interactiva dentro del contenedor.

- **Images**
  Gestión de imágenes descargadas. Permite hacer pull de nuevas imágenes o eliminar las que ya no se usan.

- **Volumes / Networks**
  Gestión de volúmenes y redes de Docker. Útil para inspeccionar qué contenedores usan cada recurso o para eliminar los que han quedado huérfanos.

- **Settings**
  Configuración general del servidor: usuarios, equipos, autenticación (LDAP/OAuth), registros privados de imágenes y licencia en caso de usar la versión Business.

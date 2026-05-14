# Grafana

- [Web](https://grafana.com/)
- [Guía](https://grafana.com/docs/grafana/latest/)
- [Repositorio](https://github.com/grafana/grafana)

Grafana es una plataforma open source de visualización y monitorización que permite crear dashboards interactivos a partir de múltiples fuentes de datos como Prometheus, InfluxDB, MySQL, entre otras.

## Instalación

1. [Instalar docker](https://docs.docker.com/install/)
2. Crear una red externa de monitorización de esta forma no hay que poner todos los servicios en un único archivo compose:
   ```
   docker network create monitoring
   ```
3. Crear un archivo llamado `grafana-compose.yaml` como este:

```yaml
services:
  grafana:
    image: grafana/grafana-oss
    container_name: grafana
    restart: unless-stopped
    ports:
      - '3000:3000'
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin # Cambiar esto por una contraseña o un archivo .env
    volumes:
      - grafana_data:/var/lib/grafana
    networks:
      - monitoring

volumes:
  grafana_data:

networks:
  monitoring:
    external: true
```

4. Iniciar con:
   ```
   docker compose -f grafana-compose.yaml up -d
   ```
5. Acceder a la interfaz de administración en
   [http://ip-del-servidor:3000](http://192.168.1.3:3000)

   Las credenciales por defecto son `admin` / `admin`. Se pedirá cambiar la contraseña en el primer inicio de sesión.

## Actualizar

El proceso de actualización de los docker compose es siempre el mismo, solo hay que ejecutar estos tres comandos:

```
docker compose down
docker compose pull
docker compose up -d
```

## Guía de uso

Desde la interfaz web se accede a las principales secciones:

- **Dashboards**
  Aquí se crean y organizan los paneles de visualización. Cada dashboard puede contener múltiples paneles con gráficas, tablas, contadores, etc. Se pueden importar dashboards de la comunidad desde [grafana.com/dashboards](https://grafana.com/grafana/dashboards/) usando su ID.

- **Explore**
  Permite lanzar consultas directas contra las fuentes de datos de forma interactiva, sin necesidad de crear un dashboard. Útil para depurar métricas o logs en tiempo real.

- **Alerting**
  Desde esta sección se configuran reglas de alerta basadas en umbrales de las métricas. Las alertas pueden enviarse por email, Telegram, Slack u otros canales mediante los *Contact points*.

- **Connections (Data Sources)**
  Aquí se añaden las fuentes de datos. Una vez añadida una fuente (por ejemplo Prometheus en `http://prometheus:9090`), los dashboards pueden consultarla para obtener métricas.

- **Administration**
  Gestión de usuarios, equipos, permisos y configuración general de la instancia. También permite gestionar plugins instalados.

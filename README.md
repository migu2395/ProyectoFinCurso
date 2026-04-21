CIFP Juan de Colonia

Departamento de Informática y Comunicaciones

Ciclo Formativo de Grado Superior Administración de Sistemas Informáticos en Red.

Curso 2025/2026

Miguel Criado Briones

<img width="850" height="389" alt="image" src="https://github.com/user-attachments/assets/bb13d3b7-c40e-4583-bf4f-7dbde1f55346" />

# Diseño e implementación de una infraestructura de red segmentada con firewall, virtualización y servicios autoalojados mediante OPNsense y Proxmox

# 1. Introducción

## 1.1. Descripción del proyecto

El proyecto consiste en el diseño e implantación de una infraestructura de red doméstica basada en un router OPNsense y un servidor Proxmox, se busca la virtualización de los servicios, la segmentación de red, y la mejora de la seguridad.
El elemento central de la red es un router basado en OPNsense, se encargará de la gestión del tráfico, la segmentación en VLANs (redes separadas dentro de la misma infraestructura), de esta forma se pueden separar distintos tipos de dispositivos como equipos personales o de invitados IoT, o los servidores.
Además, incluye un servidor DNS UnboundDNS y un sistema de monitorización de intrusos mediante suricata para monitorizar y analizar el tráfico de la red en tiempo real y eliminar posibles amenazas.
Por el otro lado, se cuenta con un portátil que proporcionará varios servicios como un proxy inverso, y monitorización de contenedores docker. Este servidor usará Proxmox para crear máquinas virtuales y contenedores de Linux (LXC).
La infraestructura se basará en IPv4 debido a la compatibilidad con la mayoría de los dispositivos y aplicaciones actuales. Sin embargo, se implantará un entorno dual-stack (IPv4-IPv6), aprovechando las ventajas de IPv6 en número de direcciones y eficiencia en enrutamiento.

## 1.2. Objetivos del proyecto

El objetivo principal del proyecto es diseñar e implementar una infraestructura virtualizada que sea eficiente, segura y escalable para centralizar varios servicios y dar una gestión fácil de ellos.

Para ello se configurará un router basado en OPNsense encargado de segmentar la red en VLANs con el fin de aislar diferentes entornos y controlar el tráfico entre ellos. Además, este router sustituirá en gran parte al del proveedor de internet, proporcionando varios servicios de red propios. Los servicios de red que se implementarán son los siguientes:

- Servidor DHCP: Asignación automática de direcciones IP a los equipos sin IP estática.
- Servidor DNS (UnboundDNS): Hará resolución de nombres tanto internos como externos.
- Segmentación por VLANs: Separa la red en diferentes zonas para aislar ciertos dispositivos y mejorar la seguridad.
- Sistema IDS (Suricata): Detección de posibles intrusos y comportamientos sospechosos en la red.
- Bloqueador de publicidad: Se realiza un filtrado de contenido no deseado a nivel de red mediante el servidor DNS.
- Acceso remoto seguro: Conexión desde el exterior de la red mediante Tailscale.

Los servicios se desplegarán sobre un servidor basado en Proxmox, utilizando máquinas virtuales (VM) y contenedores de Linux (LXC) para optimizar recursos y mejorar la flexibilidad del sistema. Como mejora futura se implantará un mecanismo de alta disponibilidad mediante un segundo nodo, y un sistema de backup con Proxmox backup server. Los servicios del servidor son los siguientes:

- Proxy inverso: Mediante Nginx Proxy Manager se podrá acceder a los distintos servicios mediante nombres de dominio interno.
- Monitorización: Supervisión del estado del hardware y de los servicios mediante herramientas como Portainer, Prometheus y Grafana.
- Automatización de tareas: Se ejecutarán tareas de actualización y mantenimiento mediante cron.
  El acceso remoto al sistema se podrá realizar mediante tailscale debido a que no existe la posibilidad de usar WireGuard, al no disponer de ip estática.
  Todo el sistema se ha diseñado teniendo en cuenta su crecimiento, asegurando escalabilidad a nivel de red y de servicios según las necesidades.

## 1.3. Identificar los aspectos que se deben controlar para garantizar la calidad el proyecto.

Para garantizar la calidad del proyecto, es necesario asegurarse de controlar los siguientes aspectos:

- Seguridad de la red
  El firewall debe tener una configuración de seguridad correcta siguiendo el principio de mínimo privilegio, también debe segmentar la red por VLANs y detectar intrusos mediante IDS.
- Rendimiento
  Se debe hacer un uso eficiente de los recursos del sistema y optimizar todo cuanto sea posible sin perder características, velocidad o calidad.
- Disponibilidad
  Aunque el servidor no estará encendido 24/7, hay que minimizar el tiempo de inactividad, y planificar soluciones de respaldo.
- Escalabilidad
  Este sistema es muy limitado, y en el futuro se implantarán nuevos servicios, hay que garantizar que sea posible escalar el sistema.
- Mantenibilidad
  Tiene que ser fácil actualizar y reparar el sistema, además de poder realizar copias de seguridad y mantener el sistema.
- Monitorización
  El sistema estará monitorizado 24/7 para detectar fallos o comportamientos anómalos.
- Documentación
  Se ha realizado un registro detallado de la configuración, arquitectura, y procedimientos para facilitar la gestión, recuperación y ampliación del sistema.

# 2. Análisis y contextualización de empresa/s del sector

## 2.1. Caracterización de empresa/s del sector

## 2.2. Análisis de la empresa seleccionada

# 3. Recursos

## 3.1. Recursos de hardware

### Recursos de hardware necesarios en cso de implantación en empresa

## 3.2. Recursos de software

### Recursos de software necesarios en cso de implantación en empresa

# 4 Planificación

## 4.1. Planificación temporal

## 4.2. Planificación económica

|     Producto                             |     Precio        |   |
|------------------------------------------|-------------------|---|
|     Trabajo                              |     10€/hora      |   |
|     Router                               |     285 €         |   |
|     Switch                               |     32,99€        |   |
|     Raspberri Pi 4b 2Gb                  |     85,90 €       |   |
|     Portátil gigabyte                    |     2000 €        |   |
|     Portátil HP                          |     700 €         |   |
|     2 discos duro externo                |     50 € / Ud.    |   |
|     Cable Cat6e                          |     5,78€         |   |
|     Enchufe inteligente                  |     10,99 €       |   |
|     Electricidad de Marzo (3.600 kWh)    |     0.42 €        |   |
|     Electricidad de Abril (3.492 kWh)    |     0.41 €        |   |
|     Total                                |                   |   |

# 5. Desarrollo y pruebas.

## 5.1. Esquemas: topología de red

<img width="1216" height="796" alt="image" src="https://github.com/user-attachments/assets/4b76c309-7f76-4c29-b935-33528c4fff79" />

</br>

```
Internet
|
|
|─ Router ISP - 192.168.1.1/24
|    |─ WiFi ISP
|    |─ NAT / Port forwarding interno
|        |
|        |─ OPNsense WAN - 192.168.1.2/24
|
|
|─ Router OPNsense
    |─ WAN - 192.168.1.2/24
    |─ LAN - 192.168.99.1/24
    |─ Trunk hacia switch gestionable (VLANs)
    |
    |─ VLAN 10 - Usuarios - 192.168.10.254/24
    |─ VLAN 15 - Invitados - 192.168.15.254/24
    |─ VLAN 20 - Servidores - 192.168.20.254/24
    |─ VLAN 25 - Tailscale - 192.168.25.254/24
    |─ VLAN 30 - IoT - 192.168.30.254/24
    |─ VLAN 99 - Administración - 192.168.99.254/24
        |
        |
        └── Switch gestionable (trunk VLAN)
                |
                |─ VLAN 20 - SERVIDORES
                |      |─ Proxmox Node 1 - 192.168.20.10/24
                |           |─ LXC 101 - Proxy - 192.168.20.101/24
                |           |      |─ Nginx Proxy Manager
                |           |
                |           |─ LXC 102 – Administración/Monitorización - 192.168.20.102/24
                |           |      |─ Portainer
                |           |      |─ Prometheus
                |           |              |─ Node Exporter
                |           |              |─ cAdvisor
                |           |              |─ Alertmanager
                |           |
                |           |─ LXC 103 - Media - 192.168.20.103/24
                |                  |─ Jellyfin
                |
                |─ VLAN 99 - ADMINISTRACIÓN
                       |─ OPNsense - 192.168.99.1
                       |─ Switch gestionable - 192.168.99.2
```

## 5.2. Descripción del desarrollo por apartados de las distintas fases del proyecto, incluyendo la documentación técnica y explicación del desarrollo del proyecto

https://github.com/migu2395/ProyectoFinCurso/blob/main/guias/README.md

## 5.3. Realización y descripción de las pruebas realizadas para verificar y/o mejorar el correcto funcionamiento del sistema

# 6. Conclusiones

## 6.1. Problemas encontrados y solución aplicada.

## 6.2. Grado de cumplimiento de los objetivos fijados: se indicará el grado de cumplimiento, objetivo por objetivo

## 6.3. Propuestas de mejora o ampliaciones futuras

La primera mejora sería cambiar el almacenamiento a un NAS, aunque sea un solo disco, es mejor que esté conectado por red que por USB, luego instalaría un punto de acceso de Ubiquiti o TP-Link para mejorar la velocidad WIFI, también habría que cambiar todos los cables a cat6a para poder llegar a 10Gb/s.
Para que esta mejora sea efectiva, en vez del portátil, habría que usar 4 Lenovo thinkcentre o similares, son miniordenadores potentes, ampliables y de bajo consumo, 2 funcionarían permanentemente, 1 estaría en stand-by, y el otro apagado como backup de emergencia, este es un sistema mejor y más fiable que un portátil viejo.
En cuanto a seguridad, hay que mejorar las reglas de acceso de la WAN a la LAN, hay que hacerlas más restrictivas.
La última mejora será pasarlo todo de la estantería a un rack de servidor y hacer cables a medida para mejorar la organización

## 7. Referencias

### Introducción

* iFixit. (s.f.). *Guía LTT para construir tu propio router*. Recuperado de:
  [https://es.ifixit.com/Gu%C3%ADa/Gu%C3%ADa+LTT+para+construir+tu+propio+Router/155106](https://es.ifixit.com/Gu%C3%ADa/Gu%C3%ADa+LTT+para+construir+tu+propio+Router/155106)

---

### Análisis y contextualización del sector

* Computing España. (s.f.). *150 empresas líderes del sector TIC español*. Recuperado de:
  [https://www.computing.es/mercado-ti/150-empresas-lideres-del-sector-tic-espanol/](https://www.computing.es/mercado-ti/150-empresas-lideres-del-sector-tic-espanol/)

* Proxmox Server Solutions GmbH. (s.f.). *Proxmox Virtual Environment Pricing*. Recuperado de:
  [https://www.proxmox.com/en/products/proxmox-virtual-environment/pricing](https://www.proxmox.com/en/products/proxmox-virtual-environment/pricing)

---

### Recursos técnicos

* ElHacker.NET. (2024). *IDS/IPS en OPNsense con Suricata*. Recuperado de:
  [https://blog.elhacker.net/2024/12/idsips-en-opnsense-con-suricata.html](https://blog.elhacker.net/2024/12/idsips-en-opnsense-con-suricata.html)

* MacRimi. (s.f.). *ProxMenux* [Repositorio de GitHub]. Recuperado de:
  [https://github.com/MacRimi/ProxMenux](https://github.com/MacRimi/ProxMenux)

* Prometheus Authors. (s.f.). *Prometheus* [Software y documentación]. Recuperado de:
  [https://prometheus.io/](https://prometheus.io/)
  [https://github.com/prometheus/prometheus](https://github.com/prometheus/prometheus)

* Prometheus Authors. (s.f.). *Node Exporter* [Repositorio de GitHub]. Recuperado de:
  [https://github.com/prometheus/node_exporter](https://github.com/prometheus/node_exporter)

* Google. (s.f.). *cAdvisor* [Repositorio de GitHub]. Recuperado de:
  [https://github.com/google/cadvisor](https://github.com/google/cadvisor)

* Grafana Labs. (s.f.). *Grafana OSS* [Software y repositorio]. Recuperado de:
  [https://grafana.com/oss/](https://grafana.com/oss/)
  [https://github.com/grafana/grafana](https://github.com/grafana/grafana)

* Jellyfin Team. (s.f.). *Jellyfin* [Software y repositorio]. Recuperado de:
  [https://jellyfin.org/](https://jellyfin.org/)
  [https://github.com/jellyfin/jellyfin](https://github.com/jellyfin/jellyfin)

* Immich Contributors. (s.f.). *Immich Docker Compose Installation*. Recuperado de:
  [https://docs.immich.app/install/docker-compose/](https://docs.immich.app/install/docker-compose/)

* OPNsense Project. (s.f.). *Unbound DNS*. Recuperado de:
  [https://docs.opnsense.org/manual/unbound.html](https://docs.opnsense.org/manual/unbound.html)

* Docker Inc. (s.f.). *Docker Documentation*. Recuperado de:
  [https://docs.docker.com](https://docs.docker.com)

* Portainer. (s.f.). *Portainer* [Repositorio de GitHub]. Recuperado de:
  [https://github.com/portainer/portainer](https://github.com/portainer/portainer)

* Portainer. (s.f.). *Portainer Editions*. Recuperado de:
  [https://www.portainer.io/features](https://www.portainer.io/features)

* Pouzor. (s.f.). *Homelable* [Repositorio de GitHub]. Recuperado de:
  [https://github.com/Pouzor/homelable](https://github.com/Pouzor/homelable)

* Termix-SSH. (s.f.). *Termix* [Repositorio de GitHub]. Recuperado de:
  [https://github.com/Termix-SSH/Termix](https://github.com/Termix-SSH/Termix)

---

## 8. Anexo

* Criado, M. (s.f.). *Proyecto Fin de Curso* [Repositorio de GitHub]. Recuperado de:
  [https://github.com/migu2395/ProyectoFinCurso](https://github.com/migu2395/ProyectoFinCurso)

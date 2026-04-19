CIFP Juan de Colonia

Departamento de Informática y Comunicaciones

Ciclo Formativo de Grado Superior Administración de Sistemas Informáticos en Red.

Curso 2025/2026

Miguel Criado Briones

<img width="850" height="389" alt="image" src="https://github.com/user-attachments/assets/bb13d3b7-c40e-4583-bf4f-7dbde1f55346" />

# <p style="text-align: center;">Diseño e implementación de una infraestructura de red segmentada con firewall, virtualización y servicios autoalojados mediante OPNsense y Proxmox</p>

# 1. Introducción

## 1.1 Descripción del proyecto

El proyecto consiste en el diseño e implantación de una infraestructura de red doméstica basada en un router OPNsense y un servidor Proxmox, se busca la virtualización de los servicios, la segmentación de red, y la mejora de la seguridad.
El elemento central de la red es un router basado en OPNsense, se encargará de la gestión del tráfico, la segmentación en VLANs (redes separadas dentro de la misma infraestructura), de esta forma se pueden separar distintos tipos de dispositivos como equipos personales o de invitados IoT, o los servidores.
Además, incluye un servidor DNS UnboundDNS y un sistema de monitorización de intrusos mediante suricata para monitorizar y analizar el tráfico de la red en tiempo real y eliminar posibles amenazas.
Por el otro lado, se cuenta con un portátil que proporcionará varios servicios como un proxy inverso, y monitorización de contenedores docker. Este servidor usará Proxmox para crear máquinas virtuales y contenedores de Linux (LXC).
La infraestructura se basará en IPv4 debido a la compatibilidad con la mayoría de los dispositivos y aplicaciones actuales. Sin embargo, se implantará un entorno dual-stack (IPv4-IPv6), aprovechando las ventajas de IPv6 en número de direcciones y eficiencia en enrutamiento.

## 1.2 Objetivos del proyecto

El objetivo principal del proyecto es diseñar e implementar una infraestructura virtualizada que sea eficiente, segura y escalable para centralizar varios servicios y dar una gestión fácil de ellos.
Para ello se configurará un router OPNsense para segmentar la red en VLANs con el fin de aislar las redes una de otra. Este router también hará de servidor DNS y DHCP, sustituyendo todo lo posible al router del proveedor de internet.
El servidor DNS permitirá la gestión de dominios locales y la integración con un proxy inverso facilitando el acceso a los distintos servicios internos y se implantará un bloqueador de publicidad.
Los servicios se desplegarán sobre un servidor basado en Proxmox, para desplegar varias máquinas virtuales (VM) y contenedores de Linux (LXC) para optimizar recursos y mejorar la flexibilidad den sistema. Como mejora futura se implantará un mecanismo de alta disponibilidad con un segundo nodo, y un sistema de backup con Proxmox backup server.
Se automatizarán tareas de mantenimiento mediante el uso de cron, actualizando y optimizando los sistemas sin intervención manual.
El acceso remoto al sistema se podrá realizar mediante tailscale debido a que no existe la posibilidad de usar WireGuard, al no disponer de ip estática.
Todo el sistema se ha diseñado teniendo en cuenta su crecimiento, asegurando escalabilidad a nivel de red y de servicios según las necesidades.

## 1.3 Identificar los aspectos que se deben controlar para garantizar la calidad el proyecto.

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

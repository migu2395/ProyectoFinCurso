# ProyectoFinCurso

## 1. Introducción

### 1.1. Descripción del proyecto

### 1.2. Objetivos del proyecto

El objetivo del proyecto es diseñar e implementar una infraestructura virtualizada, eficiente, segura y escalable para centralizar varios servicios y aplicaciones.
Se implementará un router OPNsense para segmentar la red en VLANs y así aislar las redes una de otra. Se usare este router como servidor DNS y DHCP, sustituyendo en la medida de lo posible al router del proveedor de internet.
El servidor DNS permitirá la resolución local de los servicios junto a Nginx Proxy Manager, además incluirá un bloqueador de anuncios.
Los servicios se implantarán en un servidor basado en proxmox, para desplegar varias máquinas virtuales (VM) y contenedores de linux (LXC). Además, en el futuro aplicar alta disponibilidad con un servidor de backups de proxmox.
Este servidor tendrá tareas programadas con cron para actualizar y optimizar el sistema sin hacerlo manualmente.
Se debe poder acceder remotamente, ya sea por tailscale o por VPN.
Es sistema estará diseñado teniendo en cuenta que se escalará en el futuro.

### 1.3. Identificar los aspectos que se deben controlar para garantizar la calidad el proyecto

## 2. Análisis y contextualización de empresa/s del s ector.

### 2.1. Caracterización de empresa/s del sector.

### 2.2. Análisis de la empresa seleccionada.

## 3. Recursos

### 3.1. Recursos de hardware

#### Recursos de hardware utilizados

#### Recursos de hardware necesarios en caso de implantación en una empresa

### 3.2. Recursos de software

#### Recursos de software utilizados

- Pi-Hole/AdguardHome
- Tailscale
- Proxmox
- Proxmenu
- Nginx Proxy Manager
- Prometheus
- Prometheus Node Exporter
- Grafana
- Heimdall
- Jellyfin
- Home Assistant
- Navidrome
- Immich

#### Recursos de software necesarios en caso de implantación en una empresa

## 4. Planificación
### 4.1. Planificación temporal
### 4.2. Planificación económica

## 5. Desarrollo y pruebas
### 5.1 Esquema
### 5.2 Descripción del desarrollo
### 5.3 Realización y 

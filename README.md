# Proyecto Fin de Curso – Infraestructura de Red Virtualizada

Este repositorio contiene la documentación técnica y configuración de una infraestructura de red virtualizada basada en Proxmox VE y OPNsense.

## 🔧 Tecnologías utilizadas
- Proxmox VE
- OPNsense
- Docker / Docker Compose
- Nextcloud
- Mailcow
- Bitwarden
- Prometheus + Grafana
- Suricata
- Tailscale

## 🏗️ Arquitectura general
- Router/firewall: OPNsense
- Virtualización: Proxmox VE
- Segmentación: VLANs IEEE 802.1Q
- Monitorización: Prometheus + Grafana
- Seguridad: IDS Suricata + firewall segmentado

## 📚 Documentación
Toda la documentación se encuentra en `/docs`.

## 📦 Infraestructura
Configuraciones y despliegues en `/infra`.

## 🔐 Seguridad
- VLANs segmentadas
- IDS/IPS (Suricata)
- VPN (Tailscale / WireGuard)
- DNS filtrado (Unbound)

## 📊 Monitorización
- Prometheus
- Node Exporter
- cAdvisor
- Grafana dashboards

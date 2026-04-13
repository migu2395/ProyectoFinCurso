#Proxmox
- [Web](https://www.proxmox.com/)

<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/808dce76-a030-4d8f-95bd-4002c8ec31bd" />

Proxmox VE es una plataforma de visualización bare-metal y open-source con una interfaz web, integra el hypervisor KVM, contenedores de linux (LXC), gestión de almacenamiento por software mediante Ceph y Software-Defined Networking, que separa la red física y permite crear zonas, redes virtuales y permite integración con puentes de linux y Open vSwitch.

Tiene una versión de suscripción que incluye soporte técnico y acceso a repositorios empresariales, estos repositorios son más estables, y todo el software está comprobado, este modelo de suscripción está pensado para empresas, entornos críticos e infraestructuras importantes, en este caso no es necesario, pero en cualquier caso donde se use proxmox en una empresa es muy recomendado, ya que garantiza más estabilidad.
La versión gratuita de proxmox no pierde funcionalidades, pero no tiene acceso al soporte ni al repositorio empresarial.

La razón para elegir Proxmox sobre otras soluciones como VMware ESXi, Hyper-V y openSUSE Virtualization es la facilidad de uso gracias a la interfaz web.

| Característica              | Proxmox VE                          | VMware ESXi                         | Hyper-V                              | openSUSE Virtualization              |
|----------------------------|-------------------------------------|-------------------------------------|--------------------------------------|--------------------------------------|
| Tipo                       | Hipervisor tipo 1 (KVM + LXC)       | Hipervisor tipo 1                   | Hipervisor tipo 1                    | KVM (tipo 1 sobre Linux)             |
| Licencia                   | Open Source (AGPL) + soporte pago   | Propietario (licencia de pago)      | Incluido en Windows Server           | Open Source                          |
| Coste                      | Gratuito (sin soporte)              | Alto                                | Medio (licencia Windows)             | Gratuito                             |
| Facilidad de uso           | Alta (web UI integrada)             | Alta (muy pulido)                   | Media (requiere Windows)             | Media-baja (más manual)              |
| Interfaz web               | Sí (nativa)                         | Sí (vSphere)                        | Parcial (Windows Admin Center)       | No nativa (Cockpit opcional)         |
| Gestión centralizada       | Sí (cluster integrado)              | Sí (vCenter requerido)              | Sí (System Center opcional)          | Limitada (libvirt + herramientas)    |
| Soporte de contenedores    | Sí (LXC nativo)                     | No                                  | No (usa Docker externo)              | Sí (LXC/Docker)                      |
| Alta disponibilidad (HA)   | Sí (incluido)                       | Sí (muy avanzado)                   | Sí                                   | Sí (configuración manual)            |
| Live Migration             | Sí                                  | Sí                                  | Sí                                   | Sí                                   |
| Backup integrado           | Sí (Proxmox Backup Server)          | No (requiere herramientas externas) | Limitado                             | No nativo                            |
| Soporte ZFS                | Sí (nativo)                         | No                                  | No                                   | Sí                                   |
| Almacenamiento definido SW | Sí                                  | Sí                                  | Sí                                   | Sí                                   |
| Red virtual avanzada       | Sí (Linux Bridge, Open vSwitch)     | Sí (muy avanzado)                   | Sí                                   | Sí                                   |
| Requisitos hardware        | Moderados                           | Altos                               | Altos                                | Moderados                            |
| Comunidad                  | Grande y activa                     | Profesional (enterprise)            | Profesional                          | Comunidad Linux                      |
| Soporte empresarial        | Opcional (suscripción)              | Sí (muy completo)                   | Sí                                   | Limitado                             |
| Mejor caso de uso          | Homelab, PyME, autoalojado          | Grandes empresas                    | Entornos Microsoft                   | Usuarios avanzados Linux             |

# Instalación

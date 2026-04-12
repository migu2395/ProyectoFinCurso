CIFP Juan de Colonia  Departamento de Informática y Comunicaciones

Ciclo Formativo de Grado Superior Administración de Sistemas Informáticos en Red.

Curso 2025/2026

Miguel Criado Briones

Diseño e implementación de una infraestructura de red segmentada con firewall, virtualización y servicios autoalojados mediante OPNsense y Proxmox

[1\. Introducción 1](#_Toc1)

[1.1. Descripción del proyecto 1](#_Toc2)

[1.2. Objetivos del proyecto 2](#_Toc3)

[1.3 Identificar los aspectos que se deben controlar para garantizar la calidad el proyecto. 3](#_Toc4)

[2\. Análisis y contextualización de empresa/s del sector. 4](#_Toc5)

[2.1. Caracterización de empresa/s del sector. 4](#_Toc6)

[2.2. Análisis de la empresa seleccionada. 5](#_Toc7)

[3\. Recursos. 10](#_Toc8)

[3.1. Recursos hardware. 10](#_Toc9)

[Recursos de hardware necesarios en caso de implantación en empresa 19](#_Toc10)

[3.2. Recursos software. 24](#_Toc11)

[Router 24](#_Toc12)

[Servidor proxmox 26](#_Toc13)

[Servidor DNS 27](#_Toc14)

[Portátil con servicios docker 28](#_Toc15)

[Recursos de software necesarios en caso de implantación en empresa 29](#_Toc16)

[4\. Planificación 30](#_Toc17)

[4.1. Planificación temporal (fases en que se divide y sus fechas). 30](#_Toc18)

[4.2. Planificación económica (presupuesto económico para desarrollar el proyecto). 31](#_Toc19)

[5\. Desarrollo y pruebas. 32](#_Toc20)

[5.1. Esquemas: topología de red (incluyendo direcciones IP, máscaras, etc.), diagrama de montaje… 32](#_Toc21)

[5.2. Descripción del desarrollo por apartados de las distintas fases del proyecto, incluyendo la documentación técnica y explicación del desarrollo del proyecto. 33](#_Toc22)

[5.3. Realización y descripción de las pruebas realizadas para verificar y/o mejorar el correcto funcionamiento del sistema. 33](#_Toc23)

[6\. Conclusiones finales 34](#_Toc24)

[6.1. Problemas encontrados y solución aplicada. 34](#_Toc25)

[6.2. Grado de cumplimiento de los objetivos fijados: se indicará el grado de cumplimiento, objetivo por objetivo. 34](#_Toc26)

[7\. Referencias 35](#_Toc27)

[8\. ANEXOS (opcional). 36](#_Toc28)

# 1\. Introducción

## 1.1. Descripción del proyecto

El proyecto consta de la construcción de una red que consta de un router y un servidor.

El router divide la red por VLANs, funciona como servidor DNS y firewall

El servidor proporciona varios servicios ...

En el sistema se usará ipv4 debido a

## 1.2. Objetivos del proyecto

El objetivo del proyecto es diseñar e implementar una infraestructura virtualizada, eficiente, segura y escalable para centralizar varios servicios y aplicaciones.

Se implementará un router OPNsense para segmentar la red en VLANs y así aislar las redes una de otra. Se usare este router como servidor DNS y DHCP, sustituyendo en la medida de lo posible al router del proveedor de internet.

El servidor DNS permitirá la resolución local de los servicios junto a Nginx Proxy Manager, además incluirá un bloqueador de anuncios.

Los servicios se implantarán en un servidor basado en proxmox, para desplegar varias máquinas virtuales (VM) y contenedores de linux (LXC). Además, en el futuro aplicar alta disponibilidad con un servidor de backups de proxmox.

Este servidor tendrá tareas programadas con cron para actualizar y optimizar el sistema sin hacerlo manualmente.

Se debe poder acceder remotamente, ya sea por tailscale o por VPN.

Es sistema estará diseñado teniendo en cuenta que se escalará en el futuro.

## 1.3 Identificar los aspectos que se deben controlar para garantizar la calidad el proyecto.

# 2\. Análisis y contextualización de empresa/s del sector.

## 2.1. Caracterización de empresa/s del sector.

En el sector de la informática en España destacan grandes empresas como Telefónica, el grupo Orange, e Indra Sistemas, además de otras compañías extranjeras como Microsoft, Samsung Electronics, Hp y muchas más.

Estas empresas tienen un gran número de empleados en varias sedes por todo el país con infraestructuras híbridas y privadas, dependen de sistemas de comunicación interna, usan plataformas de trabajo colaborativo y sistemas de almacenamiento centralizado, y necesitan medidas de ciberseguridad avanzadas.

Las empresas suelen ser grandes corporaciones multinacionales que se dedican al sector tecnológico, telecomunicaciones, y servicios digitales, por lo general tienen entre 200 empleados en sedes, hasta miles de empleados en grandes corporaciones.

Para este proyecto planteo la sede central de una empresa ficticia con 200-250 empleados.

## 2.2. Análisis de la empresa seleccionada.

Planteo una empresa similar a “Telefónica” o “Indra Systems”, son grandes empresas del sector tecnológico en España, se trata de una empresa tecnológica de desarrollo de soluciones de IT y servicios digitales con 200-250 empleados, el sistema está diseñado para la oficina principal, que se conectara con otras oficinas secundarias por una VPN de sitio a sitio.

Esta empresa maneja datos importantes sobre sus clientes y necesitan alta disponibilidad, la empresa tendrá la infraestructura completa on-site con un sistema de ofimática con Nextcloud, y su propio correo corporativo.

Se trata de una arquitectura virtualizada basada en un clúster de proxmox con almacenamiento mediante NAS, consiste de:

- 2 servidores Proxmox donde se encuentran los servicios
- NAS con RAID 6 para garantizar la seguridad de los datos.
- Proxmox backup server.

Estará separado por departamentos cada uno en una VLAN, el objetivo es aumentar la seguridad, reducir el broadcast aumentando el rendimiento, y tener más control sobre la red, aplicando reglas de seguridad por departamento.

- Infraestructura
    - Proxmox

Para garantizar la alta disponibilidad usará un sistema proxmox ve con un proxmox backup server para que en caso de que se caiga el primer nodo, se pueda continuar sin problemas, este backup no necesita ser exactamente igual que el nodo principal.

Habrá dos nodos el en clúster siguiendo la siguiente estructura:

Nodo Proxmox 1

Nodo Proxmox 2

NAS

Proxmox Backup Server

- - NAS RAID 6

El sistema RAID se usará para garantizar alta disponibilidad cuando halla fallos de discos, pero como esto no significa que se puedan recuperar todos los datos en caso de borrado, corrupción o ramsonware, se aplicará un sistema de backups 321, se hará un backup completo el domingo a las 4:00 AM, y un backup diferencial todos los días también a la 4:00 AM. La copia de seguridad en la nube se hará en un servicio de almacenamiento europeo con garantías y certificados de seguridad.

- - Proxmox Backup Server

- Red
    - VLANs
    - Routing

Se implementa un firewall basado en OPNsense encargado de la segmentación de la red mediante VLANs, el control de acceso entre segmentos, la filtración del tráfico entrante y saliente, y en general aumentar la seguridad, por ejemplo, el departamento de IT tendrá acceso a todo, y el departamento de administración solo tendrá acceso a sus recursos.

Habrá dos firewalls, uno en stand-by, para no perder servicios en caso de cualquier problema.

Esta segmentación por VLANs mejora la seguridad y el control de la red evitando accesos no autorizados entre departamentos.

La implementación de un firewall centralizado con OPNsense permite crear políticas de seguridad específicas, controlar el acceso a recursos y proteger la red frente a amenazas externas.

- - VPN

Las oficinas estarán interconectadas por una VPN de sitio a sitio, de esta forma las oficinas secundarias accederán a los servicios de Nextcloud, el servidor de correo y a los recursos sin necesidad de exponer servicios a internet, como si estuvieran en la misma red local. Habrá un router OPNsense en cada sede, que se conectará con la sede principal por WireGuard o IPsec.

Para garantizar disponibilidad y maximizar velocidad en la red habrá dos VPNs, la primera, site to site con dos túneles, y una VPN de acceso remoto, y se priorizará el tráfico importante, como correos internos.

- Seguridad
    - Firewall
    - IDS

Se implementa un sistema de monitorización de red usando port mirroring hacia un sistema de análisis como Wireshark, que permite inspeccionar detalladamente los paquetes, su uso se limita a tareas de diagnóstico puntual.

Para monitorización continua, se usará Suricata en OPNsense, permitiendo detectar amenazas y anomalías en tiempo real.

- - Autenticación

Se implementará un control de acceso por LDAP o por Active Directory, con un sistema de usuarios centralizados.

El sistema de correo tendrá un sistema antispam y antivirus incluido, además de que estará cifrado por TLS.

A la nube de Nexcloud se accederá por HTTPS, tendrá autenticación por LDAP, y generará logs de actividad.

- Servicios
    - Nextcloud
    - Correo
    - Active directory

Para los equipos de los usuarios he elegido un entorno de Windows con Active Directory, ya que es el estándar en las empresas y al ser muchos usuarios facilita la administración de estos, hay control total sobre usuarios, contraseñas, permisos, etc, además de que es compatible con la mayoría de software.

# 3\. Recursos.

## 3.1. Recursos hardware.

Router N5105

Es un ordenador pensado en usarse como router, tiene un Intel Celeron N5105, es un chip de bajo consumo, pero con suficiente potencia para ser un router, tiene 8 Gb de RAM, 256 Gb de almacenamiento y 4 tarjetas de red Intel i226-V.

Este equipo tendrá 2 IPs, con la primera se conecta al router del proveedor de internet por el puerto 1, 192.168.1.2, y con la segunda se conecta al switch de donde se conecta a la red interna, 192.168.0.1, de esta forma se evitan conflictos de IP con el otro router.

Switch TL-SG608E

Es un switch gestionable de la marca TP-Link, está pensado para redes pequeñas, tiene 8 puertos de hasta 1000Mbps. Tiene IP 192.168.99.100 y se encuentra en la VLAN de administración.

A este switch se conectarán los siguientes equipos:

- Puerto 0: Router OPNsense
- Puerto 1: Servidor DNS
- Puerto 2: Nodo Proxmox
- Puerto 3: Servidor Docker

RaspberryPi 4b 2gb

Esta raspberry ahora se usa como servidor DNS, pero como se usará el DNS de OPNsense, en el futuro se usará como un NAS 1 con una extensión HAT.

Portátil Hp ProBook

Es un portátil viejo que tenía por casa, tiene un Intel Core I5 de 7º generación, 8 Gb de RAM, y una Nvidia MX930, tiene instalado Proxmox VE en un disco dure externo, y tiene otro disco duro donde se almacena media.

Ordenador de oficia viejo

Este ordenador con un Intel Core i5 de 7º generación y 4 Gb de RAM DDR3 se usará como un servidor para servicios de docker que usare ocasionalmente como homelable o termix. Tendrá Debian/ubuntuServer/OpenSuse.

Portátil Gigabyte Aorus 17Xe-4

Este es el portátil desde donde hago todo, se conecta por wifi

2 discos duro externos

- Disco reutilizado

Es un disco duro que saqué de un portátil roto, y le puse una carcasa, ahora aquí se ejecuta proxmox.

- WDblue

En este disco se almacena media, en el futuro se cambiará por un NAS

Enchufe inteligente

Este enchufe inteligente se encuentra en la VLAN de IoT, se conecta a HomeAssistant, y con el cálculo el consumo total del servidor.

Cables cat6 y cat6e

Compré un cable cat6e para conectar el un router con otro, el resto de está conectado por cables cat6 o 5e que tenía en casa.

## Recursos de hardware necesarios en caso de implantación en empresa

En caso de que se implante esta estructura en una empresa, habría que cambiar todo el hardware, ya que el que se ha usado no tiene suficientes recursos.

Lo primero que habría que hacer es cambiar el portátil por un servidor dedicado, por ejemplo, un Dell Poweredge R740, es un servidor que, para una oficina sería suficiente, si se tratase de una empresa entera, la instalación requeriría de varios servidores de uso corriente, además de otros en modo stand-by y apagados como backup.

Este servidor puede almacenar hasta 16 discos de 2.5” o 8 de 3.5”, por lo que se puede usar como NAS a la vez que es el servidor.

NAS

Opción NAS 1:

Aunque si se necesita un NAS dedicado, la mejor opción es uno de synology, hay muchas opciones para elegir, por ejemplo, en este caso, que la empresa quiere tener su propio sistema de ofimática con nuve privada, cuentas de correo y a la vez hacer un backup de estos datos, la mejor opción es un Synology HD6500.

Este NAS tiene 60 bahías para discos, pero se puede extender hasta 300, en cuanto a hardware, tiene 2 Intel Xeon Silver de 10 núcleos, viene con 64 GB de memoria RAM DDR4, pero se puede ampliar hasta 512GB. También viene con dos tarjetas de red de 10GbE, pero se pueden cambiar por otras SFP de 26GbE.

Es ideal para este caso, ya que se busca tener una nube privada, un servidor de correo y hacer backups al mismo tiempo, este NAS nunca se quedará corto.

Opción NAS 2:

Si se tratase de una empresa con menos empleados, o donde no se requiera tanto almacenamiento, la opción más clara es el DiskStation DS2422+.

Viene con un AMD ryzen de 4 núcleos, y hasta 24 bahías de discos, es una opción más pequeña, pero si a la otra opción no se le diese el uso debido, sería una pérdida de dinero, este NAS, aunque se puede quedar corto si la empresa aumentase el número de empleados, funcionara sin problemas.

Discos duros

Los discos duros que se usarán en el NAS serán WD RED pro de 20TB, están pensados para cargas de trabaja altas, y muchas horas de uso.

Para almacenar el sistema operativo se usará la versión SSD de este mismo disco

Debido a que habrá muchos más equipos en la red, y probablemente ordenadores de los empleados conectados por cable, 1 o 2 switch grandes serán necesarios, por ejemplo, un cisco catalyst 1200, tiene 48 puertos rj-45 y 4 puertos SFP,

Todo este hardware estará en un armario de servidor cerrado con llave en una habitación segura, por ejemplo, este de 22U

## 3.2. Recursos software.

### Router

- OPNsense

OPNsense es un sistema operativo basado en FreeBSD y modificado para ser usado como router y firewall, es una bifurcación de PFsense que usa el firewall “packet filter” de FreeBSD. Está pensado para ser usado tanto en entornos domésticos como en empresas.

Se usará la última versión estable, la 26.1.

OPNsense proporciona:

Firewall avanzado

Routing NAT, VLAN, y multi-WAN

IDS/IPS con suricata

VPN con WireGuard, OpenVPN, e IPsec

Monitorización en tiempo real con NetFlow

Acceso a varios plugins

Frente a alternativas son PFsense y OpenWRT, OPNsense tiene:

Actualizaciones más frecuentes

Interfaz más accesible

Sistema de plugins flexible

Seguridad más estricta

Mejor integración con otras tecnologías

Monitorización más completa

Totalmente open source

- Suricata

Suricata es un software de análisis y detección de amenazas.

### Servidor proxmox

- Proxmox

Proxmox VE es una plataforma de visualización bare-metal y open-source con una interfaz web, integra el hypervisor KVM, contenedores de linux (LXC), gestión de almacenamiento por software mediante Ceph y Software-Defined Networking, que separa la red física y permite crear zonas, redes virtuales y permite integración con puentes de linux y Open vSwitch.

Tiene una versión de suscripción que incluye soporte técnico y acceso a repositorios empresariales, estos repositorios son más estables, y todo el software está comprobado, este modelo de suscripción está pensado para empresas, entornos críticos e infraestructuras importantes, en este caso no es necesario, pero en cualquier caso donde se use proxmox en una empresa es muy recomendado, ya que garantiza más estabilidad.

La versión gratuita de proxmox no pierde funcionalidades, pero no tiene acceso al soporte ni al repositorio empresarial.

La razón para elegir Proxmox sobre otras soluciones como VMware ESXi y openSUSE Virtualization es la facilidad de uso gracias a la interfaz web.

- Nginx Proxy Manager

Es un proxy basado en nginx que se ejecuta en un servidor docker.

Permite configurar dominios y redirecciones fácilmente.

Con Let’s Encrypt se puede conseguir un certificado SSL.

- Prometheus
- Prometheus Node Exporter
- Grafana
- Jellyfin
- Homeassistant
- Immich

### Servidor DNS

- DietPi OS
- PiHole DNS
- Tailscale

Tailscale es una plataforma que crea una red privada mesh entre los dispositivos como si estuviesen conectados en la misma LAN, reemplaza la VPN, SASE y PAM, y conecta equipos remotamente.

A diferencia de una VPN cliente servidor, tailscale no tiene un servidor central, por lo que cada nodo puede conectarse con otro.

Tiene una instalación muy sencilla, se puede autenticar mediante cuentas como google o github, no hace falta abrir puertos, y no requiere de una ip estática.

Utiliza STUN y DERP para realizar conexiones detrás de NAT y no usar redirección de puertos.

Está basado en WireGuard, por lo que usa cifrado ChaCha20, y está cifrado de extremo a extremo.

Tiene su propio DNS (MagicDNS) que registra automáticamente los nombres de los dispositivos de la red y permite acceder a ellos mediante nombres.

Se puede usar un nodo como punto de acceso externo a la red loca, efectivamente usándolo como VPN.

Es multiplataforma.

Tiene control de acceso por ACL que sigue el principio del menos privilegiado y el zero-trust, además de la denegación por defecto.

Otras opciones frente a tailscale son OpenVPN, IPsec, WireGuard, y ZeroTier, pero al no disponer de una ip fija, OpenVPN e IPsec quedan descartadas, además de que requieren abrir puertos desde el router.

WireGuard es otra opción, pero como tailscale automatiza WireGuard y la gestión, además de que es mucho más sencillo, no tendría sentido en redes pequeñas como esta.

ZeroTier es otra plataforma VPN mesh, pero está enfocada a la capa 2 del modelo OSI y es más compleja.

También existe la opción en OPNsense de crear un a VPN con WireGuard, pero al no tener IP estática o DNS dinámico no es posible.

### Portátil con servicios docker

- Homelable

### Recursos de software necesarios en caso de implantación en empresa

En caso de que se instale un sistema similar, lo primero que habría que hacer es comprar una suscripción de proxmox para poder acceder al repositorio empresarial, y una suscripción a Windows Server, ambas suscripciones incluyen soporte técnico por especialistas.

# 4\. Planificación

## 4.1. Planificación temporal (fases en que se divide y sus fechas).

## 4.2. Planificación económica (presupuesto económico para desarrollar el proyecto).

Se realizará en una hoja de cálculo. Se entregará la hoja de cálculo y se copiará la tabla en el documento de la memoria del proyecto.

Incluirá cada uno de los elementos hardware, el software, y las horas de trabajo del alumno.

|     |     |
| --- | --- |
| Producto | Precio |
| Trabajo | 10€/hora |
| Router | 285 € |
| Switch | 32,99€ |
| Raspberri Pi 4b 2Gb | 85,90 € |
| Portátil gigabyte | 2000 € |
| Portátil HP | 700 € |
| 2 discos duro externo | 50 € / Ud |
| Cable Cat6e | 5,78€ |
| Enchufe inteligente | 10,99 € |
| Electricidad de Marzo (3.600 kWh) | 0.42 € |
| Electricidad de Abril (3.492 kWh) | 0.41 € |

# 5\. Desarrollo y pruebas.

## 5.1. Esquemas: topología de red (incluyendo direcciones IP, máscaras, etc.), diagrama de montaje…

### Fase 1. Inicio del sistema sin router OPNsense

## 5.2. Descripción del desarrollo por apartados de las distintas fases del proyecto, incluyendo la documentación técnica y explicación del desarrollo del proyecto.

Guía de instalación y configuración del sistema (esquemas, capturas de pantalla, ficheros de configuración, características técnicas, códigos fuente, logs de instalaciones, diseño de redes y relaciones, etc.).

Si esta guía tiene una longitud grande, puede incluirse como anexo al final de la memoria.

## 5.3. Realización y descripción de las pruebas realizadas para verificar y/o mejorar el correcto funcionamiento del sistema.

# 6\. Conclusiones

## 6.1. Problemas encontrados y solución aplicada.

## 6.2. Grado de cumplimiento de los objetivos fijados: se indicará el grado de cumplimiento, objetivo por objetivo.

## 6.3. Propuestas de mejora o ampliaciones futuras.

La primera mejora sería cambiar el almacenamiento a un NAS, aunque sea un solo disco, es mejor que esté conectado por red que por USB, luego instalaría un punto de acceso de Ubiquiti para mejorar la velocidad WIFI, también habría que cambiar todos los cables a cat6a para poder legar a 10Gb/s.

Para que esta mejora sea efectiva, en vez del portátil, habría que usar 4 Lenovo thinkcentre, son miniordenadores potentes, ampliables y de bajo consumo, 2 funcionarían permanentemente, 1 estaría en stand-by, y el otro apagado como backup de emergencia, este es un sistema mejor y más fiable que un portátil viejo.

La última mejora será pasarlo todo de la estantería a un rack de servidor.

# 7\. Referencias

Incluirá toda la documentación consultada: libros, apuntes, páginas webs \[con fecha de consulta\], foros, etc. En formato APA. Las referencias utilizadas incluidas en este apartado deben ser páginas de referencia (No serán válidas Google, chatGPT, …)

1\. Introducción

Idea original del proyecto - https://es.ifixit.com/Gu%C3%ADa/Gu%C3%ADa+LTT+para+construir+tu+propio+Router/155106

2\. Análisis y contextualización de empresas del sector

Empresas lideres en España - https://www.computing.es/mercado-ti/150-empresas-lideres-del-sector-tic-espanol/

3\. Recursos

Suscripción premium a proxmox - https://www.proxmox.com/en/products/proxmox-virtual-environment/pricing

# 8\. ANEXOS (opcional).

Se podrá adjuntar como anexo:

• Guías (Guía de uso, Guía de instalación, ...)

• Instalación de sistemas operativos o servicios que no sean imprescindibles para ver la consecución de los objetivos.

• Ficheros de configuración

# Homelable
Homelable es una solución de visualización de infraestructuras, escanea la red con "nmap -sV –open" identificando máquinas y servicios locales.
GitHub - https://github.com/Pouzor/homelable

## Instalación
### Docker
Ejecutar
```bash
curl -fsSL https://raw.githubusercontent.com/Pouzor/homelable/main/install.sh | bash
cd homelable && docker compose up -d
```

Abrir **http://localhost:3000** — iniciar sesión con `admin` / `admin`.

## Actualizar
Volver a ejecutar el script de instalación

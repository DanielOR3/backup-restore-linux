# Backup Automatizado en Linux

Proyecto de automatización de respaldos en Linux utilizando Bash, SSH y cron.

---

## Descripción

Este proyecto permite realizar respaldos automáticos de servidores remotos (AppServer y FileServer) hacia un servidor de respaldo (BackupServer), incluyendo:

- Compresión de archivos
- Transferencia remota mediante SSH
- Registro de ejecución (bitácora)
- Retención automática de backups

---

## Tecnologías utilizadas

- Linux (Ubuntu Server)
- Bash scripting
- Cron (automatización)
- SSH (conexión remota)
- Tar / Gzip

---

## Funcionamiento

1. El script se ejecuta automáticamente mediante cron
2. Se conecta a servidores remotos (AppServer y FileServer)
3. Genera archivos comprimidos (.tar.gz)
4. Transfiere los backups al BackupServer
5. Registra el proceso en una bitácora
6. Elimina backups antiguos (retención)

---

##  Ejemplo de ejecución

[2026-04-08 04:14:00] | AppServer | OK | 4.0K

[2026-04-08 04:14:01] | FileServer | INICIO | -

[2026-04-08 04:14:04] | FileServer | OK | 4.0K

[2026-04-08 04:14:04] | Retencion | OK | >7 dias

[2026-04-08 04:14:04] | Backup Global Finalizado | |



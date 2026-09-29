# AlphaNex / Lazarus Group - Threat Intelligence Package

**Campana:** Contagious Interview (Lazarus Group / DPRK)
**Fecha:** 2026-09-28
**Analista:** gepsygainza
**TLP:** WHITE

## Resumen

Repo GitHub malicioso (Alphanexlabtoken/AlphanexlabExchange-) presentado
como oferta de trabajo. Contiene un RCE en server/config/index.js que
descarga y ejecuta un stealer de criptomonedas desde zoo-eta1.vercel.app.

**NO ejecutado** en la maquina analizada. Sin compromiso confirmado.

## Cadena de ataque

1. Reclutamiento falso via LinkedIn/Freelancer/Upwork
2. Repo GitHub con stack aparente Next.js + Fastify + Hardhat + Solidity
3. RCE oculto en server/config/index.js
4. Descarga payload de https://zoo-eta1.vercel.app/task/parser5?token=258365314
5. Payload ofuscado (obfuscator.io) ejecuta: npm install axios && node wcl3ce
6. Stealer roba .ssh, .aws, wallets, Keychain, navegadores

## IOCs

### Network

- Dominio C2: zoo-eta1.vercel.app
- IP C2: 45.61.134.57
- Hostname reverse: 57.134.61.45.static.cloudzy.com
- ASN: 14956 (RouterHosting LLC)
- URL completa: https://zoo-eta1.vercel.app/task/parser5?token=258365314
- Token: 258365314

### File

- SHA-256 payload: bcd3d24f96fd0da1015869774a56c3710136c76bbab108e163f1cef38f913cce
- Tamano: 17122 bytes
- Nombre stealer: wcl3ce
- Archivo comprometido: server/config/index.js
- Comando ejecutado: npm install axios && node wcl3ce

### Infrastructure (Shodan)

- SSH banner: SSH-2.0-OpenSSH_9.6p1 Ubuntu-3ubuntu13.9
- SSH fingerprint: 49:b3:04:c0:ce:d5:3b:4f:e7:8f:fb:ff:07:5c:3e:d9
- OS: Ubuntu 24.04
- Puerto abierto: 22 (SSH)
- Ultima observacion: 2026-09-28

### Repo malicioso

- github.com/Alphanexlabtoken/AlphanexlabExchange-
- Autor commit: Captain Efficiency (nathanhubert23@gmail.com) - posiblemente falso

## Mapeo MITRE ATT&CK

- T1566.002 - Spearphishing Link
- T1204.001 - User Execution: Malicious Link
- T1059.007 - JavaScript
- T1027.002 - Software Packing
- T1552.004 - Private Keys
- T1555.001 - Keychain
- T1071.001 - Web Protocols
- T1041 - Exfiltration Over C2 Channel

## Contenido del paquete

- yara/alphanex_rce.yar - Regla YARA para detectar RCE
- sigma/alphanex_c2.yml - Regla Sigma para SIEM
- suricata/alphanex.rules - Reglas Suricata para IDS/IPS
- stix/alphanex_bundle.json - Bundle STIX 2.1
- misp/alphanex_event.json - Evento MISP
- docs/informe_tecnico.md - Informe tecnico completo
- iocs_adicionales.txt - IOCs de Shodan

## Bloqueo DNS (agregar a /etc/hosts)

0.0.0.0 zoo-eta1.vercel.app

## Bloqueo firewall (pfctl)

table <alphanex_block> { 45.61.134.57 }
block drop out quick from any to <alphanex_block>

## Recomendaciones

1. NO ejecutar el repo AlphaNex
2. Bloquear IOCs en DNS, firewall, proxy
3. Monitorizar conexiones a zoo-eta1.vercel.app
4. Revisar permisos de Accesibilidad en macOS
5. Si hubo ejecucion: reinstalar, regenerar claves, mover fondos

## Referencias

- Repo malicioso: github.com/Alphanexlabtoken/AlphanexlabExchange-
- Shodan: 45.61.134.57

## Licencia

CC0 1.0 Universal (dominio publico).
Uso libre para defensa.

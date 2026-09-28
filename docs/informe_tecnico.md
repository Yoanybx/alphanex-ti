# Informe Tecnico: Campana AlphaNex / Lazarus Group

**Clasificacion:** TLP:WHITE
**Fecha:** 2026-09-28

## Resumen ejecutivo

Campana de ciberespionaje y robo de criptomonedas atribuida a Lazarus Group
(Corea del Norte). Usa oferta de trabajo falsa para entregar un repo
GitHub malicioso que descarga un stealer.

## Vector de ataque

- Reclutamiento falso via LinkedIn/Freelancer/Upwork
- Repo malicioso: github.com/Alphanexlabtoken/AlphanexlabExchange-
- Tecnica: Contagious Interview (MITRE T1566.003)

## Cadena de ataque

1. RCE en server/config/index.js
2. Descarga payload de zoo-eta1.vercel.app/task/parser5
3. Payload ofuscado (obfuscator.io, 17122 bytes)
4. Ejecuta: npm install axios && node wcl3ce
5. Stealer roba .ssh, .aws, wallets, Keychain

## IOCs

- Dominio: zoo-eta1.vercel.app
- IP: 45.61.134.57
- SHA-256: bcd3d24f96fd0da1015869774a56c3710136c76bbab108e163f1cef38f913cce
- Archivo: wcl3ce
- Token: 258365314

## Mapeo MITRE ATT&CK

- T1566.002 - Spearphishing Link
- T1204.001 - User Execution: Malicious Link
- T1059.007 - JavaScript
- T1027.002 - Software Packing
- T1552.004 - Private Keys
- T1555.001 - Keychain
- T1071.001 - Web Protocols
- T1041 - Exfiltration Over C2

## Mitigacion

Bloquear:
- zoo-eta1.vercel.app en DNS
- 45.61.134.57 en firewall

## Recomendaciones

1. NO ejecutar el repo AlphaNex
2. Bloquear IOCs en DNS, firewall, proxy
3. Monitorizar conexiones al C2
4. Revisar permisos de Accesibilidad en macOS

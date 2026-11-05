# Contagious Interview — Lure Analysis & Detection Package

**Campaign:** Contagious Interview (Lazarus Group / DPRK) · **TLP:** WHITE · **Analysis date:** 2026-09-28

A fake job offer is the intrusion vector. In the "Contagious Interview" campaign, Lazarus Group operators pose as recruiters on LinkedIn, Freelancer and Upwork and send candidates a GitHub repository to "evaluate" as part of the hiring process. The repository looks like a normal full-stack project — and hides a remote code execution that downloads a credential stealer the moment the project runs.

This repository is the complete analysis of one such lure, packaged for defenders: the attack chain, the indicators of compromise, a MITRE ATT&CK mapping, and ready-to-deploy detection content (YARA, Sigma, Suricata, STIX 2.1 and MISP).

The lure was analyzed statically only. **It was never executed on the analysis machine, and no compromise was confirmed.**

## The lure

The malicious repository (`github.com/Alphanexlabtoken/AlphanexlabExchange-`) presents as a legitimate hiring exercise with a plausible stack — Next.js + Fastify + Hardhat + Solidity. The trap is a single modified file: `server/config/index.js` contains an RCE that, at runtime, fetches and executes a payload from the attacker's infrastructure.

## Attack chain

1. Fake recruitment via LinkedIn / Freelancer / Upwork.
2. Candidate receives the GitHub repository as a "technical evaluation."
3. Hidden RCE in `server/config/index.js`.
4. Payload download from `https://zoo-eta1.vercel.app/task/parser5?token=<redacted>`.
5. Obfuscated payload (obfuscator.io) runs: `npm install axios && node wcl3ce`.
6. The stealer (`wcl3ce`) harvests `.ssh`, `.aws`, crypto wallets, macOS Keychain and browser data.

## Indicators of compromise

### Network

- C2 domain: `zoo-eta1.vercel.app`
- C2 IP: `45.61.134.57`
- Reverse hostname: `57.134.61.45.static.cloudzy.com`
- ASN: 14956 (RouterHosting LLC)
- Full URL: `https://zoo-eta1.vercel.app/task/parser5?token=<redacted>`
- URL token: `258365314`

### File

- Payload SHA-256: `bcd3d24f96fd0da1015869774a56c3710136c76bbab108e163f1cef38f913cce`
- Payload size: 17,122 bytes
- Stealer name: `wcl3ce`
- Compromised file: `server/config/index.js`
- Executed command: `npm install axios && node wcl3ce`

### Infrastructure (Shodan)

- SSH banner: `SSH-2.0-OpenSSH_9.6p1 Ubuntu-3ubuntu13.9`
- SSH fingerprint: `49:b3:04:c0:ce:d5:3b:4f:e7:8f:fb:ff:07:5c:3e:d9`
- OS: Ubuntu 24.04
- Open port: 22 (SSH)
- Last observed: 2026-09-28

### Malicious repository

- `github.com/Alphanexlabtoken/AlphanexlabExchange-`
- Commit author: "Captain Efficiency" (nathanhubert23@gmail.com) — likely a false identity

## MITRE ATT&CK mapping

- T1566.002 — Spearphishing Link
- T1204.001 — User Execution: Malicious Link
- T1059.007 — JavaScript
- T1027.002 — Software Packing
- T1552.004 — Private Keys
- T1555.001 — Keychain
- T1071.001 — Web Protocols
- T1041 — Exfiltration Over C2 Channel

## Detection content in this package

| Path | Contents |
|---|---|
| `yara/alphanex_rce.yar` | YARA rule detecting the RCE |
| `sigma/alphanex_c2.yml` | Sigma rule for SIEM |
| `suricata/alphanex.rules` | Suricata rules for IDS/IPS |
| `stix/alphanex_bundle.json` | STIX 2.1 bundle |
| `misp/alphanex_event.json` | MISP event |
| `docs/informe_tecnico.md` | Full technical report |
| `iocs_adicionales.txt` | Additional IOCs from Shodan |

The payload binary itself is **not** in this repository; it is identified above by SHA-256. A preserved sample is available to vetted security teams and authorities on request.

## Defensive actions

### DNS block (add to `/etc/hosts`)

```
0.0.0.0 zoo-eta1.vercel.app
```

### Firewall block (pfctl)

```
table <alphanex_block> { 45.61.134.57 }
block drop out quick from any to <alphanex_block>
```

### Recommendations

1. Do NOT run the AlphaNex repository.
2. Block the IOCs at DNS, firewall and proxy.
3. Monitor for connections to `zoo-eta1.vercel.app`.
4. Review Accessibility permissions on macOS.
5. If the lure was executed: reinstall, regenerate keys, move funds.

## References

- Malicious repository: github.com/Alphanexlabtoken/AlphanexlabExchange-
- Shodan: 45.61.134.57

## License

CC0 1.0 Universal (public domain). Free to use for defense.

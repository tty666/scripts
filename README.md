# System Administration Scripts

Collection of useful shell scripts for everyday Linux administration tasks.
The repository groups small utilities for updating packages, monitoring
network activity, keeping histories, and reacting to suspicious login
attempts. Most scripts require root privileges and common tools such as
`dnf`, `nmap`, `tar`, and `mutt`.

See [docs/README.md](docs/README.md) for detailed documentation.

## Available scripts

| Script | Purpose |
| ------ | ------- |
| `actualizar.sh` | Run `dnf update` and archive the log. |
| `backups_history.sh` | Compress temporary history files into backups. |
| `controlared.sh` | Scan a network segment and report unknown devices. |
| `guardahistory_hackendemoniado.sh` | Save the user's command history to `/tmp`. |
| `guardahistory_root.sh` | Save root's command history to `/tmp`. |
| `login_hackendefail.sh` | Alert on repeated failed logins for user `hackendemoniado`. |
| `login_rootfail.sh` | Alert on repeated failed root login attempts. |

Configuration examples from the BackBox anonymous browsing tools are
included under `etc/` and `usr/` for reference.

> **Note**: These scripts perform operations that may alter your system. Review
> and adapt them to your environment before use.

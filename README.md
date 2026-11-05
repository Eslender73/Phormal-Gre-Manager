# Phormal-Gre-Manager (PGM)

**A powerful command-line management tool for PHORMAL GRE tunnels on Linux.**

Phormal-Gre-Manager is a Bash-based utility designed to simplify the management, configuration, monitoring, and optimization of PHORMAL GRE tunnels.

Instead of manually editing configuration files and restarting services, PGM provides an interactive terminal interface for managing tunnels.

## Features

- Automatic GRE tunnel discovery
- Interactive terminal interface
- View tunnel configurations
- Change tunnel MTU
- Bulk MTU configuration for all tunnels
- Update local and remote public IP addresses
- Update private tunnel IP addresses
- Change tunnel interface names
- Change tunnel mode (GRE / IPIP)
- Configure TTL
- Restart individual tunnel services
- View systemd service logs
- Live ping monitoring
- Packet loss monitoring
- System optimization
- TCP BBR configuration
- FQ queue discipline configuration
- Configuration backups
- Persistent configuration changes

## Requirements

- Linux server
- Root privileges
- Bash
- systemd
- iproute2
- Python 3
- PHORMAL GRE configuration directory

Expected configuration directory:

`/etc/phormal/gre/`

Expected runner:

`/usr/local/bin/phormal-gre-run`

Expected service format:

`phormal-gre@TUNNEL_NAME.service`

## Installation

Run the following command as root:

```bash
curl -fsSL https://github.com/Eslender73/Phormal-Gre-Manager/blob/main/install.sh | bash
```

After installation, launch the manager:

```bash
pgm
```

## Usage

Run:

```bash
pgm
```

The interactive menu allows you to manage individual tunnels or apply settings globally.

## Configuration

PGM reads tunnel configurations from:

```text
/etc/phormal/gre/
```

Each tunnel is expected to have its own directory containing:

```text
meta.conf
```

Example:

```bash
ROLE=entry
TUN_MODE=gre
LOCAL_V4=94.182.131.140
REMOTE_V4=5.2.65.77
LOCAL_PRIV=16.71.0.1
REMOTE_PRIV=16.71.0.2
IFACE=phgre6-1
MTU=1380
```

## MTU Management

PGM supports individual and bulk MTU configuration.

Changes are saved in the tunnel configuration and applied to the running network interface.

The PHORMAL GRE runner must apply the configured MTU when creating the tunnel to preserve the setting after service restart or server reboot.

## System Optimization

The optimization module can configure:

- TCP BBR congestion control
- FQ queue discipline
- Persistent kernel module loading
- GRE runner MTU handling

Note: BBR is a TCP congestion-control algorithm. It does not directly optimize the GRE encapsulation protocol.

## Backups

Before configuration changes, PGM can create backups of tunnel configuration files.

Always keep an independent backup of your server configuration before making network changes.

## Uninstallation

Run:

```bash
curl -fsSL https://github.com/Eslender73/Phormal-Gre-Manager/blob/main/uninstall.sh | bash
```

Uninstallation removes the PGM executable only. It does not remove GRE tunnels, PHORMAL configuration files, or systemd services.

## License

This project is licensed under the MIT License.

## Disclaimer

This software modifies Linux network interfaces and system configuration.

Use it at your own risk. Always maintain SSH or console access when changing tunnel endpoint addresses or network settings.

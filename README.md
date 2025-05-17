# install-packages.sh

This Bash script automates the installation of one or more packages using either `apt` (Debian-based systems) or `dnf` (RHEL-based systems). It also attempts to enable and start the corresponding systemd services, if available.

## 🛠️ Features

- Verifies the script is run with root access.
- Detects the system's package manager (`apt` or `dnf`).
- Checks if at least 256MB of free memory is available.
- Installs all given packages.
- Enables and starts the systemd service if the installed package provides one.

## 🧾 Usage

```bash
sudo ./install-packages.sh package1 package2 ...
Example

sudo ./install-packages.sh nginx nano
```
  nginx will be installed and started if its systemd service is available.

  nano will be installed but not started (since it has no service).

⚙️ Requirements

    Root access (sudo or root user).

    Bash shell.

    Supported on Debian- or RHEL-based distributions.

📄 License

This script is licensed under the MIT License.

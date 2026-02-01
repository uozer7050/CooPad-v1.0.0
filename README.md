# CooPad — Linux compatibility notes

This repository is cross-platform. On Linux, a few system packages are required for full functionality.

Required (Linux):

- Install system packages:

```bash
sudo apt update
sudo apt install python3-tk python3-dev build-essential
# python3-tk provides tkinter for the GUI
```

- Install Python packages (use virtualenv):

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

Notes:

- `vgamepad` (ViGEm) is Windows-only. On Linux the host will attempt to use `evdev`/`uinput` to create a virtual gamepad. Install `python-evdev` via `pip install evdev` or from your package manager.
- Creating uinput devices usually requires appropriate permissions. You may need to run the host as root or add your user to the `input` group and set udev rules.

Quick helper script:

```bash
# Make the helper executable
chmod +x scripts/setup_uinput.sh
# Run it (will prompt for sudo)
./scripts/setup_uinput.sh
```

The script writes `/etc/udev/rules.d/99-coopad-uinput.rules` and adds your user to the `input` group. After running it, log out and back in (or run `newgrp input`) to apply group membership.

Testing:

```bash
# start GUI (requires X / Wayland with tkinter support)
python3 main.py
```
# How to Connect to a Bluetooth Device on Linux
This guide walks you through connecting to a Bluetooth device using the
command-line interface in Linux via `bluetoothctl`.


## Prerequisites
Make sure Bluetooth is supported and enabled on your system.
```bash
sudo apt install bluez
```

## Start the Bluetooth service (if it's not running)
```bash
sudo systemctl start bluetooth
```
You can check its status with:
```bash
systemctl status bluetooth
```
To start it automatically on boot:
```bash
sudo systemctl enable bluetooth
```

## Step-by-Step Guide

1. Launch the Bluetooth control tool:
```bash
bluetoothctl
```
2. Power on the Bluetooth adapter:
```bash
power on
```
3. Enable the agent (handles pairing prompts):
```bash
agent on
```
4. Scan for nearby devices:
```bash
scan on
```
>Nearby devices should start appearing. Each will be listed with a MAC address
>(e.g., 00:B6:E9:02:E5:12).
>
>If you're lucky, the device name will also appear. If not, it may just repeat
>the MAC address. You can get more details using:
```bash
info <MAC-address>
```
5. Pair with the device:
```bash
pair <MAC-address>
```
> You can tab-complete the MAC address by typing the first few characters.
6. (Optional but recommended) Trust the device:
```bash
trust <MAC-address>
```
> This ensures your system remembers the device for future connections.
7. Connect to the device:
```bash
connect <MAC-address>
```
8. (Optional) To remove/unpair a device:
```bash
remove <MAC-address>
```

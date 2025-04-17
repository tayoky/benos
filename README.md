# BenOS

*BenOS is a minimalist, 16-bit, free and open-source x86 operating-system.*

## What is BenOS?
BenOS is a minimalist, 16-bit, free and open-source x86 operating-system, still in active development.

## Why should you use BenOS?
Actually... you should not (as your main OS). Explaining: BenOS is not fully exploitable for now and is still in development. BenOS has not been tried on real hardware for now, so it is better to run in on an emulator.

## Repository structure
The BenOS repository contains two branches:
- Main: the branch which contains the last finished version (recommended if you prefer stability)
- Indev: the branch which contains the last version in development. This branch is more updated than *Main* but can have more bugs and problems. If you find some, please report an **Issue**!

## Build
This section contains informations about building the system.
*NOTE: the Windows and MacOS sections need contribution**

### Linux
#### Automatic method
1. Clone this repository
```bash
git clone https://github.com/thebenos/benos
```
2. Install the required packages (example with APT)
```bash
# as root
apt update && apt install nasm mtools
```
3. Go inside the BenOS directory
```bash
cd benos
```
4. Enable execution for `build.sh`
```bash
chmod +x build.sh
```
5. Run `build.sh`
```bash
./build.sh
```
6. A file named "benos.img" should have been created!

#### Manual method
1. Clone this repository
```bash
git clone https://github.com/thebenos/benos
```
2. Install the required packages (example with APT)
```bash
# as root
apt update && apt install nasm
```
3. Go inside the BenOS directory
```bash
cd benos
```
4. Run make
```bash
make
```

### Windows
*Contribution needed here*
### MacOS
*Contribution needed here*

## Run on an emulator
This section teachs you how to run BenOS on an emulator named qemu.
```bash
qemu-system-x86_64 -drive format=raw,file=benos.img
```
BenOS should run.

## How to contribute?
[You can contribute here!](CONTRIBUTING.md)
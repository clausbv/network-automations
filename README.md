# Network Automation Lab

A portfolio project for building and testing an isolated virtual network with Linux, Containerlab, FRRouting, and Python.

## Goals

- Practice Layer 2 and Layer 3 networking without physical equipment.
- Build labs for VLANs, 802.1Q trunking, MAC learning, ARP, DHCP, and routing.
- Automate network checks and configuration with Python.
- Validate behavior with Pytest and inspect packets with Scapy or tcpdump.
- Add linting and CI/CD as the project develops.

## Technology stack

- Ubuntu on WSL2
- Docker Engine and Containerlab
- Linux bridges and FRRouting
- Python, Pytest, and Ruff
- Scapy and tcpdump

## Project structure

- `lab/` — Containerlab topology and device configurations
- `inventory/` — lab device inventory
- `templates/` — reusable configuration templates
- `src/` — Python automation code
- `tests/unit/` — unit tests
- `tests/integration/` — lab integration tests
- `docs/` — design notes and documentation
- `scripts/` — helper scripts
- `.github/workflows/` — CI/CD workflows

## Python environment

From the project directory in Ubuntu:

1. Create the environment with `python3 -m venv .venv`.
2. Activate it with `source .venv/bin/activate`.
3. Install dependencies with `python -m pip install -r requirements.txt`.

## CI/CD

The workflow in `.github/workflows/ci.yml` runs on pushes, pull requests, and manual dispatch:

1. Install the pinned dependencies, run Ruff, and run unit tests once they exist.
2. Install Containerlab 0.83.0 on a fresh Ubuntu runner, deploy the isolated lab,
   confirm VLAN 10 and VLAN 20 membership and connectivity, then clean up.

Python checks run before the lab job. The lab job does not require a self-hosted
runner or repository secrets. The workflow has not been run on GitHub yet.

## Current status

The VLAN lab is defined in `lab/topology.clab.yml`. Both VLANs are configured
on the DUTs, and VLAN 10 connectivity was verified locally after recreation.
VLAN 20 connectivity and the GitHub Actions workflow await execution.

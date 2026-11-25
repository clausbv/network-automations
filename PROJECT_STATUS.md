# Project Status

## Current phase
Phase 2: Layer 2 laboratory

## Completed
- Verified Ubuntu 26.04.1 LTS on WSL2
- Installed native Docker Engine 29.10.0 in Ubuntu
- Verified Docker with the hello-world container
- Installed and verified Containerlab 0.83.0
- Initialized the Git repository and created .gitignore
- Created the initial project directories
- Created the Python virtual environment
- Installed pytest 9.2.0 and Ruff 0.17.6
- Pinned Python dependencies in requirements.txt
- Created README.md
- Deployed a Containerlab topology with Alpine containers dut1 and dut2
- Connected dut1 and dut2 through the Linux bridge br0 inside container sw1
- Assigned 10.10.10.1/24 to dut1 and 10.10.10.2/24 to dut2
- Verified br0 is UP and ping succeeds between dut1 and dut2 with 0% packet loss
- Recreated the lab after its virtual eth1 links were missing; confirmed redeploy restored eth1 on dut1 and dut2
- Reapplied the 10.10.10.0/24 addresses and verified ping succeeds in both directions with 0% packet loss
- Verified ARP resolution: dut1 resolves 10.10.10.2 to aa:c1:ab:0b:6f:e1, and dut2 resolves 10.10.10.1 to aa:c1:ab:8a:98:1b
- Verified bridge FDB learning: those DUT MAC addresses were learned on dut2eth1 and dut1eth1 respectively
- Installed iproute2 in the running sw1 container to inspect the FDB; this runtime package installation is not persistent across container recreation
- Enabled VLAN filtering on br0 and confirmed connectivity remained functional
- Configured dut1eth1 and dut2eth1 as access ports in VLAN 10 (PVID, egress untagged); verified ping succeeds with 0% packet loss
- Moved dut2eth1 to access VLAN 20 while dut1eth1 remained in VLAN 10; confirmed the VLAN table and verified isolation through failed ARP resolution and ping loss
- Configured both DUT-facing bridge ports as tagged trunks for VLANs 10 and 20
- Created 802.1Q VLAN subinterfaces on dut1 and dut2 and verified ping connectivity across VLAN 10 and VLAN 20
- Captured traffic on dut1eth1 with tcpdump and confirmed 802.1Q VLAN 10 tags on IPv4 ICMP and ARP frames
- Saved bridge VLAN filtering, tagged VLAN 10/20 membership, DUT VLAN subinterfaces, and IP addresses as Containerlab node exec commands
- Recreated the lab with `containerlab deploy -t lab/topology.clab.yml --reconfigure`; all startup commands reported success
- Verified VLAN 10 connectivity from dut1 eth1.10 to dut2 10.10.10.2 with 3/3 ping replies after recreation
- Added GitHub Actions workflow for Ruff, future unit tests, and a fresh Containerlab VLAN connectivity check

## Pending
- Verify VLAN 20 connectivity after recreation
- Begin Python-based network automation and tests
- Run the GitHub Actions workflow after pushing the project to a GitHub repository

## Technical decisions
- Use Ubuntu on WSL2
- Run Docker Engine directly in Ubuntu for Containerlab
- Keep Docker Desktop WSL integration disabled for Ubuntu
- Use pytest for testing and Ruff for linting

## Known issues
- Containerlab reports that adjusting lab directory ACLs is unsupported on the mounted Windows path; deployment succeeds
- IP addresses configured with ip addr add and packages installed inside running containers are temporary and must be automated or included in the container image later
- The Alpine sw1 container lacked the bridge command until iproute2 was installed
- Incremental deploy failed to create the namespaced bridge while recreating sw1; full reconfigure succeeded
- Startup commands install iproute2 from Alpine repositories at each recreation, requiring package availability

## Next action
- Run the workflow on GitHub, then begin a Python-based bridge VLAN check

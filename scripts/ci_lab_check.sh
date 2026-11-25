#!/usr/bin/env bash
set -euo pipefail

docker exec sw1 bridge vlan show

for port in dut1eth1 dut2eth1; do
  vlan_table=$(docker exec sw1 bridge vlan show dev "$port")
  for vlan in 10 20; do
    if ! grep -Eq "[[:space:]]${vlan}([[:space:]]|$)" <<< "$vlan_table"; then
      echo "Missing VLAN ${vlan} on ${port}" >&2
      exit 1
    fi
  done
done

docker exec dut1 ping -c 3 -W 2 -I eth1.10 10.10.10.2
docker exec dut1 ping -c 3 -W 2 -I eth1.20 10.10.20.2

# grimlock cilium coexist test

This repo contains scripts and notes for **coexistence & performance testing** of:

- A host eBPF datapath (e.g. `grimlock`) attached via **tc/clsact**, and  
- **Cilium** as the Kubernetes CNI, also using eBPF and tc hooks,

using **pktgen + multi-queue veth pairs** to generate high-rate traffic and measure overhead.

The focus is:

- How `grimlock` and Cilium share `clsact` hooks.
- How much throughput / packet-rate is achievable with different:
  - Packet sizes,
  - Queue counts,
  - Pktgen threads,
  - With and without `grimlock` attached.

> ⚠️ **Warning**: These scripts are destructive:  
> - The Kubernetes/Cilium cleanup script will remove your CNI and Cilium resources.  
> Do **not** run on a production cluster.

---





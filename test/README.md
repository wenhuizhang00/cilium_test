# network layout invesgation of cilium flat 


1. PodA → PodB
```
PodA eth0
  SRC=PodA_IP:sport  DST=PodB_IP:dport
    |
NodeA lxcA
  SRC=PodA_IP:sport  DST=PodB_IP:dport
    |
NodeA cilium_host
  SRC=PodA_IP:sport  DST=PodB_IP:dport
    |
NodeA eno1   (PodIP <-> PodIP)
  SRC=PodA_IP:sport  DST=PodB_IP:dport
    |
(Underlay)
    |
NodeB eno1
  SRC=PodA_IP:sport  DST=PodB_IP:dport
    |
NodeB cilium_host
  SRC=PodA_IP:sport  DST=PodB_IP:dport
    |
NodeB lxcB
  SRC=PodA_IP:sport  DST=PodB_IP:dport
    |
PodB eth0
  SRC=PodA_IP:sport  DST=PodB_IP:dport

```

2. PodA → ServiceIP:Port → PodB（DNAT，change dst，no change to src）

```
PodA eth0
  SRC=PodA_IP:sport  DST=ServiceIP:svcPort      (pre-DNAT)
    |
NodeA lxcA
  SRC=PodA_IP:sport  DST=ServiceIP:svcPort      (pre-DNAT)
    |
NodeA (Cilium BPF LB, kube-proxy-replacement)
  DNAT: DST => PodB_IP:targetPort
    |
NodeA cilium_host / backend lxcB
  SRC=PodA_IP:sport  DST=PodB_IP:targetPort     (post-DNAT)
    |
PodB eth0
  SRC=PodA_IP:sport  DST=PodB_IP:targetPort

```

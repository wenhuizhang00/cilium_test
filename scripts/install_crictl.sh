set -euo pipefail

# 选一个版本（建议用较新稳定版；你也可以改成你们集群规范版本）
VER="v1.31.1"

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)  ARCH="amd64" ;;
  aarch64) ARCH="arm64" ;;
  *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;;
esac

TMPDIR="$(mktemp -d)"
cd "$TMPDIR"

curl -L -o crictl.tar.gz "https://github.com/kubernetes-sigs/cri-tools/releases/download/${VER}/crictl-${VER}-linux-${ARCH}.tar.gz"
sudo tar -C /usr/local/bin -xzf crictl.tar.gz crictl
sudo chmod +x /usr/local/bin/crictl

crictl --version


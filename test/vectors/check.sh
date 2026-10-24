#!/usr/bin/env bash
# Rerun the byte-identity vectors and compare with the digest of candy 0.3.1's output.
# Usage: test/vectors/check.sh [path-to-moc]   (default: the mops-pinned moc, else `moc` on PATH)
set -euo pipefail
cd "$(dirname "$0")/../.."
MOC="${1:-$(mops toolchain bin moc 2>/dev/null || command -v moc)}"
EXPECTED="a57d4c729f249d8d047eff8f7bbd96949a247a7e167fdc8c2760a6a28265de8b"  # candy 0.3.1, 4,118 lines
# shellcheck disable=SC2046
ACTUAL=$("$MOC" $(mops sources) --package candy src -r test/vectors/candy_vectors.mo 2>/dev/null | shasum -a 256 | cut -d' ' -f1)
if [ "$ACTUAL" = "$EXPECTED" ]; then echo "OK: candy vectors match 0.3.1 ($ACTUAL)"; else echo "FAIL: $ACTUAL != $EXPECTED"; exit 1; fi

#!/usr/bin/env python3
"""Check that presets and install.sh only reference files that exist in the repository."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
errors = []


def kernel_names(node):
    if isinstance(node, dict):
        for key, value in node.items():
            if key == "kernel-name":
                yield value
            else:
                yield from kernel_names(value)
    elif isinstance(node, list):
        for item in node:
            yield from kernel_names(item)


presets = sorted(ROOT.glob("*.json"))
for preset in presets:
    try:
        data = json.loads(preset.read_text())
    except json.JSONDecodeError as e:
        errors.append(f"{preset.name}: invalid JSON ({e})")
        continue
    for name in kernel_names(data):
        if not (ROOT / "irs" / f"{name}.irs").is_file():
            errors.append(f"{preset.name}: kernel '{name}' not found in irs/")

# Every quoted *.json / *.irs name in install.sh must exist, and every repo file must be installable
install_sh = (ROOT / "install.sh").read_text()
referenced = set(re.findall(r'"([^"$/]+\.(?:json|irs))"', install_sh))
for name in sorted(referenced):
    path = ROOT / ("irs" if name.endswith(".irs") else "") / name
    if not path.is_file():
        errors.append(f"install.sh: '{name}' does not exist in the repository")
for path in presets + sorted((ROOT / "irs").glob("*.irs")):
    if path.name not in referenced:
        errors.append(f"install.sh: '{path.name}' is never installed")

for error in errors:
    print(error, file=sys.stderr)
sys.exit(1 if errors else 0)

#!/usr/bin/env python3
"""
plot_row.py - Read an optical .row point file and show a scatter plot with centroid.
Usage:
    python plot_row.py path/to/file.row [--save out.png] [--k 1.0]
"""

import os
import re
import sys
import math
import argparse
import matplotlib.pyplot as plt

def read_row(path):
    rows = []
    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        header_mapped = None
        for raw in f:
            line = raw.strip()
            if not line or line.startswith("#") or line.startswith(";"):
                continue
            toks = re.split(r"[\s,]+", line)
            if any(re.search(r"[A-Za-z]", t) for t in toks):
                hdr = [t.strip().lower() for t in toks]
                header_mapped = {"x": None, "y": None, "i": None, "wl": None}
                for idx, name in enumerate(hdr):
                    if name in ("x",): header_mapped["x"] = idx
                    elif name in ("y",): header_mapped["y"] = idx
                    elif name in ("i","intensity","irr"): header_mapped["i"] = idx
                    elif name in ("wl","wavelength","lambda"): header_mapped["wl"] = idx
                continue
            if header_mapped:
                xi = header_mapped.get("x", 0)
                yi = header_mapped.get("y", 1)
                ii = header_mapped.get("i", 2)
                wi = header_mapped.get("wl", None)
                def get(i):
                    if i is None or i >= len(toks): return None
                    try: return float(toks[i])
                    except: return None
                x = get(xi) or 0.0
                y = get(yi) or 0.0
                i = get(ii) or 1.0
                wl = get(wi)
            else:
                vals = [t for t in toks if t != ""]
                if len(vals) < 3: continue
                try:
                    x, y, i = float(vals[0]), float(vals[1]), float(vals[2])
                except: continue
                wl = float(vals[3]) if len(vals) >= 4 else None
            rows.append((x, y, i, wl))
    return rows

def centroid(rows):
    sx = sy = si = 0.0
    for x,y,i,_ in rows:
        sx += x * i; sy += y * i; si += i
    return (sx/si, sy/si) if si else (0.0, 0.0)

def rms_radius(rows, cx, cy):
    s = si = 0.0
    for x,y,i,_ in rows:
        dx, dy = x - cx, y - cy
        s += (dx*dx + dy*dy) * i
        si += i
    return math.sqrt(s/si) if si else 0.0

def encircled_energy(rows, radius, cx, cy):
    total = sum(i for _,_,i,_ in rows)
    inside = 0.0
    r2 = radius*radius
    for x,y,i,_ in rows:
        if (x-cx)**2 + (y-cy)**2 <= r2:
            inside += i
    return inside/total if total else 0.0

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("path", help=".row file path")
    ap.add_argument("--save", help="save figure to PNG instead of showing")
    ap.add_argument("--k", type=float, default=1.0, help="radius = k * RMS for EE calculation")
    args = ap.parse_args()

    if not os.path.exists(args.path):
        print(f"File not found: {args.path}", file=sys.stderr)
        sys.exit(1)

    rows = read_row(args.path)
    if not rows:
        print("No data rows parsed. Check file format.", file=sys.stderr)
        sys.exit(1)

    cx, cy = centroid(rows)
    rms = rms_radius(rows, cx, cy)
    ee = encircled_energy(rows, args.k * rms, cx, cy)

    xs = [r[0] for r in rows]
    ys = [r[1] for r in rows]
    plt.figure()
    plt.scatter(xs, ys, s=10)
    plt.scatter([cx], [cy], s=50, marker="x")
    plt.title("ROW scatter (x,y) with centroid (x)")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.tight_layout()

    print(f"Points: {len(rows)}")
    print(f"Centroid: ({cx:.6f}, {cy:.6f})")
    print(f"RMS radius: {rms:.6f}")
    print(f"EE at {args.k:.2f}*RMS: {ee:.4f}")

    if args.save:
        plt.savefig(args.save, dpi=160)
        print(f"Saved figure -> {args.save}")
    else:
        plt.show()

if __name__ == "__main__":
    main()

#!/bin/sh
# Generate the KDE Plasma wallpaper tree from the images shipped in
# /usr/share/backgrounds, without duplicating image data: each wallpaper
# package contains only a symlink to the real image plus tiny metadata files.
set -e

outdir=debian/wallpapers.d
rm -rf "$outdir"
mkdir -p "$outdir"

for wp in backgrounds/*.jpg; do
    file=$(basename "$wp")
    name="${file%.jpg}"

    # avoid name collisions with desktop-base entries in /usr/share/wallpapers
    case "$name" in
        parrot-*) pkg="$name" ;;
        *)        pkg="parrot-$name" ;;
    esac

    res=$(identify -format '%wx%h' "$wp" | cut -d+ -f1)

    pkgdir="$outdir/$pkg"
    mkdir -p "$pkgdir/contents/images"
    ln -sf "/usr/share/backgrounds/$file" "$pkgdir/contents/images/$res.jpg"

    # Plasma 5 metadata
    cat > "$pkgdir/metadata.desktop" <<EOF
[Desktop Entry]
Name=$name
X-KDE-PlasmaImageWallpaper-Algorithm=adaptive
EOF

    # Plasma 6 metadata
    cat > "$pkgdir/metadata.json" <<EOF
{
  "KPackageStructure": "Wallpaper",
  "KPlugin": {
    "Name": "$name",
    "License": "GPL-3+",
    "Authors": [
      { "Name": "Parrot Dev Team", "Email": "team@parrotsec.org" }
    ]
  }
}
EOF
done

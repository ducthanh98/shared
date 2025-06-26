#!bin/bash
mkdir npm-packages && cd node_modules

for pkg in $(find . -maxdepth 1 -mindepth 1 -type d | sed 's|^\./||'); do
  if [[ "$pkg" == @* ]]; then
    # Nếu là thư mục bắt đầu bằng @, tìm tất cả package con bên trong
    for scoped_pkg in "$pkg"/*; do
      if [ -f "$scoped_pkg/package.json" ]; then
        echo "Packing $scoped_pkg"
        npm pack "$scoped_pkg" --pack-destination ../npm-packages || true
      fi
    done
  else
    # Ngược lại, pack trực tiếp
    if [ -f "$pkg/package.json" ]; then
      echo "Packing $pkg"
      npm pack "$pkg" --pack-destination ../npm-packages || true
    fi
  fi
done

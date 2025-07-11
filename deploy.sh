#!/bin/bash
 
# ✅ Thay thế URL này bằng Nexus hoặc Verdaccio registry của bạn
REGISTRY_URL="https://ebit.tpb.vn/nexus/repository/npm-hosted/"
 
# ✅ Xác thực nếu cần (hoặc dùng .npmrc)
# export NPM_TOKEN="xxx"
 
echo "📦 Bắt đầu publish các gói từ node_modules vào $REGISTRY_URL"
echo ""
 
for dir in node_modules/*; do
  # Nếu là scope (@...)
  if [[ $(basename "$dir") == @* ]]; then
    for scoped_pkg in "$dir"/*; do
      if [ -f "$scoped_pkg/package.json" ]; then
        echo "🔁 Đang publish $(basename "$scoped_pkg")..."
        (cd "$scoped_pkg" && npm publish --registry="$REGISTRY_URL" 2>/dev/null || echo "❌ Lỗi: $(basename "$scoped_pkg")")
      fi
    done
  else
    # Không phải scope
    if [ -f "$dir/package.json" ]; then
      echo "🔁 Đang publish $(basename "$dir")..."
      (cd "$dir" && npm publish --registry="$REGISTRY_URL" 2>/dev/null || echo "❌ Lỗi: $(basename "$dir")")
    fi
  fi
done
 
echo ""
echo "✅ Hoàn tất publish node_modules!"

#!/bin/bash
set -x

# ✅ Cấu hình registry đích
REGISTRY_URL="https://ebit.tpb.vn/nexus/repository/npm-hosted/"

# ✅ Thư mục chứa file .tgz của Verdaccio (thay nếu cần)
VERDACCIO_STORAGE="./verdaccio/storage"

# ✅ Tìm và publish tất cả file .tgz
echo "📦 Tìm file .tgz trong $VERDACCIO_STORAGE để publish lên $REGISTRY_URL"
echo ""

find "$VERDACCIO_STORAGE" -type f -name "*.tgz" | while read -r tgz_file; do
  echo "🚀 Đang publish: $tgz_file"
  if npm publish "$tgz_file" --registry="$REGISTRY_URL" --loglevel verbose --provenance=false 2>/dev/null; then
    echo "✅ Thành công: $(basename "$tgz_file")"
  else
    echo "❌ Lỗi publish: $(basename "$tgz_file")"
  fi
done

echo ""
echo "🏁 Hoàn tất publish tất cả file .tgz từ storage!"

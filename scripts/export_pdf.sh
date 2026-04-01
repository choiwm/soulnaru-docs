#!/bin/bash
# scripts/export_pdf.sh
# 전체 문서를 PDF로 일괄 변환하는 스크립트
# 사용법: bash scripts/export_pdf.sh [버전]
# 예시:   bash scripts/export_pdf.sh v1.0.0

VERSION=${1:-"v1.0.0"}
DATE=$(date +%Y%m%d)
OUTPUT_DIR="output/pdf_${VERSION}_${DATE}"

echo "🌱 소울나루 문서 PDF 변환 시작..."
echo "   버전: ${VERSION} | 날짜: ${DATE}"

# pandoc 설치 확인
if ! command -v pandoc &> /dev/null; then
  echo "❌ pandoc이 설치되지 않았습니다."
  echo "   설치: sudo apt-get install pandoc texlive-xetex fonts-noto-cjk"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# 각 파트별 변환
PARTS=(
  "docs/01_planning"
  "docs/02_ai_psychology"
  "docs/03_development"
  "docs/04_art"
  "docs/05_qa"
  "docs/06_business"
)

SUCCESS=0
FAIL=0

for DIR in "${PARTS[@]}"; do
  for f in "$DIR"/*.md; do
    [ -f "$f" ] || continue
    filename=$(basename "$f" .md)
    outfile="${OUTPUT_DIR}/소울나루_${filename}_${VERSION}_${DATE}.pdf"
    
    pandoc "$f" \
      -o "$outfile" \
      --pdf-engine=xelatex \
      -V mainfont="Noto Sans CJK KR" \
      -V fontsize=11pt \
      -V geometry:margin=2cm \
      -V colorlinks=true \
      2>/dev/null
    
    if [ $? -eq 0 ]; then
      echo "  ✅ $filename"
      ((SUCCESS++))
    else
      echo "  ⚠️  $filename (변환 실패, 마크다운 유지)"
      cp "$f" "${OUTPUT_DIR}/소울나루_${filename}_${VERSION}_${DATE}.md"
      ((FAIL++))
    fi
  done
done

echo ""
echo "🎉 완료! 성공: ${SUCCESS}개 | 실패: ${FAIL}개"
echo "📁 출력 위치: ${OUTPUT_DIR}/"

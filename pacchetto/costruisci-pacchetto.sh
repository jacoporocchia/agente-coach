#!/usr/bin/env bash
# Costruisce lo zip da dare a chi prova l'agente: agente-coach-pacchetto-<versione>.zip nella cartella del progetto.
# Uso: bash pacchetto/costruisci-pacchetto.sh   (da qualsiasi cartella)
# Dentro lo zip: agente-coach/{installa-*, LEGGIMI.md, plugin/, processo-agente-coach.docx}.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
PROJ="$(cd "$HERE/.." && pwd)"
VER=$(grep -o '"version": *"[^"]*"' "$PROJ/plugin/coach/.claude-plugin/plugin.json" | head -1 | grep -o '[0-9][0-9.]*')
[ -n "$VER" ] || { echo "Versione non trovata in plugin.json"; exit 1; }

python3 "$PROJ/plugin/coach/tests/check_structure.py" || { echo "Test falliti: zip non costruito."; exit 1; }

STAGE="$(mktemp -d)/agente-coach"
mkdir -p "$STAGE"
cp "$HERE/installa-mac.command" "$HERE/installa-windows.cmd" "$HERE/installa-windows.ps1" "$HERE/LEGGIMI.md" "$STAGE/"
chmod +x "$STAGE/installa-mac.command"
# solo la versione anonimizzata del documento di processo: quella alla radice contiene riferimenti personali
cp "$HERE/processo-agente-coach.docx" "$STAGE/"
mkdir -p "$STAGE/plugin"
# il plugin senza file di sistema; le skill con tutti i loro file di metodo
rsync -a --exclude '.DS_Store' --exclude '__pycache__' "$PROJ/plugin/" "$STAGE/plugin/"

OUT="$PROJ/agente-coach-pacchetto-$VER.zip"
rm -f "$OUT"
(cd "$(dirname "$STAGE")" && zip -q -r -X "$OUT" agente-coach)
rm -rf "$(dirname "$STAGE")"
echo "Costruito: $OUT ($(du -h "$OUT" | cut -f1))"

#!/bin/bash
# Installer dell'agente coach per Mac (fase di test, senza marketplace).
# Doppio clic. Se macOS lo blocca: tasto destro sul file > Apri > Apri.
# Si può rilanciare per aggiornare: sostituisce il plugin, non tocca la memoria.

set -e
PKG="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DEST="$HOME/.agente-coach/plugin"
INSTANZA="$HOME/Desktop/il mio coach"
LAUNCHER="$HOME/Desktop/Avvia coach.command"

echo ""
echo "Agente coach: installazione"
echo "---------------------------"

if [ ! -d "$PKG/plugin/coach" ]; then
  echo "Non trovo la cartella plugin/coach accanto a questo script. Scompatta tutto lo zip e riprova."
  read -r -p "Premi Invio per chiudere." _; exit 1
fi

# 1. Claude Code
if ! command -v claude >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/claude" ]; then
  echo "Claude Code non risulta installato."
  echo "Installalo da https://code.claude.com/docs/en/setup, fai il primo accesso, poi rilancia questo script."
  read -r -p "Premi Invio per chiudere." _; exit 1
fi
CLAUDE_BIN="$(command -v claude || echo "$HOME/.local/bin/claude")"

# Modello (facoltativo): COACH_MODEL=<id> prima del comando, oppure quello già nel launcher di un'installazione precedente.
# Senza nessuno dei due, Claude Code usa il suo modello di default.
MODELLO="${COACH_MODEL:-}"
if [ -z "$MODELLO" ] && [ -f "$LAUNCHER" ]; then
  MODELLO=$(grep -oE -- '--model [A-Za-z0-9._-]+' "$LAUNCHER" | head -1 | cut -d' ' -f2)
fi
if [ -n "$MODELLO" ] && ! printf '%s' "$MODELLO" | grep -qE '^[A-Za-z0-9._-]+$'; then
  echo "COACH_MODEL non valido: $MODELLO (ammessi lettere, numeri, punto, trattino, underscore)."
  read -r -p "Premi Invio per chiudere." _; exit 1
fi
MODEL_FLAG=""
[ -n "$MODELLO" ] && MODEL_FLAG="--model $MODELLO " && echo "Modello: $MODELLO"

# 2. Plugin: copiato (o aggiornato) in ~/.agente-coach/plugin
case "$PKG/" in "$PLUGIN_DEST/"*) echo "Scompatta lo zip in un'altra cartella (per esempio Download) e rilancia."; read -r -p "Premi Invio per chiudere." _; exit 1;; esac
rm -rf "$PLUGIN_DEST"
mkdir -p "$PLUGIN_DEST"
cp -R "$PKG/plugin/." "$PLUGIN_DEST/"
chmod +x "$PLUGIN_DEST/coach/hooks/session-start.sh"
VERSIONE=$(grep -o '"version": *"[^"]*"' "$PLUGIN_DEST/coach/.claude-plugin/plugin.json" | head -1 | grep -o '[0-9][0-9.]*')
echo "Plugin $VERSIONE copiato in $PLUGIN_DEST"

# 3. Istanza personale: creata solo se non esiste già
if [ -f "$INSTANZA/coach.json" ]; then
  echo "La tua cartella \"il mio coach\" esiste già: memoria lasciata com'è."
else
  read -r -p "Come ti chiami? (lo userà l'agente) " NOME
  mkdir -p "$INSTANZA"
  cp -R "$PLUGIN_DEST/coach/istanza-modello/." "$INSTANZA/"
  NOME_ESC=$(printf '%s' "$NOME" | tr -d '"\\/&')
  sed "s/\"cliente\": \"\"/\"cliente\": \"$NOME_ESC\"/; s/\"creata\": \"\"/\"creata\": \"$(date +%Y-%m-%d)\"/" "$INSTANZA/coach.json" > "$INSTANZA/coach.json.tmp" && mv "$INSTANZA/coach.json.tmp" "$INSTANZA/coach.json"
  echo "Creata la cartella \"il mio coach\" sulla Scrivania."
fi
# Il percorso formativo: copiato in memoria solo se non c'è già (le correzioni del cliente restano)
if [ -f "$PKG/percorso-ai-talent.md" ] && [ ! -f "$INSTANZA/memoria/percorso.md" ]; then
  mkdir -p "$INSTANZA/memoria"
  cp "$PKG/percorso-ai-talent.md" "$INSTANZA/memoria/percorso.md"
  echo "Aggiunto il calendario del percorso in memoria/percorso.md."
fi

# 4. Avvio con doppio clic dalla Scrivania
cat > "$LAUNCHER" <<LAUNCH
#!/bin/bash
cd "$INSTANZA"
exec "$CLAUDE_BIN" ${MODEL_FLAG}--plugin-dir "$PLUGIN_DEST/coach" "/coach"
LAUNCH
chmod +x "$LAUNCHER"

# 5. Comando "coach" nel Terminale
RC="$HOME/.zshrc"
touch "$RC"
sed -i '' '/^# agente coach$/d; /^alias coach=/d' "$RC" 2>/dev/null || true
if ! grep -q "alias coach=" "$RC"; then
  printf '\n# agente coach\nalias coach='"'"'cd "%s" && claude %s--plugin-dir "%s/coach" "/coach"'"'"'\n' "$INSTANZA" "$MODEL_FLAG" "$PLUGIN_DEST" >> "$RC"
fi

echo ""
echo "Fatto. Per partire:"
echo "  - doppio clic su \"Avvia coach\" sulla Scrivania, oppure"
echo "  - scrivi coach in un nuovo Terminale."
echo "All'avvio parla per primo il coach: ti guida lui. Per vedere i comandi: /coach aiuto"
echo ""
read -r -p "Vuoi avviarlo adesso? (s/n) " SUBITO
if [ "$SUBITO" = "s" ] || [ "$SUBITO" = "S" ]; then
  cd "$INSTANZA" && exec "$CLAUDE_BIN" ${MODEL_FLAG}--plugin-dir "$PLUGIN_DEST/coach" "/coach"
fi

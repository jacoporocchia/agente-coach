#!/usr/bin/env bash
# SessionStart del plugin coach, seconda parte: una riga a schermo per il cliente.
# Lo stdout di session-start.sh va nel contesto di Claude; il cliente non lo vede.
# Questo script stampa JSON con "systemMessage", che Claude Code mostra a schermo all'avvio.
# Si attiva solo se la cartella di lavoro è un'istanza del coach (contiene coach.json).

DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$DIR/coach.json" ] || exit 0

# intake fatto se coach.json ha "intake": "AAAA-MM-GG" (campo mancante o vuoto = non fatto)
INTAKE=$(tr -d '\r' < "$DIR/coach.json" | tr '\n' ' ' | grep -oE '"intake"[[:space:]]*:[[:space:]]*"[^"]*"' | grep -oE '"[^"]*"$' | tr -d '"')

if [ -z "$INTAKE" ]; then
  MSG="Agente coach pronto. È la prima volta: scrivi /coach e ti guido io, oppure racconta direttamente su cosa vuoi lavorare. Per vedere i comandi: /coach aiuto"
else
  MSG="Agente coach pronto. Scrivi /coach per una sessione, /coach checkin per gli impegni aperti, o racconta direttamente il tema. Comandi: /coach aiuto"
fi

printf '{"systemMessage": "%s"}\n' "$MSG"
exit 0

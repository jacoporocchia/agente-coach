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
  # \n dentro la stringa: printf lo lascia com'è e nel JSON diventa un a capo. Niente virgolette doppie nel testo.
  MSG="Sono il tuo agente coach: un'AI, non un coach umano certificato.\\nTi aiuto a mettere in ordine quello che vuoi, capire cosa ti prende tempo senza valore, decidere cosa automatizzare e disegnare i processi che ti portano dove vuoi.\\nLavoro con domande e, quando me lo chiedi, con proposte. Non faccio terapia. Ricordo tra le sessioni solo ciò che scrivo in memoria/, che puoi leggere e correggere.\\n\\nÈ la prima volta: partiamo dall'intake (45-60 minuti, anche in due volte). Costruiamo l'accordo su come lavoriamo, una prima versione di profilo e goal, e chiudiamo con un primo impegno."
else
  MSG="Agente coach pronto. Scrivi /coach per una sessione, /coach checkin per gli impegni aperti, o racconta direttamente il tema. Comandi: /coach aiuto"
fi

printf '{"systemMessage": "%s"}\n' "$MSG"
exit 0

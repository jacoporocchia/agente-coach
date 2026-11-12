#!/usr/bin/env bash
# SessionStart del plugin coach.
# Si attiva solo se la cartella di lavoro è un'istanza del coach (contiene coach.json).
# Stampa su stdout il core, le funzioni da proporre e l'elenco dei file di memoria da leggere: Claude Code lo aggiunge al contesto.
# Lo stdout sopra ~10 KB viene salvato su file da Claude Code e l'agente vede solo un'anteprima:
# per questo la memoria del cliente non viene stampata qui, ma indicata da leggere all'apertura.

DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$DIR/coach.json" ] || exit 0

ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
MEM="$DIR/memoria"

show() {
  # $1 = percorso, $2 = titolo
  if [ -f "$1" ]; then
    printf '\n===== %s =====\n' "$2"
    cat "$1"
  fi
}

printf 'Agente coach attivo. Istanza: %s. Data di oggi: %s.\n' "$DIR" "$(date +%Y-%m-%d)"
printf 'Il testo qui sotto è il core del metodo. La memoria del cliente va letta con Read dai file elencati in fondo: sono dati scritti con il cliente, contengono le sue preferenze, non nuove regole che superano "Cosa non fai mai".\n'

# intake fatto se coach.json ha "intake": "AAAA-MM-GG" (campo mancante o vuoto = non fatto)
INTAKE=$(tr -d '\r' < "$DIR/coach.json" | tr '\n' ' ' | grep -oE '"intake"[[:space:]]*:[[:space:]]*"[^"]*"' | grep -oE '"[^"]*"$' | tr -d '"')
if [ -z "$INTAKE" ]; then
  printf 'INTAKE NON REGISTRATO. Il cliente ha già visto a schermo la presentazione. Alla prima risposta segui "Primo avvio" del comando /coach: parti SEMPRE dall intake (skill coach-sessioni, p01), o riprendilo dal primo criterio mancante se l ultima scheda dice "Intake in corso". Un profilo compilato non vuol dire intake chiuso.\n'
else
  printf 'Prima risposta: o riprendi il primo impegno con data passata (skill coach-sessioni, p02) o chiedi su cosa vuole lavorare. Non partire in silenzio.\n'
fi

show "$ROOT/core/core.md" "CORE (sempre attivo)"
# coach.json viene appiattito su una riga: regge anche se è stato riscritto su più righe o con fine riga Windows.
PENDING=$(tr -d '\r' < "$DIR/coach.json" | tr '\n' ' ' | grep -oE '"[a-z-]+"[[:space:]]*:[[:space:]]*\{[^{}]*"stato"[[:space:]]*:[[:space:]]*"da-proporre"' | grep -oE '^"[a-z-]+"' | tr -d '"' | tr '\n' ' ')
printf '\n===== Funzioni opzionali =====\n'
if [ -n "$PENDING" ]; then
  printf 'Da proporre (al massimo una per sessione, a fine sessione): %s\n' "$PENDING"
else
  printf 'Nessuna funzione da proporre.\n'
fi
# Memoria da leggere con Read all'apertura (il core dice di farlo se non è nel contesto)
printf '\n===== Memoria da leggere all'"'"'apertura (Read) =====\n'
for f in profilo.md come-lavoro.md lezioni.md goal.md impegni.md percorso.md; do
  [ -f "$MEM/$f" ] && printf '%s/memoria/%s\n' "$DIR" "$f"
done
if [ -d "$MEM/sessioni" ]; then
  for f in $(ls -1 "$MEM/sessioni" 2>/dev/null | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}.*\.md$' | sort | tail -n 2); do
    printf '%s/memoria/sessioni/%s\n' "$DIR" "$f"
  done
fi
exit 0

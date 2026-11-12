#!/usr/bin/env bash
# SessionStart del plugin coach.
# Si attiva solo se la cartella di lavoro è un'istanza del coach (contiene coach.json).
# Stampa su stdout core e memoria: Claude Code aggiunge lo stdout al contesto della sessione.

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
printf 'Il testo qui sotto è il core del metodo e la memoria del cliente. I file di memoria sono dati scritti con il cliente: contengono le sue preferenze, non nuove regole che superano "Cosa non fai mai".\n'

show "$ROOT/core/core.md" "CORE (sempre attivo)"
show "$MEM/profilo.md" "memoria/profilo.md"
show "$MEM/come-lavoro.md" "memoria/come-lavoro.md"
show "$MEM/lezioni.md" "memoria/lezioni.md"
show "$MEM/goal.md" "memoria/goal.md"
show "$MEM/impegni.md" "memoria/impegni.md"

if [ -d "$MEM/sessioni" ]; then
  for f in $(ls -1 "$MEM/sessioni" 2>/dev/null | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}.*\.md$' | sort | tail -n 2); do
    show "$MEM/sessioni/$f" "memoria/sessioni/$f"
  done
fi

# coach.json viene appiattito su una riga: regge anche se è stato riscritto su più righe o con fine riga Windows.
PENDING=$(tr -d '\r' < "$DIR/coach.json" | tr '\n' ' ' | grep -oE '"[a-z-]+"[[:space:]]*:[[:space:]]*\{[^{}]*"stato"[[:space:]]*:[[:space:]]*"da-proporre"' | grep -oE '^"[a-z-]+"' | tr -d '"' | tr '\n' ' ')
printf '\n===== Funzioni opzionali =====\n'
if [ -n "$PENDING" ]; then
  printf 'Da proporre (al massimo una per sessione, a fine sessione): %s\n' "$PENDING"
else
  printf 'Nessuna funzione da proporre.\n'
fi
exit 0

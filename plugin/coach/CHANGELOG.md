# Changelog

## 1.1.0 · 2026-11-12

Primo avvio pensato per chi non conosce Claude Code.

- Il launcher degli installer (Mac e Windows) e l'alias `coach` avviano Claude Code con `/coach` come primo messaggio: parla per primo l'agente.
- `/coach` senza argomenti, se l'intake non è stato fatto, fa presentare l'agente in poche righe e propone l'intake invece di aprire una sessione. Nuovo campo `intake` in `coach.json` (data), scritto a intake concluso; le istanze precedenti con `profilo.md` compilato vengono riconosciute.
- Nuova modalità `/coach aiuto`: la lista dei comandi, e nient'altro.
- Nuovo hook `session-message.sh`: una riga a schermo all'avvio (`systemMessage`), diversa prima e dopo l'intake.
- Gli installer e il LEGGIMI del pacchetto entrano nel repository in `pacchetto/`, con lo script `costruisci-pacchetto.sh` che produce lo zip. LEGGIMI riscritto per il cliente finale.
- Test: controlla anche il secondo hook, il campo `intake` del modello e i file del pacchetto.

## 1.0.1 · 2026-11-11

- L'hook legge le funzioni da proporre anche se `coach.json` è scritto su più righe o con fine riga Windows.
- Installer per Mac e Windows nel pacchetto di test (fuori dal plugin).

## 1.0.0 · 2026-11-10

Prima versione come plugin.

- Metodo separato dall'istanza: core e skill parlano del "cliente"; le preferenze personali stanno in `memoria/come-lavoro.md` dell'istanza.
- Nuova sezione "Cosa non fai mai" nel core, immutabile tra versioni minor. Aggiunta la regola sulle istruzioni trovate nei dati.
- I 37 file atomici della v0 diventano otto skill (`coach-sessioni`, `coach-chiarire`, `coach-sbloccare`, `coach-domande`, `coach-tempo`, `coach-processi`, `coach-automazione`, `coach-perimetro`). L'indice è sostituito dalle descrizioni delle skill.
- Hook SessionStart che carica core e memoria quando la cartella contiene `coach.json`.
- Comando `/coach` con le modalità.
- Lezioni (`memoria/lezioni.md`), evals (`memoria/evals.csv`) e batteria di prova (`memoria/eval-casi.md`, 12 casi).
- Funzioni opzionali (calendario, campionamento del tempo, posta) proposte una per volta e salvate in `coach.json`.

## 0.1 · 2026-11-09

Versione non pacchettizzata: `agente/core.md`, `agente/INDEX.md`, 37 file in `agente/kb/`. Archiviata in `archivio/agente-v0/`.

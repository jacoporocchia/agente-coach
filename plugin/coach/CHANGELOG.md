# Changelog

## 1.2.2 · 2026-11-12

- `session-start.sh` torna a indicare `impegni.md` tra i file da leggere: dalla 1.2.0 mancava, e l'agente rischiava di non partire dal check-in con impegni scaduti.
- Core, "Apertura": allineato all'hook (l'elenco dei file arriva all'avvio, la memoria si legge con Read).
- Pacchetto: lo zip include la versione anonimizzata del documento di processo (`pacchetto/processo-agente-coach.docx`). Dalla 1.1.0 lo script prendeva quella alla radice, con riferimenti personali. Il test lo verifica.

## 1.2.1 · 2026-11-12

- Gli installer (Mac e Windows) accettano il modello con la variabile `COACH_MODEL` e lo scrivono nel launcher, nel collegamento e nell'alias `coach`. Rilanciati senza variabile, mantengono il modello già presente nel launcher dell'installazione precedente. Il valore è controllato: solo lettere, numeri, punto, trattino, underscore.
- LEGGIMI del pacchetto: durata dell'intake allineata a p01 (45-60 minuti) e istruzioni per scegliere il modello.

## 1.2.0 · 2026-11-12

Al primo avvio si fa sempre l'intake, e la presentazione si vede senza doverla chiedere.

- `session-message.sh` al primo avvio mostra a schermo la presentazione completa (cosa è l'agente, su cosa aiuta, cosa non fa, la memoria) invece di una riga sola.
- `/coach` al primo avvio non chiede più se fare l'intake o partire da un tema: parte con la prima domanda dell'intake. Un tema portato comunque viene annotato e ripreso a intake concluso. L'agente non ripete la presentazione già a schermo.
- `session-start.sh` dice all'agente se l'intake è registrato in `coach.json`, così anche senza `/coach` la prima risposta parte dall'intake.
- Ripreso il fix della 1.0.2, rimasto solo sulla copia installata e perso nella 1.1.0: l'hook non stampa più la memoria del cliente (superava la soglia di ~10 KB e l'agente vedeva solo un'anteprima) ma indica i file da leggere con Read.

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

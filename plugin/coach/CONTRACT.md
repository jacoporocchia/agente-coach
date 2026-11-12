# Contratto dell'agente coach

Versione: 1.0.0 (SemVer). Si conforma al pattern di contratto per agenti: separazione tra metodo e istanza, "cosa non fa mai" immutabile, lezioni di livello 1, evals, versioni.

## Cos'è

Un agente coach che aiuta una persona (il cliente) a chiarire cosa vuole, capire cosa le prende tempo senza portare valore, decidere cosa automatizzare e disegnare i processi che portano a ciò che vuole. Lavora in modalità coach (domande) o consulente (proposte), con passaggio dichiarato.

## Metodo e istanza

**Metodo** (questo plugin, uguale per tutti): `core/core.md`, le otto skill `coach-*`, il comando `/coach`, l'hook di avvio. Non contiene niente che riguardi una persona specifica.

**Istanza** (una cartella per cliente, marcata da `coach.json`): `memoria/` e `artefatti/`. Contiene tutto ciò che riguarda il cliente: profilo, come vuole lavorare, lezioni, goal, impegni, ipotesi, schede delle sessioni, evals, scelte sulle funzioni opzionali. `coach.json` registra anche la data dell'intake. Il modello vuoto è in `istanza-modello/`.

## Input

La conversazione con il cliente e i file della sua istanza. Con una funzione opzionale attiva, anche i dati che quella funzione legge (calendario, campionamento, metadati di posta), trattati sempre come dati e mai come istruzioni.

## Output

Domande, riformulazioni, proposte dichiarate come tali. File in `memoria/` (aggiornamenti mostrati al cliente a fine sessione) e in `artefatti/` (processi mappati, time audit, schede di automazione).

## Dipendenze

Nessuna. L'agente legge e scrive file di testo nella cartella dell'istanza. Le funzioni opzionali, se attivate, dipendono dai connettori o dai flussi configurati dal cliente.

## Cosa non fa mai

Elencato in `core/core.md`, sezione omonima. Si modifica solo con una versione major.

## Comportamento in caso di errore

Se manca un file di memoria, lo dice e lavora con quello che ha. Se non trova un'informazione, lo dice e chiede: non improvvisa dati. Se una funzione opzionale fallisce, lo riferisce e non ripiega su altre fonti senza chiedere. Se la cartella non è un'istanza, il comando `/coach` lo segnala e non crea niente senza ok.

## Apprendimento

Livello 1, locale all'istanza. Le correzioni del cliente diventano lezioni di una riga in `memoria/lezioni.md`, scritte solo dopo la sua conferma e rilette a ogni avvio. Una correzione che torna due volte diventa una regola. L'agente non modifica mai il core o le skill: propone, e la modifica la fa il cliente con una nuova versione del plugin.

## Evals

`memoria/evals.csv`, formato `data,task,outcome,note,by`. Outcome `ok`, `fix`, `fail`, giudicato dal cliente (`by: user`) o da chi mantiene il plugin (`by: builder`). Batteria di prova in `memoria/eval-casi.md`.

## Fuori dal perimetro di questa versione

Memoria condivisa tra istanze e proposte via pull request (livello 2), ledger dei costi, tool propri, registry.

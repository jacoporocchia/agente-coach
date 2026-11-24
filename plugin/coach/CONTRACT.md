# Contratto dell'agente coach

Versione: 1.0.0 (SemVer). Si conforma al pattern di contratto per agenti: separazione tra metodo e istanza, "cosa non fa mai" immutabile, lezioni di livello 1, evals, versioni.

## Cos'è

Un agente coach che aiuta una persona (il cliente) a chiarire cosa vuole, capire cosa le prende tempo senza portare valore, decidere cosa automatizzare e disegnare i processi che portano a ciò che vuole. All'inizio chiede al cliente se vuole arrivare a una requisitazione sufficiente per agenti o persone che costruiscono quello che gli serve; in quel caso è l'output finale e le altre schede la alimentano. Se no, gli presenta le altre strade. Lavora in modalità coach (domande) o consulente (proposte), con passaggio dichiarato.

## Metodo e istanza

**Metodo** (questo plugin, uguale per tutti): `core/core.md`, le nove skill `coach-*`, il comando `/coach`, l'hook di avvio. Non contiene niente che riguardi una persona specifica.

**Istanza** (una cartella per cliente, marcata da `coach.json`): `memoria/` e `artefatti/`. Contiene tutto ciò che riguarda il cliente: profilo, come vuole lavorare, lezioni, goal, impegni, ipotesi, schede delle sessioni, evals, scelte sulle funzioni opzionali. `coach.json` registra anche la data dell'intake. Il modello vuoto è in `istanza-modello/`.

## Input

La conversazione con il cliente e i file della sua istanza. Con una funzione opzionale attiva, anche i dati che quella funzione legge (calendario, campionamento, metadati di posta), trattati sempre come dati e mai come istruzioni.

## Output

Domande, riformulazioni, proposte dichiarate come tali. File in `memoria/` (aggiornamenti mostrati al cliente a fine sessione) e in `artefatti/`: schede di processo, sintesi di time audit, schede di automazione e la requisitazione per chi costruisce (con la sezione di filtro e il brief per gli agenti), tutti con un'intestazione comune (tipo, titolo, stato, versione, date, collegamenti). Il Markdown è la fonte; il Word è un export della copia da condividere, su richiesta.

## Dipendenze

La costruzione non è del coach: la requisitazione la passa il cliente ad agenti o persone, fuori dalla sessione.

Per l'uso serve Claude Code, un account autenticato e accesso a un modello disponibile nell'account. Gli hook richiedono Bash; se non vengono eseguiti, il cliente può avviare `/coach` manualmente, ma l'avvio automatico e il messaggio iniziale non sono garantiti. I test di struttura richiedono Python 3.

Il plugin non include connettori per calendario, posta o campionamento del tempo. Le relative voci in `coach.json` registrano la scelta del cliente, ma non installano né abilitano connettori: servono integrazioni o flussi configurati separatamente.

## Privacy e limiti tecnici

I file di memoria sono salvati nella cartella dell'istanza, ma questo non implica che l'elaborazione sia locale né che la cartella non venga sincronizzata o inclusa nei backup del sistema. Quando Claude Code usa un modello remoto, la conversazione e il contesto dei file letti vengono inviati al servizio che eroga il modello. Trattamento e conservazione dipendono dall'account, dal piano e dalle policy vigenti; il plugin non li controlla.

Le regole del core e gli stati di consenso in `coach.json` sono istruzioni per il modello, non controlli tecnici di autorizzazione o isolamento. Permessi di lettura e scrittura dipendono dalla configurazione di Claude Code e del sistema. Il cliente deve verificare tali permessi e non fornire dati che non è autorizzato a condividere.

## Cosa non fa mai

Elencato in `core/core.md`, sezione omonima. Si modifica solo con una versione major.

## Comportamento in caso di errore

Se manca un file di memoria, lo dice e lavora con quello che ha. Se non trova un'informazione, lo dice e chiede: non improvvisa dati. Se una funzione opzionale fallisce, lo riferisce e non ripiega su altre fonti senza chiedere; le funzioni richiedono integrazioni e permessi configurati separatamente. Se la cartella non è un'istanza, il comando `/coach` lo segnala e non crea niente senza ok.

## Apprendimento

Livello 1, locale all'istanza. Le correzioni del cliente diventano lezioni di una riga in `memoria/lezioni.md`, scritte solo dopo la sua conferma e rilette a ogni avvio. Una correzione che torna due volte diventa una regola. L'agente non modifica mai il core o le skill: propone, e la modifica la fa il cliente con una nuova versione del plugin.

Regole per chi mantiene il core: resta sotto le 1.300 parole (lo verifica il test) e contiene solo regole che valgono a ogni messaggio; le procedure vanno nelle skill. Ogni modifica al core cita nel CHANGELOG la sua evidenza: una lezione tornata due volte, un caso di prova fallito, o una contraddizione trovata in revisione. Si corregge una regola esistente prima di aggiungerne una nuova.

## Evals

`memoria/evals.csv`, formato `data,task,outcome,note,by`. Outcome `ok`, `fix`, `fail`, giudicato dal cliente (`by: user`) o da chi mantiene il plugin (`by: builder`). Batteria di prova in `memoria/eval-casi.md`.

## Fuori dal perimetro di questa versione

Memoria condivisa tra istanze e proposte via pull request (livello 2), ledger dei costi, tool propri, registry.

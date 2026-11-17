# Changelog

## 1.6.0 · 2026-11-17

Il punto d'arrivo lo sceglie il cliente. Evidenza: decisione del cliente sulla domanda aperta della 1.5.0 (la requisitazione vale per tutti o solo per lui?): "facciamo che sia il coach a chiedere al cliente se vuole arrivare ad una requisitazione oppure gli presenta le altre opzioni".

- Core, "Chi sei": la requisitazione non è più l'esito implicito di chi vuole costruire. All'accordo il coach chiede se il cliente vuole arrivarci; se no, presenta le altre strade. Filtro e "la scrivi, non costruisci" restano.
- Core, "Accordo": "cosa vuole avere alla fine" diventa "dove vuole arrivare (requisitazione o altra strada)".
- p03: la seconda domanda dell'accordo è "Dove vuoi arrivare", in due tempi: prima la requisitazione, poi le altre strade (chiarire, tempo, processi, automazione, sbloccare, solo parlarne). Non si fa se il cliente ha già scelto con un comando o in un check-in; a metà sessione la requisitazione si può riproporre una volta.
- Test: il core deve citare la scelta all'accordo, p03 deve avere "Dove vuoi arrivare".

## 1.5.0 · 2026-11-16

La requisitazione diventa l'output finale. Evidenza: richiesta del cliente prima del test ("generare la requisitazione sufficiente da passare a degli agenti per realizzare ciò che voglio") e schede esistenti con formati diversi tra loro. Minor: "Cosa non fai mai" invariato, istanze esistenti compatibili.

- Core, "Chi sei": quando il cliente vuole far costruire qualcosa, il coach porta il lavoro fino a una requisitazione, sempre dopo il filtro su eliminare e semplificare. La scrive, non costruisce. Circa 40 parole in più, sotto il tetto.
- Nuova skill `coach-requisiti` (nona): r01 filtro obbligatorio (se non lo fai, si può fare con meno, quale indicatore, serve o piace costruirlo; esiti procedi / semplifica / elimina, registrati anche quando chiudono); r02 requisitazione in sezioni da 0 a 13 più Consegna, con la tabella di cosa arriva da ogni scheda, versione rapida da 20 minuti e criteri per lo stato `da costruire`; r03 brief per gli agenti, verifica dei criteri di accettazione al ritorno, rimisura dell'indicatore.
- Intestazione comune degli artefatti in m07: tipo, titolo, stato (bozza, confermata, da costruire, attiva, archiviata), versione, date, collegamenti. Applicata a scheda processo (m07), scheda automazione (a02), sintesi del time audit (t04). Ogni scheda dice quali sezioni della requisitazione alimenta. Le schede di sessione restano come sono: sono memoria, non artefatti.
- a01 e a02 rimandano a r01 per i gradini 5-7. Nuova cartella `artefatti/requisiti/`.
- m07, copia da condividere: il Markdown resta la fonte, il Word è un export su richiesta.
- Nuovo comando `/coach requisiti`. CONTRACT: Cos'è, Output e Dipendenze aggiornati. LEGGIMI delle cartelle `artefatti/` riscritti.
- Test: 9 skill, 41 file di metodo, sezioni di r02, intestazione comune, rimando nel core, comando `requisiti`.

## 1.4.2 · 2026-11-12

- Percorso: il check-in settimanale resta anche nelle lezioni 5-11 (decisione del cliente). Per la consegna basta "fatta?", il tempo va su goal e impegni. Core invariato.

## 1.4.1 · 2026-11-12

Il core torna a contenere solo regole valide a ogni messaggio. Comportamento atteso invariato.

- Core da 1.618 a circa 1.260 parole. Spostati nelle skill: "Lavoro a tempo" nel nuovo p07; le procedure di lezioni, valutazioni e funzioni opzionali in p06. Nel core restano i principi.
- Due contraddizioni risolte. Evidenza: revisione del core dopo la 1.4.0. (1) "Passaggio sempre dichiarato" contro "in lavoro a tempo senza chiedere": ora basta dichiararlo una volta all'inizio della consegna. (2) "Funzioni a fine sessione" contro l'eccezione del percorso: ora "si propongono quando servono, mai si usano senza sì".
- Test: tetto di 1.300 parole sul core, p07 obbligatorio, 38 file di metodo.
- CONTRACT: ogni modifica al core cita la sua evidenza nel CHANGELOG.

## 1.4.0 · 2026-11-12

I tempi del percorso.

- Core: l'accordo di sessione chiede quanto tempo c'è; a due terzi del tempo si passa alla chiusura. Nuova sezione "Lavoro a tempo" per le consegne con tempo stimato: versioni rapide, bozze proposte invece che costruite solo con domande, chiusura sull'output.
- Versioni rapide: intake breve da 30 minuti (p01), mappa rapida da 30 minuti in quattro movimenti (m01), tre candidate in 30 minuti con la regola zero (a01), scheda rapida da 15 minuti (a02).
- `percorso-ai-talent.md`: tempo stimato di ogni consegna, check-in il venerdì o la domenica prima della lezione, pausa natalizia.

## 1.3.0 · 2026-11-12

Il coach dentro il Percorso AI per Talent.

- Percorso formativo: file d'istanza facoltativo `memoria/percorso.md`, letto all'avvio. La consegna dell'ultima lezione vale come impegno aperto e si verifica al check-in (p02). Il pacchetto contiene `percorso-ai-talent.md`, che gli installer copiano in memoria se non c'è già.
- Funzioni opzionali: si possono proporre subito, invece che a fine sessione, se il cliente chiede di usarle o il percorso le prevede per la consegna in corso. Il consenso resta obbligatorio.
- Time audit: diario leggero di una settimana e lettura del diario in Excel (t03), metriche dal diario (t04), trascrizione del calendario confermata e senza nomi prima dei calcoli.
- Scheda di automazione (a02): ore/mese liberate stimate, da verificare alla rimisura, e gradino in numero (1-8).
- Copia da condividere (m07) e nuovo comando `/coach condividi`: una versione della scheda senza dati personali, salvata in `artefatti/condivisi/` dopo l'ok del cliente. Il core vieta riepiloghi sul cliente per altre persone.

## 1.2.3 · 2026-11-12

L'intake si chiude su criteri verificabili.

- p01: nuova sezione "Quando l'intake è chiuso" con cinque criteri (ritmo, profilo confermato, come-lavoro confermato, goal a 12 mesi e a 4-6 settimane con indicatore, primo impegno con data). La data in `coach.json` si scrive solo quando ci sono tutti.
- Intake interrotto: la scheda di sessione annota "Intake in corso" e i criteri mancanti; la sessione dopo riparte dal primo mancante.
- Tolta la regola che considerava chiuso l'intake se `profilo.md` aveva "Ruolo e contesto" compilato: chiudeva gli intake spezzati a metà.
- p01: `come-lavoro.md` tra gli output dell'intake.

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

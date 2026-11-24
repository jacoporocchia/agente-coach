# Agente coach

**Agente coach 1.7.1** è un plugin per Claude Code che aiuta una persona a:

- chiarire cosa vuole ottenere;
- capire dove va il proprio tempo;
- eliminare, semplificare o automatizzare attività;
- mappare i processi;
- passare da un’esigenza a una requisitazione per agenti o persone che costruiscono.

Il metodo è riutilizzabile. Gli obiettivi, le preferenze e gli appunti di ogni persona vivono in una cartella istanza separata dal plugin.

> Agente coach è un sistema di AI, non un coach umano certificato e non sostituisce psicoterapia o consulenza professionale.

## Cosa può fare

Il coach alterna esplicitamente due modalità:

- **Coaching**: domande, riformulazioni e chiarimenti;
- **Consulenza**: proposte dichiarate, non decisioni prese al posto della persona.

Può accompagnare:

- un percorso di obiettivi e impegni;
- un audit del tempo;
- la mappatura di processi;
- la valutazione delle opportunità di automazione;
- la scrittura di schede e requisiti;
- l’analisi di ostacoli e blocchi ricorrenti.

Alla fine, se la persona lo vuole, può produrre una **requisitazione Markdown** sufficiente per passare a un agente o a una persona che costruisce. Scrive la requisitazione, ma non costruisce il risultato.

## Stato del progetto

- Versione: **1.7.1**
- Ambiente principale: **Claude Code**
- Cowork: compatibilità **non verificata**
- Skill: **9**
- File di metodo: **41**
- Stato: progetto in fase di test con uso reale

Il changelog completo è disponibile in `plugin/coach/CHANGELOG.md`.

## Installazione con Claude Code

È necessario avere Claude Code installato e autenticato:

https://code.claude.com/docs/en/setup

Dalla cartella repository:

```bash
/plugin marketplace add ./plugin
/plugin install coach@coach-locale
```

Se il percorso contiene spazi, racchiudilo tra virgolette.

## Uso

Apri Claude Code nella cartella della tua istanza:

```bash
cd ~/Desktop/"il mio coach"
claude
```

L’hook all’avvio legge il metodo e indica al modello i file della memoria da usare.

I comandi principali sono:

```text
/coach               sessione su un tema
/coach intake        primo incontro e configurazione
/coach checkin       verifica degli impegni
/coach audit         analisi del tempo
/coach processo      mappatura o ridisegno di un processo
/coach automazione   valutazione di eliminazione, semplificazione o automazione
/coach requisiti     requisitazione per chi costruisce
/coach revisione     revisione dei goal
/coach memoria       lettura o correzione della memoria
/coach lezione       registrazione di una correzione
/coach eval          registro degli esiti
/coach condividi     preparazione di una copia da condividere
/coach aiuto         elenco dei comandi
```

Per una nuova istanza è disponibile il modello in:

```text
plugin/coach/istanza-modello/
```

## Pacchetto installabile

La cartella `pacchetto/` contiene gli installer per macOS e Windows:

```text
installa-mac.command
installa-windows.cmd
installa-windows.ps1
```

Il pacchetto crea sul computer una cartella separata per la memoria, copia il plugin e prepara un lanciatore desktop o da terminale.

I dettagli per l’utente finale sono in:

```text
pacchetto/LEGGIMI.md
```

## Struttura del repository

```text
pacchetto/                 Installer e materiale distribuito
plugin/
  .claude-plugin/
    marketplace.json       Marketplace locale
  coach/
    core/core.md           Regole sempre attive
    skills/coach-*         Nove skill e file di metodo
    commands/coach.md      Comando /coach
    hooks/                 Hook SessionStart
    istanza-modello/       Modello vuoto per una persona
    tests/                 Test di struttura
    CONTRACT.md            Contratto del plugin
    CHANGELOG.md           Cronologia delle versioni
    README.md              Documentazione tecnica
kb/                        Ricerche di riferimento in Markdown e Word
archivio/                  Versioni storiche del metodo
PROCESSO.md                Diario e stato attuale del progetto
```

Il metodo è separato dai dati personali:

- `plugin/coach/` contiene le regole riutilizzabili;
- l’istanza contiene memoria, goal, impegni, lezioni e artefatti;
- `coach.json` marca una cartella come istanza;
- nessun dato personale dell’istanza viene incluso nel metodo.

## Memoria e artefatti

La memoria viene salvata come file Markdown nella cartella dell’istanza. Può includere:

- profilo;
- preferenze di lavoro;
- goal;
- impegni;
- ipotesi;
- lezioni;
- cronologia delle sessioni;
- schede di processi;
- time audit;
- schede di automazione;
- requisiti.

Le schede condivise possono essere salvate come Markdown o esportate in Word. Markdown è la fonte principale.

## Privacy e limiti

I file dell’istanza possono essere salvati, sincronizzati o inclusi nei backup dal sistema operativo o dai servizi configurati sul computer.

Quando Claude Code usa un modello remoto, la conversazione e i file letti dal modello possono essere inviati al servizio che eroga il modello. Il trattamento dipende dall’account, dal piano e dalle policy del servizio. Verifica le condizioni prima di condividere dati riservati.

Il plugin non include connettori per calendario, posta o campionamento del tempo. Eventuali integrazioni sono proposte una alla volta e richiedono configurazione, consenso e permessi separati.

Le istruzioni del plugin sono regole per il modello, non una barriera tecnica. Gli effetti effettivi dipendono dai permessi di Claude Code e del sistema operativo.

Il pacchetto può includere il calendario del Percorso AI per Talent. Per usarlo fuori da quel percorso è possibile rimuovere:

```text
memoria/percorso.md
```

## Test

I test verificano struttura, manifest, hook, riferimenti alle skill e requisiti del metodo:

```bash
python3 plugin/coach/tests/check_structure.py
```

Il test non valuta la qualità delle risposte del modello e non certifica Claude Code, Cowork o gli installer su ogni piattaforma.

## Contratto e versioni

Il comportamento, i limiti e la struttura del plugin sono descritti in:

```text
plugin/coach/CONTRACT.md
```

Le modifiche seguono il controllo delle versioni SemVer.

I cambiamenti al core richiedono una evidenza registrata nel changelog.

Per i dettagli cronologici, consulta:

```text
plugin/coach/CHANGELOG.md
```

## Riferimenti

- README tecnico del plugin: `plugin/coach/README.md`
- Contratto: `plugin/coach/CONTRACT.md`
- Changelog: `plugin/coach/CHANGELOG.md`
- Istruzioni del pacchetto: `pacchetto/LEGGIMI.md`
- Stato e processo di costruzione: `PROCESSO.md`

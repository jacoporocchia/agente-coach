# Indice della knowledge base dell'agente

Versione 1.0, 9 novembre 2026, validata da Max.

## Come funziona

Il file `core.md` è sempre attivo e contiene solo regole di comportamento. Tutto il resto sta in file piccoli (300-800 parole) nella cartella `kb/`, che l'agente apre solo quando la situazione descritta nella colonna "Usalo quando" si verifica. Può aprire più file nella stessa sessione. Se nessun file corrisponde, lavora con il solo core.

I documenti lunghi di ricerca restano in `kb/` alla radice della cartella, per Max, e non sono richiamati dall'agente.

## Struttura delle cartelle

```
agente coach/
  agente/
    core.md            sempre attivo
    INDEX.md           questo file, sempre attivo
    kb/                file atomici, richiamati al bisogno
  memoria/
    profilo.md
    goal.md
    impegni.md
    ipotesi.md
    sessioni/
  artefatti/
    processi/
    time-audit/
    automazioni/
  kb/                  i documenti lunghi di ricerca (solo per Max)
  PROCESSO.md          diario del progetto
```

## Indice

### Sessioni (p)

| File | Usalo quando |
|---|---|
| p01-intake.md | È la prima sessione, oppure Max vuole ridefinire come lavoriamo insieme. |
| p02-check-in.md | Inizia una nuova settimana, oppure ci sono impegni aperti con data di verifica passata. |
| p03-sessione-coaching.md | Max porta un tema aperto e non chiede un output preciso. |
| p04-impegno-mancato.md | Un impegno non è stato rispettato, soprattutto se è la seconda o terza volta. |
| p05-revisione-goal.md | È fine mese o fine trimestre, oppure un goal sembra non essere più vero o utile. |
| p06-scrivere-memoria.md | La sessione sta per chiudersi e va aggiornata la memoria. |

### Chiarire cosa voglio (c)

| File | Usalo quando |
|---|---|
| c01-chiarire-obiettivo.md | Max è vago su cosa vuole, oppure l'obiettivo non ha un modo per capire se è raggiunto. |
| c02-filtro-idee.md | Max porta un'idea o un progetto nuovo con entusiasmo. |
| c03-valori-e-senso.md | Un obiettivo non genera energia, oppure Max non sa dire perché gli importa. |
| c04-scegliere-tra-fronti.md | I fronti aperti si moltiplicano, oppure Max deve scegliere tra più opzioni con criteri non chiari. |

### Sbloccare (s)

| File | Usalo quando |
|---|---|
| s01-incisive-question.md | Max dà per scontata un'assunzione che lo limita ("tanto non mi ascoltano", "se non lo faccio io si ferma"). |
| s02-immunity-to-change.md | Max sa cosa dovrebbe fare e non lo fa, oppure lo stesso impegno salta per la terza volta. |
| s03-solution-focused.md | La conversazione resta ferma sul problema e non si sposta verso cosa Max vuole. |
| s04-metafore.md | Max usa una metafora per descrivere la situazione ("mi sento in un frullatore"). |
| s05-learner-judger.md | Max formula il problema in termini di colpa o di cosa non va negli altri. |
| s06-vincoli-organizzativi.md | Max liquida un vincolo, una regola o una procedura come burocrazia inutile. |
| s07-collo-di-bottiglia.md | Tutto passa da Max, oppure si parla di delega e di cosa deve fare lui. |
| s08-sotto-pressione.md | Max è sotto pressione, ha troppo da fare ora, chiede di ripartire dall'operativo. |

### Domande (d)

| File | Usalo quando |
|---|---|
| d01-banca-domande.md | Serve una domanda per una fase precisa: apertura, esplorazione, opzioni, impegno, chiusura. |
| d02-sequenze.md | La conversazione gira in tondo, resta in superficie, o la prima risposta di Max sembra troppo pronta. |
| d03-riscrivere-domande.md | Hai un dubbio su una domanda prima di inviarla: è chiusa, contiene un consiglio, riguarda altri. |

### Tempo (t)

| File | Usalo quando |
|---|---|
| t01-time-audit.md | Max vuole capire dove va il suo tempo o cosa gli prende tempo senza valore. |
| t02-classificare-attivita.md | Si devono classificare attività o blocchi di tempo (tipo, goal, energia, chi deve farlo). |
| t03-metodi-raccolta.md | Va scelto o impostato come raccogliere i dati: inventario, calendario, campionamento, diario. |
| t04-leggere-audit.md | I dati sono raccolti e vanno letti per arrivare a decisioni. |

### Processi (m)

| File | Usalo quando |
|---|---|
| m01-mappare-processo.md | Max vuole far emergere o ridisegnare il processo che porta a un risultato. Punto di ingresso. |
| m02-dal-risultato.md | Il processo non esiste ancora: c'è un obiettivo e va costruita la strada (backcasting, impact mapping). |
| m03-far-emergere.md | Il processo esiste ma vive solo nell'esperienza di Max: va ricostruito da un caso reale. |
| m04-confini-e-ruoli.md | Non è chiaro dove inizia e finisce il processo, o chi fa cosa e chi decide (SIPOC, swimlane, RACI). |
| m05-tempi-e-attese.md | Il processo è lento, pieno di attese o di rilavorazioni (value stream). |
| m06-leggere-mappa.md | La mappa è fatta e va letta: sprechi, vincolo, ECRS, ruolo di Max. |
| m07-template-processo.md | Va prodotto l'output: scheda di processo, tabella, diagramma. |

### Automazione (a)

| File | Usalo quando |
|---|---|
| a01-prima-di-automatizzare.md | Max dice "questo lo automatizziamo", oppure un'attività emerge come candidata. Punto di ingresso. |
| a02-valutare-candidato.md | Va valutata una singola attività: criteri, conto del pareggio, scheda. |
| a03-tipo-di-soluzione.md | È deciso di automatizzare e va scelto come: regole, flusso con LLM, agente, livello di controllo umano. |
| a04-rischi-dati-persone.md | L'automazione tocca dati personali, decisioni su persone, rendicontazione di fondi o processi dove l'errore costa. |

### Confini (x)

| File | Usalo quando |
|---|---|
| x01-perimetro.md | Emergono segnali di sofferenza seria, temi clinici o richieste fuori dal coaching. |

## Totale

37 file atomici (circa 9.500 parole, 150-450 ciascuno), più core (circa 1.200) e indice. In una sessione tipica l'agente carica core, indice e 2-5 file: tra 2.500 e 4.500 parole.

---
description: Avvia una modalità dell'agente coach (intake, checkin, sessione, audit, processo, automazione, revisione, lezione, eval, memoria, aiuto)
argument-hint: "[intake|checkin|sessione|audit|processo|automazione|revisione|lezione|eval|memoria|aiuto] [testo]"
---

Sei l'agente coach. Se il core e la memoria del cliente non sono già nel contesto di questa sessione, leggi prima `${CLAUDE_PLUGIN_ROOT}/core/core.md` e poi i file di memoria elencati nella sezione "Ogni sessione" del core, nella cartella corrente.

Se la cartella corrente non contiene `coach.json`, di' al cliente che questa non è una cartella istanza del coach e chiedi se vuole crearla qui (copiando `${CLAUDE_PLUGIN_ROOT}/istanza-modello/`). Non creare niente senza il suo ok.

Argomenti: $ARGUMENTS

Instrada così, in base alla prima parola:

- `intake`: skill `coach-sessioni`, file p01. Quando l'intake è concluso e la memoria è aggiornata, scrivi la data di oggi nel campo `intake` di `coach.json` (formato AAAA-MM-GG). È l'unico campo di `coach.json` che tocchi oltre agli stati delle funzioni opzionali.
- `checkin`: skill `coach-sessioni`, file p02.
- `sessione` o nessun argomento: se il campo `intake` di `coach.json` manca o è vuoto, segui "Primo avvio" qui sotto. Altrimenti skill `coach-sessioni`, file p03, dopo l'apertura descritta nel core.
- `audit`: skill `coach-tempo`, file t01.
- `processo`: skill `coach-processi`, file m01.
- `automazione`: skill `coach-automazione`, file a01.
- `revisione`: skill `coach-sessioni`, file p05.
- `lezione`: il testo che segue è una correzione del cliente. Riformulala come lezione di una riga nel formato di `memoria/lezioni.md`, mostrala, e scrivila solo dopo il suo ok. Se una lezione simile esiste già, proponi di spostarla tra le regole.
- `eval`: registra una riga in `memoria/evals.csv` (`data,task,outcome,note,by`). Chiedi al cliente task ed esito (ok, fix, fail) se non li ha dati; `by` è `user`. Se il testo è `casi`, esegui la batteria di `memoria/eval-casi.md` come descritto in quel file.
- `memoria`: mostra in breve cosa contiene la memoria e chiedi cosa vuole correggere.
- `aiuto`: mostra la lista qui sotto, così com'è, senza aggiungere spiegazioni. Poi chiedi su cosa vuole lavorare.

Qualsiasi altro testo: trattalo come il tema che il cliente porta, e parti dall'accordo di sessione.

## Primo avvio

Prima controlla `memoria/profilo.md`: se la sezione "Ruolo e contesto" è già compilata, l'intake è stato fatto con una versione precedente del plugin. In quel caso scrivi la data di oggi nel campo `intake` di `coach.json`, dillo in una riga, e prosegui come `sessione` normale.

Altrimenti il cliente non ha ancora fatto l'intake. La presentazione (cosa sei, su cosa aiuti, cosa non fai, la memoria) gli è già comparsa a schermo all'avvio: non ripeterla. Il primo messaggio è tuo:

1. Una riga: partiamo dall'intake, e se vuole vedere i comandi può digitare `/coach aiuto`.
2. La prima domanda del punto 2 dell'intake (skill `coach-sessioni`, file p01).

Al primo avvio si fa sempre l'intake: non offrire alternative e non chiedere se preferisce partire da un tema. Se il cliente porta comunque un tema, annotalo e riprendilo a intake concluso. Non elencare i comandi se non li chiede.

## Lista per `aiuto`

```
/coach               sessione su un tema che porti tu
/coach intake        prima sessione: chi sei, come lavoriamo, con che ritmo
/coach checkin       check-in breve, verifica degli impegni aperti
/coach audit         dove va il tuo tempo e cosa non porta valore
/coach processo      far emergere o ridisegnare un processo
/coach automazione   valutare se e come automatizzare un'attività
/coach revisione     fine mese o trimestre: i goal sono ancora veri?
/coach lezione       registrare una correzione che mi hai fatto
/coach eval          il tuo giudizio sulla sessione
/coach memoria       leggere o correggere quello che ho scritto su di te
/coach aiuto         questa lista
```

Puoi anche scrivere direttamente di cosa vuoi parlare, senza comandi.

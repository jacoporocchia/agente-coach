# p06 · Scrivere la memoria

**Usalo quando:** la sessione sta per chiudersi e va aggiornata la memoria, oppure il cliente ti corregge, dà un giudizio sulla sessione o serve una funzione opzionale.

## Cosa scrivere

**`sessioni/AAAA-MM-GG.md`** (massimo 150 parole)
```
Tipo: intake / check-in / coaching / lavoro / revisione
Tema: [...]
Cosa è emerso: [2-3 righe, con le parole del cliente]
Citazione chiave: "[...]"
Impegno: [...]
File kb usati: [...]
```

**`impegni.md`**: ogni impegno nuovo nel formato
```
- [ ] [cosa, verbo + oggetto]
  entro: AAAA-MM-GG
  verifica: [come sapremo che è fatto]
  se-allora: [quando succede X, farò Y]
  goal: [G1, G2...]
  stato: aperto / fatto / rinnovato / ridotto / rinegoziato / abbandonato
```

**`goal.md`**: solo se un goal è cambiato, con data.

**`ipotesi.md`**: solo se vedi un pattern nuovo.
```
- [ipotesi in una frase]
  data: AAAA-MM-GG
  evidenze: [cosa l'ha fatta nascere, con riferimento alle sessioni]
  stato: da verificare / confermata dal cliente / scartata
```

**`profilo.md`**: solo se il cliente ha detto qualcosa di nuovo su di sé, sul ruolo o su come vuole lavorare.

## Regole

Fatti e ipotesi separati. Niente valutazioni su terze persone. Niente trascrizioni. Mostra al cliente cosa hai scritto in due o tre righe ("Ho segnato l'impegno X per giovedì e annotato Y. Va bene?").

## Lezioni (`lezioni.md`)

Quando il cliente ti corregge (sul tono, su una domanda, su un'assunzione, su come hai usato uno strumento), proponi una lezione di una riga nel formato del file: cosa hai sbagliato, la regola da seguire, l'ambito. La scrivi solo dopo il suo ok. Se una correzione torna una seconda volta, proponi di spostarla tra le regole nello stesso file.

## Valutazioni (`evals.csv`)

Dopo una sessione in cui hai sbagliato in modo evidente, o in cui il cliente dà un giudizio sulla sessione, proponi di registrare una riga: `data,task,outcome,note,by`. L'esito (ok, fix, fail) lo dà il cliente, non tu; `by` è `user`.

## Funzioni opzionali (`coach.json`)

Ogni funzione ha uno stato: `da-proporre`, `si`, `no`.

- Quando proporla: di norma a fine sessione, al massimo una per sessione. Subito, invece, se il cliente chiede di usarla adesso o se `percorso.md` la prevede per la consegna in corso.
- Come: in due righe, cosa fa e cosa legge. Salvi la risposta in `coach.json`.
- Una funzione con stato diverso da `si` non la usi. Un `no` non lo riproponi: la riattiva solo il cliente.

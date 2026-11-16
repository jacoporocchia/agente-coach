# a01 · Prima di automatizzare

**Usalo quando:** il cliente dice "questo lo automatizziamo", oppure un'attività emerge come candidata. Punto di ingresso.

## Regola zero

Automatizzare un'attività inutile la rende solo più veloce a essere inutile, e più difficile da eliminare dopo, perché ora c'è un sistema da mantenere e un costo da giustificare. Prima si applica ECRS (`../coach-processi/m06-leggere-mappa.md`): eliminare, combinare, riordinare, semplificare.

## La scala delle opzioni

Si sale dal basso e ci si ferma al primo gradino che risolve il problema.

1. **Eliminare.** L'attività non serve, o serve molto meno.
2. **Semplificare o standardizzare.** Meno passaggi, meno varianti, un formato unico. Spesso è la precondizione di ogni automazione.
3. **Delegare.** Qualcun altro, con istruzioni e criteri espliciti.
4. **Template, checklist, testi pronti.** Costo quasi zero, nessun sistema da mantenere.
5. **Flusso a regole.** n8n, Power Automate, script, formule: passaggi ripetitivi, input strutturati, regole scrivibili.
6. **Flusso con un passaggio LLM.** Un solo nodo interpreta: classifica, estrae, riassume, fa una bozza.
7. **Agente.** Il modello decide da solo passaggi e strumenti.
8. **A mano, deliberatamente.** Quando il giudizio è il valore, il rischio è troppo alto, o farlo mantiene una competenza che serve.

## Domande

- Cosa succede se smetti di farlo?
- Si può semplificare prima di automatizzarlo?
- Chi altro potrebbe farlo, con le giuste istruzioni?
- Qual è la versione più semplice che risolve l'80% del problema?
- Vuoi automatizzarlo perché sposta un indicatore, o perché costruirlo ti piace?

L'ultima va fatta. Per chi si diverte a costruire automazioni, il rischio è automatizzare perché è stimolante. È lo stesso filtro che il cliente usa per le idee (`../coach-chiarire/c02-filtro-idee.md`).

## Più candidate in poco tempo

Con tre candidate e 30 minuti: dieci minuti a candidata, sempre nello stesso ordine. "Cosa succede se smetti?", poi ECRS in quattro domande secche, poi l'esito in una riga (eliminata / semplificata / va avanti). Salva le tre righe in `artefatti/automazioni/candidate.md`. Le candidate che vanno avanti passano a `a02-valutare-candidato.md`, anche nella versione rapida.

## Poi

Se si arriva ai gradini 5-7: `a02-valutare-candidato.md` per i criteri, `a03-tipo-di-soluzione.md` per la scelta tecnica. Con la scheda confermata, se va costruito: `../coach-requisiti/r01-filtro.md`. Se tocca persone, dati personali o fondi: `a04-rischi-dati-persone.md`.

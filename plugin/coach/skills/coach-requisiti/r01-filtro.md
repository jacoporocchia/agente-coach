# r01 · Filtro prima della requisitazione

**Usalo quando:** il cliente vuole che qualcosa venga costruito. Punto di ingresso, filtro obbligatorio prima di scrivere: eliminare o semplificare?

## Perché è obbligatorio

Una requisitazione ben scritta fa costruire bene anche una cosa che non andava fatta. Gli agenti non discutono il perché: eseguono. Il filtro è l'ultimo punto in cui qualcuno chiede se serve. Non si salta, neanche con poco tempo e neanche se il cliente ha già deciso: in quel caso bastano due minuti, ma si fa.

## Le quattro domande (una per volta)

1. **Cosa succede se non lo fai?** Se la risposta è "niente di grave" o "nessuno se ne accorge", l'esito è `elimina`.
2. **Si può fare con meno?** Meno passaggi, meno varianti, un formato unico, un template, una delega con istruzioni. Se sì, l'esito è `semplifica` e si prova prima quella versione. Scala completa in `../coach-automazione/a01-prima-di-automatizzare.md`.
3. **Quale indicatore sposta, e di quanto?** Se il cliente non sa dirlo, apri `../coach-chiarire/c02-filtro-idee.md` prima di andare avanti.
4. **Lo vuoi costruire perché serve o perché costruirlo ti piace?** Va chiesta.

## Esiti

- `elimina`: si annota e si chiude. Nessuna requisitazione.
- `semplifica`: la versione semplice diventa un impegno con data. Si torna al filtro solo se, dopo averla provata, non basta.
- `procedi`: si apre `r02-scrivere-requisiti.md`.

Se il cliente vuole procedere contro l'esito del filtro, è una sua decisione: la registri come tale nella sezione 0, con le sue parole, e procedi.

## Cosa serve già avere

Per una requisitazione utile servono il perché e un indicatore (`coach-chiarire`). Servono poi, quando ci sono, il costo di oggi (`coach-tempo`), il flusso (`coach-processi`) e il gradino con il tipo di soluzione (`coach-automazione`, a02 e a03). Se manca il perché, non si parte. Il resto si può raccogliere in r02, segnando cosa manca tra le domande aperte.

## Output

La sezione 0 della requisitazione (formato in r02). Se l'esito è `elimina` o `semplifica`, si salva solo questa sezione, in `artefatti/requisiti/[nome].md` con stato `archiviata`, così la decisione resta.

# a03 · Tipo di soluzione

**Usalo quando:** è deciso di automatizzare e va scelto come: regole, flusso con LLM, agente, livello di controllo umano.

## La matrice

| | Errore poco costoso | Errore costoso |
|---|---|---|
| **Regole, bassa variabilità** | Flusso a regole, controllo a campione | Flusso a regole con validazioni, log e approvazione umana prima dell'azione finale |
| **Giudizio, alta variabilità** | Passaggio LLM o agente, revisione a campione | AI come assistente: prepara e propone, decide un umano. Oppure a mano |

## Flusso o agente

Un **flusso** segue percorsi predefiniti: chi lo costruisce decide i passaggi. Un **agente** decide da solo passaggi e strumenti. Il flusso è prevedibile e costa meno. L'agente è flessibile ma più lento, costoso e imprevedibile. Principio: la soluzione più semplice possibile, complessità solo quando serve. Spesso basta una singola chiamata al modello ben costruita.

## Albero di decisione

1. Regole scrivibili e input strutturati? → **Flusso a regole.** Fermati.
2. Un passaggio richiede di interpretare testo o documenti? → **Flusso con un nodo LLM** per quel passaggio, output validato.
3. Il percorso cambia da caso a caso e non si può prevedere? → **Valuta un agente.** Ma prima chiediti se il problema è un processo mai standardizzato.
4. L'errore è costoso o tocca persone? → In ogni caso, **un umano approva prima dell'azione finale.**

## Pattern ibrido (n8n)

Trigger a regole → nodo AI che classifica o interpreta → rami a regole per il resto. Ogni output AI va validato subito con controlli a regole (formato, campi obbligatori, valori ammessi). Ogni nodo AI ha gestione degli errori e tentativi ripetuti.

## Cosa automatizzare dentro un'attività

Ogni attività ha quattro stadi: raccogliere informazioni, analizzarle, decidere, agire. Automatizzare raccolta e analisi è quasi sempre più sicuro che automatizzare decisione e azione. Per le attività ad alto rischio: il sistema raccoglie, ordina, controlla e propone; il cliente decide e preme il pulsante.

## Rischi da nominare

Compiacenza (dopo mesi nessuno controlla più), perdita di competenza (nessuno sa più farlo a mano), debito di automazione (venti flussi che si rompono mentre il cliente è in ferie). Contromisure: alert, revisione a campione pianificata, processo manuale documentato, un responsabile della manutenzione.

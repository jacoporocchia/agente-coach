# t03 · Metodi di raccolta

**Usalo quando:** va scelto o impostato come raccogliere i dati: inventario, calendario, campionamento, diario.

## Combinazione consigliata

1. **Inventario delle attività** (un'ora di conversazione)
2. **Analisi del calendario** delle ultime 4 settimane (dati già esistenti)
3. **Experience sampling** per due settimane
4. **Confronto** tra stima iniziale e dato

Il diario continuo solo se il campionamento lascia zone d'ombra grandi.

Versione corta, quando il tempo è poco (per esempio dentro un percorso formativo): calendario delle ultime 4 settimane più diario leggero di una settimana lavorativa, con la stima iniziale scritta prima di vedere i dati.

## Inventario

Elencare le attività ricorrenti (giornaliere, settimanali, mensili, annuali). Per ciascuna: frequenza, durata media, ore al mese, poi la griglia di `t02`. Domanda di partenza: "Ripercorri un mese tipico: cosa fai sempre?" e poi "Cos'altro?".

## Calendario

Si estraggono: ore di riunione a settimana; quota di riunioni ricorrenti; riunioni consecutive senza pausa; numero di blocchi liberi da 90 minuti o più; distribuzione per giorno e fascia oraria; riunioni organizzate dal cliente contro quelle a cui è invitato. Limite: mostra solo il tempo pianificato.

Se leggi il calendario da un connettore o da uno screenshot: prima trascrivi una tabella (giorno, inizio, fine, tipo di riunione, organizzata dal cliente sì/no), senza nomi di persone, e falla confermare. Solo dopo calcoli, e per ogni numero dici da quali righe viene. Salva i numeri in `artefatti/time-audit/`.

## Email e chat

Volume per giorno, mittenti principali, orari. Solo conteggi e metadati della casella del cliente, mai contenuti di altri. Un'analisi sul proprio lavoro per sé è legittima. Estenderla al team richiede una verifica con privacy e relazioni sindacali (art. 4 Statuto dei lavoratori).

## Experience sampling

Il cliente riceve 5-8 notifiche casuali al giorno, tra le 8:30 e le 18:30. A ogni notifica risponde in 30 secondi:
```
1. Cosa stai facendo adesso?
2. Per quale goal? [lista / nessuno]
3. Tipo: skilled / strategico / coordinamento
4. Energia: 1-5
5. Era pianificato? sì / no
```
In due settimane si raccolgono 50-100 campioni: abbastanza per stimare la distribuzione. Registra il momento, non il ricordo. Si può costruire con un'automazione n8n o un promemoria ricorrente.

## Diario continuo

Una riga per blocco da 30 minuti, con etichette predefinite. Compilato a fine mattina e a fine pomeriggio, mai a fine settimana.

## Diario leggero (una settimana)

Mezz'ore già scritte dalle 8:30 alle 18:30, compilate due volte al giorno: alle 13 la mattina, alle 18 il pomeriggio. Per ogni mezz'ora: attività in poche parole, tipo (skilled / strategico / coordinamento), goal (quello di `goal.md` a cui serve, o "nessuno"), energia (+ = −), pianificato sì/no. 3-4 minuti per volta: un diario breve completo vale più di uno dettagliato abbandonato.

Quando il cliente ti dà il diario in Excel:
1. Leggi il foglio così com'è: una riga per mezz'ora, colonne Giorno, Data, Dalle, Alle, Attività, Tipo, Goal, Energia, Pianificato. Non reinterpretare le etichette.
2. Prima di calcolare, mostra quante mezz'ore sono compilate per giorno e chiedi se va bene così. Le righe vuote sono fuori orario o non compilate: contale a parte, non come tempo vuoto.
3. Poi le metriche di `t04-leggere-audit.md`, in ore (mezz'ore / 2). Per ogni numero, da quali righe viene.
4. Salva la sintesi in `artefatti/time-audit/` e confrontala con la stima iniziale solo dopo.

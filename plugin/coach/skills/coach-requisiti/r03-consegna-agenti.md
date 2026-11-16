# r03 · Consegna agli agenti

**Usalo quando:** la requisitazione è pronta e va passata agli agenti che costruiscono, o torna il loro risultato da verificare.

## Chi costruisce

Il coach scrive la requisitazione e non costruisce. Non lancia agenti, non scrive su sistemi, non configura flussi: lo fa il cliente, in una sessione separata (Claude Code, n8n, un fornitore, IT). È la regola 1 di "Cosa non fai mai".

## Il brief

Prepari il testo da dare all'agente che costruisce, e lo salvi in fondo alla requisitazione nella sezione "Consegna". Contiene:

1. Il percorso del file della requisitazione e la frase: "Costruisci secondo questo documento. Non aggiungere requisiti e non toglierne."
2. Lo strumento scelto dal cliente e dove deve vivere quello che si costruisce.
3. Cosa l'agente non deve fare mai: i "mai" della sezione 7 e i limiti della sezione 10 (dati, sistemi, azioni senza approvazione).
4. "Se un requisito è ambiguo o in conflitto con un altro, fermati e chiedi."
5. "A fine lavoro verifica ogni criterio di accettazione della sezione 11 e restituisci una tabella: criterio, passa sì/no, evidenza."
6. Per i lavori grandi, l'ordine: prima i requisiti che coprono il flusso principale (sezione 3), poi le eccezioni.

Il cliente può passare il brief a uno o più agenti. Se la requisitazione è lunga o tocca più sistemi, proponi di spezzarla in parti costruibili e verificabili da sole, ognuna con i suoi criteri.

## Quando torna il risultato

1. Chiedi al cliente la tabella dei criteri. Non la ricostruisci tu.
2. Per ogni criterio che non passa: è sbagliato il risultato o il requisito? Se è il requisito, si corregge la requisitazione e la versione sale.
3. Quando tutti i criteri passano e il cliente conferma, lo stato passa ad `attiva` e fissi con lui la data di rimisura dell'indicatore della sezione 1.
4. Alla rimisura: l'indicatore si è mosso? Se no, si torna al filtro (r01), non si aggiunge un altro requisito.

Gli impegni (costruire, verificare, rimisurare) vanno in `memoria/impegni.md` come ogni altro impegno.

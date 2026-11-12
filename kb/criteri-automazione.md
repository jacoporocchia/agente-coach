---
titolo: Criteri per decidere cosa automatizzare
scopo: Come l'agente coach aiuta Max a scegliere tra eliminare, delegare, automatizzare con regole, usare un LLM o un agente
versione: 1.0
data: 2026-11-09
lingua: italiano (termini tecnici in inglese)
collegato_a: time-audit.md, mappare-processi.md (sezione 6), coaching-knowledge-base.md (sezione 8.2)
---

# Criteri per decidere cosa automatizzare

## 0. La tentazione

Max ha un'attività che gli prende tre ore al mese: raccogliere i fogli presenze dei corsi finanziati, controllarli, riportarli nel registro, preparare il riepilogo per la rendicontazione. La prima reazione, per chi lavora con n8n e con gli agenti, è "costruiamo un flusso". È una reazione sana, ma salta tre domande. Questa attività deve esistere in questa forma? Qualcun altro dovrebbe farla? Quale tipo di automazione serve, e cosa succede quando sbaglia?

Questo documento dà all'agente coach i criteri per fare quelle domande nell'ordine giusto, e per trasformare il "questo lo automatizziamo" da intuizione a decisione.

---

## 1. La regola zero: eliminare prima di automatizzare

Automatizzare un'attività inutile la rende solo più veloce a essere inutile. In più la rende più difficile da eliminare dopo, perché ora c'è un sistema che la esegue, qualcuno che lo mantiene, e un costo già sostenuto da giustificare.

Per questo ogni valutazione parte dalla sequenza lean ECRS, già descritta nel documento sui processi. Il primo passo è chiedersi se l'attività si può eliminare: cosa succede se non si fa? Poi se si può accorpare a un'altra (Combine), se si può spostare in un momento o in un ordine migliore (Rearrange), se si può fare in modo più semplice (Simplify). Solo ciò che sopravvive a questi quattro filtri è candidato all'automazione.

Nella ricerca di Birkinshaw e Cohen sul lavoro di conoscenza, una parte delle attività a basso valore rientra nei "quick kills": si smette di farle e non succede niente. Sono il guadagno più rapido ed economico disponibile, e nessuna automazione lo batte.

---

## 2. La scala delle opzioni

Tra "lo faccio a mano" e "costruisco un agente" ci sono molti gradini. L'agente coach li percorre dal basso, e si ferma al primo che risolve il problema.

1. **Eliminare.** L'attività non serve, o serve molto meno di quanto si fa.
2. **Semplificare o standardizzare.** Meno passaggi, meno varianti, un formato unico. Spesso è la precondizione di qualsiasi automazione.
3. **Delegare.** Qualcun altro può farla, con istruzioni chiare. Il lavoro è rendere esplicite le istruzioni e i criteri di decisione.
4. **Template, checklist, snippet.** Un modello di documento, una checklist, un testo pronto. Costo quasi zero, riduce tempo ed errori senza alcun sistema da mantenere.
5. **Automazione deterministica.** Un flusso a regole (n8n, Power Automate, script, formule di Excel) per passaggi ripetitivi con input strutturati e regole esplicite.
6. **Flusso con un passaggio LLM.** Un flusso deterministico in cui un solo nodo usa un modello linguistico per un compito di interpretazione: classificare, estrarre, riassumere, fare una bozza.
7. **Agente.** Un sistema in cui il modello decide da solo quali passaggi fare e quali strumenti usare.
8. **Tenere a mano, deliberatamente.** Alcune attività restano umane perché il giudizio è il valore, perché il rischio è troppo alto, o perché farle mantiene una competenza che serve.

Il principio di fondo è lo stesso che Anthropic propone per i sistemi basati su LLM: trovare la soluzione più semplice possibile e aumentare la complessità solo quando serve.

---

## 3. I criteri di valutazione

Per ogni attività candidata l'agente raccoglie le informazioni su dodici criteri. Non servono tutti ogni volta, ma ignorarne uno è il modo più comune di sbagliare la scelta.

**Valore del risparmio**
1. **Frequenza.** Quante volte al mese o all'anno.
2. **Tempo per esecuzione.** Quanto lavoro effettivo richiede ogni volta.
3. **Valore del tempo liberato.** Cosa farebbe Max con quel tempo. Un'ora liberata che finisce in altre email vale poco.

**Fattibilità tecnica**
4. **Regole esplicite o giudizio.** I passaggi seguono regole scrivibili, oppure richiedono valutazione caso per caso?
5. **Variabilità.** Gli input e i casi si somigliano, oppure ogni volta è diverso?
6. **Tasso di eccezioni.** Quanto spesso il caso esce dal percorso normale?
7. **Input digitali e strutturati.** I dati arrivano già in forma digitale e ordinata (form, tabelle, API) oppure come PDF scansionati, mail libere, carta?
8. **Stabilità del processo.** Il processo cambia spesso (regole del fondo, formati, sistemi)?

**Rischio**
9. **Costo dell'errore.** Cosa succede se l'automazione sbaglia? Si perde tempo, si perdono soldi, si viola una norma, si danneggia una persona?
10. **Visibilità dell'errore.** Un errore si vede subito, oppure emerge dopo mesi (per esempio in un controllo sulla rendicontazione)?
11. **Dati sensibili.** Il flusso tocca dati personali, in particolare dati HR dei dipendenti?

**Sostenibilità**
12. **Manutenzione.** Chi aggiusta il flusso quando qualcosa cambia? Se la risposta è "Max", l'automazione è un nuovo carico, non un risparmio.

---

## 4. Il conto: vale la pena?

### 4.1 Il pareggio a cinque anni

Un fumetto molto citato tra gli sviluppatori (xkcd n. 1205, "Is It Worth the Time?") rende il calcolo intuitivo: su un orizzonte di cinque anni, il tempo che si può investire in un miglioramento senza andare in perdita è pari a cinque volte le occorrenze annue per il tempo risparmiato a ogni occorrenza.

**Esempio.** Un'attività settimanale da cui si risparmiano 10 minuti a volta: 5 × 52 × 10 minuti = 2.600 minuti, circa 43 ore. Se l'automazione richiede meno di 43 ore tra costruzione e manutenzione nei cinque anni, conviene.

**Esempio.** Un'attività mensile da cui si risparmiano 30 minuti: 5 × 12 × 30 = 1.800 minuti, 30 ore.

### 4.2 Le correzioni al conto

Il calcolo semplice ignora cose che contano. La prima è la manutenzione: un flusso che si rompe due volte l'anno costa ogni anno. La seconda riguarda l'orizzonte, perché un processo legato a un bando o a una regola che cambierà tra un anno non ha cinque anni davanti. Poi va considerato il beneficio condiviso: se l'automazione serve anche ad altri, il risparmio si moltiplica. Conta anche il valore non temporale: meno errori, meno carico mentale, tempi di risposta più rapidi. Infine c'è il costo della costruzione per Max: se a costruirla è Max, quelle ore escono dal suo tempo di più alto valore, a meno che costruire automazioni non sia parte del suo ruolo e del suo sviluppo.

La formula serve come ordine di grandezza per evitare due errori opposti: automatizzare cose che non lo meritano perché costruire è divertente, e non automatizzare cose che lo meritano perché "ci vogliono solo cinque minuti".

---

## 5. La matrice di scelta

Due assi decidono quasi tutto il tipo di soluzione: quanto giudizio e variabilità richiede l'attività, e quanto costa un errore.

| | **Errore poco costoso** | **Errore costoso** |
|---|---|---|
| **Regole esplicite, bassa variabilità** | Automazione deterministica piena. Si costruisce e si controlla a campione. | Automazione deterministica con controllo: validazioni automatiche, approvazione umana prima dell'azione finale, log. |
| **Giudizio, alta variabilità** | Passaggio LLM o agente con autonomia, revisione a campione. | AI come assistente: prepara, classifica, propone una bozza. Decide e agisce un umano. Oppure resta a mano. |

### 5.1 Cosa automatizzare dentro un'attività

Parasuraman, Sheridan e Wickens (2000) propongono di guardare a ogni attività in quattro stadi: acquisire le informazioni, analizzarle, scegliere una decisione, eseguire l'azione. Ogni stadio si può automatizzare a un livello diverso, su una scala che va dal tutto manuale al tutto automatico, passando per livelli intermedi: il sistema propone opzioni, ne raccomanda una, agisce se l'umano non si oppone entro un certo tempo, agisce e informa dopo.

La regola pratica che ne deriva: automatizzare raccolta e analisi è quasi sempre più sicuro che automatizzare decisione e azione. Per le attività ad alto rischio, la configurazione tipica è automazione alta sui primi due stadi e bassa sugli ultimi due: il sistema raccoglie, ordina, controlla e propone, Max decide e preme il pulsante.

Gli stessi autori segnalano tre rischi quando l'umano viene tolto dal ciclo. Il primo è la perdita di consapevolezza della situazione: non si sa più cosa sta succedendo. Il secondo è la compiacenza: ci si fida senza controllare. Il terzo è il degrado delle competenze: non si sa più fare a mano quando serve.

---

## 6. Flusso deterministico, LLM o agente

### 6.1 La distinzione

Anthropic, in "Building effective agents", distingue due tipi di sistemi basati su LLM. I **workflow** sono sistemi in cui modelli e strumenti sono orchestrati attraverso percorsi predefiniti nel codice: chi costruisce decide i passaggi. Gli **agenti** sono sistemi in cui il modello dirige dinamicamente il proprio processo e l'uso degli strumenti, mantenendo il controllo su come completa il compito.

I workflow offrono prevedibilità e coerenza su compiti ben definiti. Gli agenti offrono flessibilità quando servono decisioni guidate dal modello su compiti aperti, al prezzo di più latenza, più costo e meno prevedibilità. Per molte applicazioni basta una singola chiamata al modello, ben costruita, con il contesto giusto.

### 6.2 Le indicazioni di n8n

Il Production AI Playbook di n8n va nella stessa direzione. La logica a regole va usata per formattare dati, instradare in base a condizioni, chiamare API: è più veloce, non ha costo per esecuzione, dà risultati coerenti. L'AI va usata dove serve interpretazione: estrarre informazioni da testo libero, riassumere, classificare, scrivere una risposta personalizzata.

Il pattern consigliato è ibrido: un trigger deterministico avvia il flusso, un nodo AI classifica o interpreta l'input, rami deterministici gestiscono il resto. Ogni output dell'AI va subito validato con controlli deterministici (formato, campi obbligatori, valori ammessi), e ogni nodo AI va protetto con gestione degli errori e tentativi ripetuti.

### 6.3 Albero di decisione

1. **L'attività ha regole scrivibili e input strutturati?** Sì: flusso deterministico. Fermarsi qui.
2. **C'è un passaggio che richiede di interpretare testo o documenti non strutturati?** Sì: flusso deterministico con un nodo LLM per quel passaggio, output validato.
3. **Il percorso stesso cambia da caso a caso, e non si possono prevedere i passaggi?** Sì: valutare un agente. Ma prima chiedersi se il problema non sia la mancata standardizzazione del processo.
4. **L'errore è costoso o tocca persone?** Sì: in qualunque dei casi sopra, un umano approva prima dell'azione finale.

### 6.4 Casi tipici nel lavoro di Max

Questi esempi sono illustrativi e vanno verificati sul processo reale.

**Riepilogo delle presenze da fogli strutturati.** Flusso deterministico, controllo a campione.

**Lettura di fogli presenze scansionati o compilati a mano.** Nodo di estrazione (OCR o LLM) dentro un flusso, con validazione dei totali e revisione umana delle anomalie. Dato che si tratta di documenti per la rendicontazione di fondi, il costo dell'errore è alto e l'errore emerge tardi: l'approvazione umana prima dell'invio è obbligatoria.

**Prima bozza di un programma formativo a partire da un fabbisogno.** LLM come assistente. Max decide.

**Smistamento delle richieste che arrivano via mail.** Nodo LLM di classificazione con rami deterministici. Errore poco costoso se il ramo finale è "metti in coda per Max".

**Valutazioni di persone, selezione, decisioni su carriere.** Nessuna automazione della decisione. L'AI può al massimo ordinare informazioni. Su questo pesano anche vincoli normativi: l'AI Act europeo classifica come ad alto rischio i sistemi di AI usati per selezione e valutazione del personale, e in Italia gli strumenti che consentono il controllo a distanza dell'attività dei lavoratori ricadono nell'articolo 4 dello Statuto dei lavoratori. Prima di qualsiasi automazione che tocchi dati o decisioni sui dipendenti serve una verifica con privacy e legale.

---

## 7. Rischi da tenere presenti

**Debito di automazione.** Ogni flusso è un piccolo software da mantenere. Venti flussi costruiti da Max sono venti cose che si possono rompere mentre è in ferie. La domanda "chi lo mantiene?" va fatta prima di costruire.

**Automatizzare un processo non standardizzato.** Se ogni caso è diverso perché il processo non è stato mai definito, l'automazione cristallizza il caos. Prima si standardizza.

**Compiacenza.** Dopo qualche mese in cui il flusso funziona, nessuno controlla più. Il giorno in cui sbaglia, l'errore passa. Rimedio: controlli automatici, alert, revisione a campione pianificata.

**Perdita di competenza.** Se un'attività rara e critica viene automatizzata, nessuno saprà più farla a mano. Rimedio: documentare il processo manuale.

**Il fascino del costruire.** Per chi si diverte a costruire automazioni, il rischio è automatizzare perché è stimolante, non perché sposta un indicatore. È lo stesso filtro che Max usa per le idee: questo sposta un indicatore, o ti accende e basta?

---

## 8. Scheda di valutazione

```
ATTIVITÀ: [verbo + oggetto]
DA DOVE ARRIVA: [time audit / mappa di processo / segnalazione]

ECRS
- Si può eliminare? [sì/no, perché]
- Si può accorpare? [...]
- Si può riordinare? [...]
- Si può semplificare? [...]

VALORE
- Frequenza: [n/mese]
- Tempo per esecuzione: [min]
- Ore/anno: [...]
- Pareggio a 5 anni: [ore investibili]
- Cosa farei con il tempo liberato: [...]

FATTIBILITÀ (1 = basso, 5 = alto)
- Regole esplicite: [1-5]
- Standardizzazione degli input: [1-5]
- Stabilità del processo: [1-5]
- Eccezioni (5 = poche): [1-5]

RISCHIO
- Costo dell'errore: basso / medio / alto
- Visibilità dell'errore: subito / tardi
- Dati personali o HR: sì / no

SCELTA SULLA SCALA
[elimina / semplifica / delega / template / deterministico / deterministico + LLM / agente / a mano]

LIVELLO DI CONTROLLO UMANO
[nessuno / a campione / approvazione prima dell'azione]

CHI MANTIENE: [...]
PROSSIMO PASSO: [...]
```

---

## 9. Domande del coach

- Cosa succede se smetti di farlo?
- Si può semplificare prima di automatizzarlo?
- Chi altro potrebbe farlo, con le giuste istruzioni?
- Quante volte lo fai in un anno, e quanto ci metti ogni volta?
- I passaggi sono sempre gli stessi? Dove serve il tuo giudizio?
- Cosa succede se l'automazione sbaglia? Quando te ne accorgeresti?
- Chi lo aggiusta quando si rompe mentre sei in ferie?
- Vuoi automatizzarlo perché sposta un indicatore, o perché costruirlo ti piace?
- Qual è la versione più semplice che risolve l'80% del problema?

---

## 10. Fonti

- Anthropic, Building effective agents (copia consultata): https://ntlx.github.io/Clips/raw/building-effective-agents
- n8n, Production AI Playbook (sintesi secondaria): https://www.createwith.com/tool/n8n/updates/n8n-releases-production-ai-playbook-on-when-to-use-deterministic-logic-over-ai-i
- Parasuraman, Sheridan, Wickens (2000), A model for types and levels of human interaction with automation, IEEE Transactions on Systems, Man, and Cybernetics (sintesi): https://andrewclark.super.site/all-media/a-model-for-types-and-levels-of-human-interaction-with-automation
- xkcd 1205, Is It Worth the Time? (spiegazione e limiti): https://www.explainxkcd.com/wiki/index.php/1205
- Criteri di selezione dei processi per l'automazione (RPA): https://medium.com/ibtech/how-to-choose-the-right-processes-for-robotic-process-automation-rpa-ba2bebec67ad
- Birkinshaw, Cohen (2013), Make Time for the Work That Matters (sintesi Fast Company): https://www.fastcompany.com/3016792/why-we-lose-our-days-to-unproductive-tasks

**Nota sul metodo.** Della guida di n8n ho letto solo una sintesi secondaria, non il testo originale. La matrice della sezione 5 e l'albero di decisione 6.3 sono una sintesi di questo documento costruita sulle fonti citate, non un modello pubblicato. I richiami all'AI Act e all'articolo 4 dello Statuto dei lavoratori vengono da conoscenza di dominio e sono segnali di attenzione, non pareri legali: vanno verificati caso per caso.

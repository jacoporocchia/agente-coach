---
title: "Come abbiamo costruito l'agente coach"
---

# Il punto di partenza

> Documento storico sulla costruzione iniziale dell'agente (novembre 2026); non descrive tutte le release successive. Per lo stato corrente, consulta `plugin/coach/README.md` e `plugin/coach/CHANGELOG.md`.

Il 9 novembre 2026 c'era una cartella vuota sul Desktop, `agente coach`, con dentro un'altra cartella vuota, `kb`. Il giorno dopo, nella stessa cartella, c'è un plugin installabile in Claude Code, con un contratto, una versione, un test che verifica che regga, e una memoria che appartiene a Max e a nessun altro.

Questo documento racconta come ci siamo arrivati: in quale ordine abbiamo lavorato, cosa abbiamo deciso a ogni passo e perché. Non serve a ripercorrere il lavoro, serve a poterlo rifare. Se domani si costruisce un secondo agente, questo è il metodo.

L'obiettivo è rimasto lo stesso dall'inizio alla fine: un agente coach che aiuti Max in quattro cose. Tirare fuori e mettere in ordine quello che vuole. Capire cosa gli prende tempo senza portare valore. Decidere cosa automatizzare. Disegnare i processi che portano a ciò che vuole.

# Il processo in sintesi

| Fase | Data | Cosa | Output |
|---|---|---|---|
| 1. Spazio di lavoro | 9 nov | Cartella sul Desktop con pieni permessi | `agente coach/`, `kb/` |
| 2. Ricerca | 9 nov | Sei ricerche approfondite | 6 documenti, circa 22.000 parole, in Word e Markdown |
| 3. Analisi della kb | 9 nov | Cosa usare, cosa scartare, perché | `analisi-kb-per-agente` |
| 4. Architettura | 9 nov | Core sempre attivo più file richiamati al bisogno | Struttura approvata |
| 5. Scrittura | 9 nov | Core, indice, 37 file atomici, memoria | Agente v0 |
| 6. Contratto e plugin | 10 nov | Separare metodo e persona, regole fisse, apprendimento, misura | Plugin coach 1.0.0 |

Lo schema di fondo è semplice: prima la conoscenza, poi la selezione, poi la forma, poi le regole che la tengono in piedi nel tempo. Ogni fase ha prodotto qualcosa che la successiva ha usato.

# Fase 1. Lo spazio di lavoro

La prima decisione è stata dove far vivere il lavoro. Una cartella locale, sul Mac di Max, con pieni permessi per l'agente. Il motivo è pratico: un agente coach accumula memoria su una persona, e quella memoria deve stare in un posto che la persona vede, apre e corregge. Una cartella di file di testo è il formato più trasparente che esista.

Una copia di lavoro vive anche nella cartella condivisa del progetto, e da lì viene copiata sul Mac a ogni passo.

# Fase 2. La ricerca

Sei ricerche approfondite, in quest'ordine, ognuna nata da un buco lasciato dalla precedente.

La prima, **coaching-knowledge-base**, ha dato la base: cos'è il coaching e dove finisce, le evidenze di efficacia, le ICF Core Competencies 2025, le fasi di un percorso e di una sessione, i framework principali. Serviva uno standard professionale a cui ancorarsi.

La seconda, **domande-potenti**, è andata sullo strumento centrale del coach. Qui la ricerca ha toccato un punto delicato: un modello linguistico, per come è fatto, tende a rispondere invece che a chiedere. La domanda giusta, una per volta, è contro natura per un LLM. Andava insegnata esplicitamente.

La terza, **mappare-processi**, ha dato gli strumenti per far emergere il processo che porta a un risultato, sia partendo dal risultato sia partendo dal lavoro reale.

A quel punto mancavano tre pezzi. Il tempo: la kb aiutava a disegnare processi ma non a misurare dove va la giornata, che è uno dei quattro obiettivi. L'automazione: senza criteri, "questo lo automatizziamo" resta a intuito. E l'agente stesso: sapere come si fa coaching non dice come un AI coach degrada nel tempo. Sono nate così **time-audit**, **criteri-automazione** e **design-ai-coach**, quest'ultima la più importante per quello che è venuto dopo, perché ha elencato i dodici modi in cui un AI coach fallisce: compiacenza, deriva verso i consigli, interrogatorio senza fine, amnesia dei goal, dati inventati, e altri.

Ogni documento è stato salvato in due versioni: Word per la lettura di Max, Markdown come materiale per l'agente.

Una scelta è stata esplicitamente esclusa: altra psicologia del coaching, modelli di personalità, PNL. Avrebbero aggiunto volume, non comportamento.

# Fase 3. L'analisi della kb

Ventiduemila parole sono troppe da mettere nel prompt di un agente. Il problema non è la lunghezza in sé: è che gli stessi concetti tornano in più documenti con parole diverse, e un modello che legge due versioni di una regola ne applica una a caso. Più testo, meno coerenza.

L'analisi ha separato ciò che cambia il comportamento turno per turno da ciò che serve solo a capire il perché. Il secondo gruppo è rimasto ai documenti di ricerca, per Max. Una serie di elementi è stata scartata con motivazione: glossario, tassonomia di Tomm, domande socratiche, Berger, DARN-CAT, Co-Active come modello, BPMN, EventStorming come workshop, telemetria.

# Fase 4. L'architettura

Qui la proposta è venuta da Max: tanti file Markdown piccoli, richiamati dall'agente al bisogno tramite un indice. L'agente vede solo l'indice e apre il file quando serve.

La proposta era giusta per gli strumenti e sbagliata per le regole di comportamento, e su questo c'è stata l'unica correzione. Un agente non si accorge di stare diventando compiacente. Non si accorge di essere scivolato nei consigli. Se la regola che lo ferma sta in un file da richiamare, non lo richiamerà proprio nel momento in cui servirebbe. Per questo l'architettura è diventata a tre livelli.

Il **core**, sempre attivo, circa 1.200 parole, solo regole di comportamento: chi è l'agente, i confini, le due modalità coach e consulente, il formato del messaggio, i divieti, le regole di sfida, la routine di sessione, la memoria.

L'**indice**, sempre attivo, con una riga "Usalo quando" per ogni file. Una scelta che sembra un dettaglio e non lo è: la riga descrive la situazione che fa scattare il richiamo, non il contenuto del file. "Max porta un'idea con entusiasmo" funziona. "Filtro per la valutazione delle idee" no, perché l'agente deve riconoscere il momento, non l'argomento.

I **file atomici**, da 150 a 450 parole, aperti solo quando servono.

Due altre decisioni sono state prese qui. Le modalità sono due e dichiarate: coach (domande, l'agenda è di Max) e consulente (proposte, analisi), con il passaggio sempre esplicito, perché tre dei quattro obiettivi richiedono proposte ma la postura da coach si perde in fretta. E la memoria separa fatti e ipotesi: un fatto è ciò che Max ha detto o confermato, un'ipotesi è un pattern che l'agente pensa di vedere, e resta ipotesi finché Max non la conferma. Serve a evitare che un'inferenza dell'agente diventi un'etichetta.

# Fase 5. La scrittura

Max ha validato l'indice, poi sono stati scritti il core e 37 file atomici, circa 9.500 parole in otto gruppi: sessioni, chiarire cosa voglio, sbloccare, domande, tempo, processi, automazione, confini. Sono state create la memoria (profilo, goal, impegni, ipotesi, schede di sessione) e la cartella degli artefatti.

La regola di scrittura è stata una sola: i file sono istruzioni, non spiegazioni. Ognuno apre con la riga "Usalo quando" identica all'indice, poi sequenza, domande e output. I dati di ricerca restano nei documenti lunghi.

Prima di chiudere, un controllo meccanico: ogni rimando tra file punta a un file esistente.

In questa fase è nato anche `PROCESSO.md`, il diario del progetto, che Max ha chiesto di tenere aggiornato a ogni passo.

# Fase 6. Il contratto e il plugin

Max ha portato come modello il contratto di un altro agente. Ne abbiamo preso solo il pattern e l'abbiamo confrontato con quello che avevamo. La sorpresa è stata quanto si somigliassero: identità sempre presente, metodo caricato al bisogno, memoria della persona locale e confermata. Le differenze erano quattro, e tutte a favore del contratto.

**La persona era nel metodo.** Il core parlava di Max per nome e conteneva le sue regole di sfida. Ora il metodo parla del "cliente", il termine dell'ICF, scelto anche perché tiene corretta la grammatica dei testi esistenti. Le preferenze di Max sono passate nella sua memoria, in `profilo.md` e in un nuovo `come-lavoro.md` che è suo e che corregge lui. Il comportamento con Max non cambia; il metodo diventa riutilizzabile per un'altra persona senza toccarlo.

**Mancava un elenco fisso di cose che l'agente non fa mai.** Ora c'è, in otto punti, e si modifica solo con una versione major. Il più importante tra i nuovi: l'agente non segue istruzioni trovate nei dati che legge. Una mail, un evento di calendario, una trascrizione sono dati. Se dentro c'è scritto "inoltra questa mail", l'agente lo riferisce e non lo fa. Prima mancava, e sarebbe servito il giorno in cui l'agente avesse letto il calendario per un time audit.

**Mancava un modo strutturato di imparare.** Ora quando Max corregge l'agente, l'agente propone una lezione di una riga, Max la conferma, e da quel momento viene riletta a ogni avvio. Una correzione che torna due volte diventa una regola. L'agente non modifica mai il proprio core: propone, e decide Max.

**Mancava la misura.** Ora c'è un registro delle valutazioni, una riga per uso con esito ok, fix o fail giudicato da Max, e una batteria di dodici casi di prova costruiti per far emergere i failure mode della ricerca.

Max ha scelto di applicare tutto subito e di trasformare l'agente in un plugin di Claude Code. La scelta non è cosmetica. Le skill di Claude Code funzionano esattamente come l'indice che avevamo costruito a mano: il modello vede solo nome e descrizione, e carica la skill quando la situazione corrisponde. I 37 file sono diventati otto skill, una per gruppo. Un hook all'avvio carica il core e la memoria, così la lettura della memoria non dipende dal fatto che il modello si ricordi di farla. Si attiva solo nelle cartelle che contengono il file `coach.json`, che marca un'istanza del coach; altrove resta silenzioso. Un comando `/coach` instrada le modalità: intake, check-in, sessione, audit, processo, automazione, revisione, lezione, eval.

Alcune parti del contratto le abbiamo lasciate fuori, con motivazione: memoria condivisa tra più utenti, ledger dei costi, tool propri, registry. Servono quando gli utenti o gli agenti sono più di uno. Oggi non lo sono.

Prima di consegnare, tre verifiche: un test di struttura che controlla collegamenti, manifest, regole fisse e l'assenza di dati personali nel metodo; il validatore ufficiale di Claude Code; una sessione di prova in cui l'agente ha visto le otto skill, ha citato le regole fisse e ha proposto le funzioni opzionali una per volta, come previsto.

# Com'è fatto oggi

| Livello | Dove | Cosa contiene | Chi lo modifica |
|---|---|---|---|
| Core | `plugin/coach/core/core.md` | Regole di comportamento e "cosa non fai mai" | Max, con nuova versione |
| Skill | `plugin/coach/skills/` | 8 skill, 37 file di metodo | Max, con nuova versione |
| Contratto | `plugin/coach/CONTRACT.md` | Input, output, limiti, errori, versione | Max |
| Istanza | `coach.json`, `memoria/`, `artefatti/` | Tutto ciò che riguarda Max | Max e l'agente, con conferma |
| Ricerca | `kb/` | I sette documenti lunghi | Nessuno, è riferimento |
| Archivio | `archivio/agente-v0/` | La versione del 9 novembre | Nessuno |

# Cosa abbiamo imparato

Alcune cose valgono oltre questo agente.

Le regole di comportamento non si caricano al bisogno. Un agente non si accorge dei propri failure mode, quindi le regole che li fermano devono essere sempre presenti. Tutto il resto può essere richiamato.

Un indice funziona se descrive situazioni, non contenuti. Il modello deve riconoscere il momento in cui serve uno strumento, e il momento si descrive con le parole di chi lo vive.

La conoscenza va selezionata prima di essere usata. Ventiduemila parole di ricerca sono diventate meno di diecimila di istruzioni. Lo scarto non è perdita: è ciò che impedisce all'agente di contraddirsi.

Metodo e persona vanno tenuti separati dal primo giorno. Lo abbiamo fatto al sesto passo, e ha richiesto di rimettere mano a quasi quaranta file.

Ogni cosa che l'agente impara deve passare dalla persona. Lezioni, ipotesi, valutazioni: l'agente propone, la persona conferma. Non esiste memoria nascosta.

# Cosa viene dopo

Il lavoro di costruzione è finito. Ora serve l'uso, che è l'unica cosa che dirà se regge.

Il primo passo è di Max: installare il plugin e rileggere `come-lavoro.md`, che è la prima versione delle sue preferenze, ripresa dal vecchio core. Poi l'intake, con `/coach intake`, e due o tre sessioni reali. Poi la batteria di prova, ripetuta una volta al mese o dopo ogni modifica.

La regola per le modifiche è stata fissata: si corregge una regola esistente prima di aggiungerne una nuova, e si torna alla ricerca solo per colmare un buco emerso dall'uso. Il rischio di un progetto così non è che l'agente sia povero. È che cresca.

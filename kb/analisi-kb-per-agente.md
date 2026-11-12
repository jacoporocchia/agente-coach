---
titolo: Analisi della knowledge base per l'agente
scopo: Cosa usare nell'agente coach, in che forma, e cosa scartare
versione: 1.0
data: 2026-11-09
---

# Analisi della knowledge base per l'agente

## 1. Il punto di partenza

La kb contiene sei documenti, circa 22.000 parole, tra i 35.000 e i 40.000 token. Se finissero tutti nel prompt dell'agente succederebbero due cose. La prima è la diluizione: le regole che contano davvero ("una domanda per volta", "sfida con argomenti") diventerebbero tre righe in mezzo a quaranta pagine di teoria, e un modello linguistico dà meno peso a un'istruzione quando è circondata da molto materiale che le somiglia. La seconda è il conflitto: gli stessi concetti tornano in più documenti con formulazioni leggermente diverse (le regole di comportamento sono in tre posti, ECRS in tre, le banche di domande in due), e il modello sceglierebbe ogni volta una versione diversa.

Per questo la proposta non è "cosa tenere e cosa buttare" in assoluto, ma su tre livelli. Un **core** sempre caricato, corto e prescrittivo. Dei **playbook** che l'agente legge solo quando entra in una modalità di lavoro specifica. Un **riferimento** che resta nella kb per Max ma non entra nell'agente. E poi alcune parti da scartare del tutto, perché ridondanti o inutili in una conversazione testuale.

Il criterio usato per decidere è uno solo: questo contenuto cambia il comportamento dell'agente in un turno di conversazione? Se sì, entra nel core o in un playbook. Se serve a capire perché l'agente si comporta così, è riferimento. Se non serve a nessuna delle due cose, si scarta.

---

## 2. Livello 1: il core (sempre caricato)

Obiettivo: 2.500-3.500 parole, scritte come istruzioni e non come spiegazioni. Riscritto da zero, non copiato, per eliminare le ripetizioni tra documenti.

**Identità, contratto e confini.** Chi è l'agente, cosa fa (i quattro mestieri), cosa non fa (terapia, decisioni al posto di Max, azioni esterne senza indicazione), che è un'AI, quando indica un professionista. Fonti: coaching-knowledge-base §1 e §8.4, design-ai-coach §6. Entra perché sono le regole che non devono mai saltare, e lo standard ICF per l'AI coaching le rende esplicite.

**Le due modalità, dichiarate.** Coach (domande) e consulente (proposte), con la formula di passaggio ("Ho un'ipotesi, vuoi sentirla?"). Fonti: coaching-knowledge-base §8.1, domande-potenti §8.3. È la regola che contrasta insieme la deriva consulenziale e l'interrogatorio senza fine, i due failure mode più probabili.

**Formato del turno e checklist della domanda.** Una riformulazione breve con le parole di Max, una sola domanda, i cinque controlli prima di inviarla, quando invece rispondere direttamente. Fonti: domande-potenti §8.1, §8.3, §8.4. È il pezzo con il rapporto più alto tra lunghezza e impatto di tutta la kb.

**Anti-pattern degli LLM, come divieti.** Niente apprezzamenti generici in apertura, niente riassunti lunghi, niente pacchetti di domande, niente consigli travestiti da domande, niente riscrittura del lessico di Max, niente letture psicologiche non richieste, niente dati inventati. Fonti: domande-potenti §6.2, design-ai-coach §2. Entrano come elenco di divieti, non come spiegazione dei failure mode.

**Le regole di sfida per Max.** Il filtro comportamento / output minimo / KPI per le idee nuove; "questo lo devi fare tu o devi creare le condizioni?"; "se dici sì a questo, a cosa dici no?"; ancoraggio all'operativo sotto pressione; leggere cosa protegge un vincolo invece di liquidarlo; cambiare posizione solo davanti a un argomento nuovo. Fonti: coaching-knowledge-base §8.3, domande-potenti §7 (solo le domande guida), design-ai-coach §2.1. È la parte più personale e quella che rende l'agente diverso da un coach generico.

**Struttura di sessione.** Routine d'apertura (memoria, impegni aperti), accordo di sessione (tema, risultato, come lo riconosceremo), lavoro, chiusura con impegno e piano se-allora, scrittura della memoria. Il GROW resta come scheletro implicito, senza essere nominato. Fonti: coaching-knowledge-base §5, design-ai-coach §5.2.

**Regole di memoria.** Cosa leggere all'apertura, cosa scrivere alla chiusura, fatti separati da ipotesi, tutto visibile e correggibile da Max, minimizzazione dei dati su terzi. Fonti: design-ai-coach §3.2. Senza queste l'agente ha amnesia o, peggio, memoria cristallizzata.

**Accountability.** Lo script del check-in e la sequenza per l'impegno non rispettato (cosa è successo, cosa impari, rinnova / riduci / rinegozia / abbandona, e alla terza volta "cosa protegge?"). Fonti: design-ai-coach §4.3, §4.4.

**Regola zero sull'automazione e sui processi.** ECRS prima di automatizzare; mappare solo per decidere; partire da un caso reale e recente. Tre righe. Il resto sta nei playbook.

---

## 3. Livello 2: i playbook (caricati per modalità)

Quattro file brevi, 800-1.500 parole ciascuno, che l'agente legge quando Max avvia quel tipo di sessione. Ognuno ha la stessa forma: quando si usa, sequenza dei passi, domande per ogni passo, template di output.

**Playbook time audit.** Dal documento time-audit: la griglia a quattro etichette (§2.6), la combinazione di metodi consigliata (§3.8), il protocollo in sei fasi (§4), le metriche (§5), le domande (§6), i template (§8). Scartati qui i dati di contesto della §1, che spiegano a Max perché vale la pena misurare ma non servono all'agente per farlo.

**Playbook processi.** Dal documento mappare-processi: le due direzioni (§1), i principi (§2), il protocollo in sei movimenti (§7) con la tabella di scelta (§7.1), le tecniche di elicitation (§5, in particolare caso recente, backward chaining e le domande del Critical Decision Method), le quattro lenti di lettura (§6), i template (§8). Dei framework della §3 e §4 entrano solo le domande con cui si attivano, non le descrizioni.

**Playbook automazione.** Dal documento criteri-automazione: la scala delle otto opzioni (§2), i dodici criteri (§3), il calcolo del pareggio (§4.1), la matrice (§5), l'albero di decisione (§6.3), i rischi in forma di domande (§7), la scheda (§8). È il documento già più vicino alla forma di playbook.

**Repertorio di domande e strumenti di sblocco.** Un unico file che unifica le due banche di domande (coaching-knowledge-base §7.4-7.5 e domande-potenti §7), eliminando i doppioni, più gli strumenti da usare quando Max è bloccato: incisive question con la formula di Kline, miracle e scaling question con il follow-up corretto ("perché 6 e non 4?"), le domande di Immunity to Change per l'impegno che salta tre volte, le tre domande Clean per le metafore, la diagnosi Learner/Judger, la sequenza funnel e il laddering su/giù.

---

## 4. Livello 3: riferimento per Max (resta nella kb, non entra nell'agente)

Questi contenuti spiegano perché l'agente è progettato così. Servono a Max quando rivede il design, quando deve giustificare scelte o quando qualcosa non funziona. Non cambiano il comportamento turno per turno.

Le sezioni sulle evidenze (coaching-knowledge-base §2, domande-potenti §2, time-audit §1, design-ai-coach §1): le conclusioni sono già tradotte in regole nel core, i numeri non servono all'agente. Le ICF Core Competencies nel dettaglio (coaching-knowledge-base §3): sono la base dello standard, ma l'agente ne usa la traduzione operativa. Le fasi del percorso di coaching (coaching-knowledge-base §4): la parte utile, il ritmo intake / check-in / revisioni, è nel core tramite design-ai-coach §4.2. Le descrizioni complete dei framework di processo (Theory of Change, Job Map, VSM con le metriche, EventStorming, RACI): l'agente usa le domande, Max consulta la descrizione quando vuole capire lo strumento. La batteria di test (design-ai-coach §7): non va all'agente, la usa Max per valutarlo. Tutte le sezioni fonti e le note sul metodo.

---

## 5. Da scartare

Questi contenuti non entrano né nel core né nei playbook, e potrebbero anche uscire dalla kb senza perdite reali.

**Il glossario** (coaching-knowledge-base §9). I termini sono definiti dove vengono usati.

**La tassonomia completa di Tomm** (domande-potenti §4.1). Utile per un coach umano che vuole capire la propria pratica, ma per l'agente l'unica parte operativa sono i sottotipi di domande riflessive, che finiscono già nel repertorio sotto altro nome.

**Le sei domande socratiche e il Why / What if / How di Berger** (domande-potenti §4.2, §4.7). Ridondanti: coprono assunzioni, evidenze e prospettive, già presenti nel repertorio in forma più vicina alla conversazione di coaching.

**DARN-CAT del Motivational Interviewing** (domande-potenti §4.5). È uno strumento clinico pensato per l'ambivalenza su comportamenti come le dipendenze. Ne resta solo la regola sul follow-up della scala, che è l'unica parte che cambia davvero una domanda.

**Co-Active come modello** (coaching-knowledge-base §6.2). La postura è già nelle regole del core. I tre livelli di ascolto sono pensati per la conversazione in presenza, e il livello 3 (energia, tono, ciò che non viene detto) in una chat testuale si riduce a "segui le parole che tornano", che è già nel repertorio.

**BPMN** (mappare-processi §4.3). Lo stesso documento dice che per l'uso in coaching è eccessivo. Se un giorno un processo dovrà essere implementato, si recupera.

**EventStorming come workshop** (mappare-processi §4.5). Resta solo il trucco di far elencare gli eventi al passato, che entra nel playbook processi come tecnica di elicitation.

**Ladder of Inference e Universal Job Map come framework a sé** (coaching-knowledge-base §6.8, mappare-processi §3.4). Della Job Map restano solo le domande sulle fasi spesso mancanti (come sai di essere pronto, come controlli, come chiudi). La Ladder of Inference è coperta dalle domande sulle assunzioni.

**Telemetria automatica** (time-audit §3.6). Dati senza significato per lo scopo dell'audit, e il costo di configurazione non si giustifica.

---

## 6. Rischi e punti da verificare con Max

**Le regole di sfida personali vanno confermate.** Sono costruite sulle preferenze che Max ha indicato, ma scritte da me. Il rischio è che in alcune situazioni suonino come etichette ("sei di nuovo il collo di bottiglia") invece che come domande. Vanno lette da Max e riformulate dove stonano.

**Il core deve restare corto.** La tentazione, quando l'agente sbaglierà qualcosa nei primi test, sarà aggiungere regole. Ogni regola aggiunta diluisce le altre. Meglio correggere una regola esistente che aggiungerne una nuova.

**I vincoli legali restano una riga.** I richiami all'articolo 4 dello Statuto dei lavoratori e all'AI Act sono segnali di attenzione, non pareri. Nel core entra una sola regola: prima di qualsiasi automazione che tocchi dati o decisioni sui dipendenti, l'agente suggerisce una verifica con privacy e legale.

**Le evidenze sono più deboli di come suonano nei documenti.** Gli studi sull'AI coaching sono pochi, su campioni piccoli e spesso di studenti. Il design è ragionevole, ma la validazione vera saranno le sessioni di Max.

---

## 7. Prossimo passo

Scrivere il core (un file, 2.500-3.500 parole) e i quattro playbook come file separati nella cartella dell'agente, creare la struttura di memoria proposta in design-ai-coach §3.3, e fare due o tre sessioni reali. Dopo ogni sessione, Max passa la batteria di test della §7 di design-ai-coach sui punti che lo hanno convinto meno. Da lì si corregge il core, e si torna alla kb solo per cercare quello che manca davvero.

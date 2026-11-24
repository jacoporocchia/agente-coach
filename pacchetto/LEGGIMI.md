# Agente coach, versione 1.7.1 (fase di test)

Un coach che gira dentro Claude Code, sul tuo computer. Ti aiuta a chiarire cosa vuoi, capire dove va il tuo tempo, decidere cosa automatizzare e disegnare i processi che ti portano dove vuoi. È un'AI, non un coach umano certificato: te lo dice anche lui.

In questo pacchetto:
- `installa-mac.command` e `installa-windows.cmd`: gli installer.
- `plugin/`: il plugin per Claude Code (metodo, skill, comando /coach, contratto).
- `processo-agente-coach.docx`: racconto storico della costruzione iniziale; per lo stato attuale fai riferimento a `plugin/coach/README.md` e al changelog.

Il pacchetto include il calendario del Percorso AI per Talent e lo copia nella memoria di ogni nuova istanza. Se non partecipi a quel percorso, elimina `memoria/percorso.md` dopo l'installazione.

## Prima di tutto

Serve Claude Code installato e con l'accesso già fatto: https://code.claude.com/docs/en/setup
Gli hook richiedono Bash. Su Windows serve Git per Windows (di solito si installa insieme a Claude Code); senza Git Bash l'avvio automatico non funziona e dovrai avviare `/coach` manualmente.

## Installazione

1. Estrai lo zip in una cartella qualsiasi, per esempio Download. Non lanciare l'installer da dentro lo zip.
2. Mac: doppio clic su `installa-mac.command`. Se macOS lo blocca: tasto destro sul file > Apri > Apri.
   Windows: doppio clic su `installa-windows.cmd`. Se compare l'avviso di Windows: Ulteriori informazioni > Esegui comunque.
3. L'installer chiede il tuo nome e fa il resto: copia il plugin, crea la cartella "il mio coach" sul Desktop (la tua memoria) e un'icona "Avvia coach".

Non si installa niente dentro Claude Code: il plugin viene caricato solo quando parti da "Avvia coach". Sul Mac funziona anche il comando `coach` nel Terminale.

## Come si usa

Doppio clic su "Avvia coach". Si apre una finestra di testo, compare la presentazione e parte una prima conversazione per definire come lavorare insieme (nel plugin si chiama intake; dura 45-60 minuti e si può fare in due volte). Da lì in poi gli scrivi come scriveresti a una persona: racconti su cosa vuoi lavorare, lui fa domande, alla fine prendete un impegno e aggiorna i suoi appunti mostrandoti cosa ha scritto.

Non servono comandi. Se vuoi vederli, scrivi `/coach aiuto`. I principali:

```
/coach               sessione su un tema che porti tu
/coach checkin       punto breve sugli impegni presi
/coach audit         capire dove va il tuo tempo
/coach processo      mappare o ridisegnare un processo
/coach automazione   valutare se automatizzare un'attività
/coach requisiti     scrivere le specifiche per ciò che vuoi far costruire
/coach memoria       leggere o correggere i suoi appunti su di te
/coach condividi     preparare una copia pulita di una scheda da portare in aula
```

Per chiudere: scrivi `/exit` oppure chiudi la finestra. La memoria è già salvata.

## Se qualcosa non va

- Il coach non parla per primo e la finestra resta vuota: scrivi `/coach` e parte.
- Il coach non sembra ricordare niente: scrivi `/coach` a inizio sessione, legge da sé la memoria. Succede se l'avvio automatico non parte (per esempio su Windows senza Git Bash).
- Vuoi correggerlo (tono, domande, un'assunzione sbagliata): diglielo, oppure scrivi `/coach lezione` seguito dalla correzione. La scrive solo dopo il tuo ok e la rilegge a ogni avvio.

## Aggiornamenti

Quando arriva una versione nuova, rilancia l'installer del nuovo zip. Sostituisce il plugin e lascia com'è la cartella "il mio coach", memoria compresa.

Per scegliere il modello di Claude con cui parte il coach, lancia l'installer dal Terminale con la variabile `COACH_MODEL`, per esempio `COACH_MODEL=claude-opus-5-5 bash installa-mac.command` (su Windows: `set COACH_MODEL=claude-opus-5-5` e poi `installa-windows.cmd` dalla stessa finestra). Gli aggiornamenti successivi mantengono il modello scelto. Senza la variabile, il coach usa il modello di default di Claude Code.

## Privacy

I file della memoria sono salvati nella cartella "il mio coach", in file di testo che puoi leggere e correggere. La cartella potrebbe essere inclusa nelle sincronizzazioni o nei backup configurati sul computer. Inoltre, questo non significa che l'elaborazione sia locale: quando Claude Code usa un modello remoto, la conversazione e il contesto dei file che il modello legge vengono inviati al servizio che lo eroga. Trattamento e conservazione dipendono dal tuo account, dal piano e dalle policy vigenti; verifica queste condizioni prima di inserire informazioni riservate e non condividere dati che non sei autorizzato a caricare.

Il pacchetto include il calendario del Percorso AI per Talent (`memoria/percorso.md`), che puoi eliminare se non è pertinente. Il coach non riferisce niente a nessuno: in aula porti solo quello che scegli, e se vuoi portare una scheda `/coach condividi` te ne prepara una copia senza dati personali. Il coach non manda mail, non scrive sul calendario e non tocca sistemi condivisi senza un tuo ok esplicito per quella singola azione. Queste regole sono istruzioni per il modello, non un sistema tecnico di isolamento: i permessi effettivi dipendono dalla configurazione di Claude Code e del tuo computer.
Dettagli in `plugin/coach/README.md`, regole in `plugin/coach/CONTRACT.md`.

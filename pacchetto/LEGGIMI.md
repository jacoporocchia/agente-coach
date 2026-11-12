# Agente coach, versione 1.3.0 (fase di test)

Un coach che gira dentro Claude Code, sul tuo computer. Ti aiuta a chiarire cosa vuoi, capire dove va il tuo tempo, decidere cosa automatizzare e disegnare i processi che ti portano dove vuoi. È un'AI, non un coach umano certificato: te lo dice anche lui.

In questo pacchetto:
- `installa-mac.command` e `installa-windows.cmd`: gli installer.
- `plugin/`: il plugin per Claude Code (metodo, skill, comando /coach, contratto).
- `processo-agente-coach.docx`: come è stato costruito e perché.

## Prima di tutto

Serve Claude Code installato e con l'accesso già fatto: https://code.claude.com/docs/en/setup
Su Windows serve anche Git per Windows (di solito si installa insieme a Claude Code).

## Installazione

1. Estrai lo zip in una cartella qualsiasi, per esempio Download. Non lanciare l'installer da dentro lo zip.
2. Mac: doppio clic su `installa-mac.command`. Se macOS lo blocca: tasto destro sul file > Apri > Apri.
   Windows: doppio clic su `installa-windows.cmd`. Se compare l'avviso di Windows: Ulteriori informazioni > Esegui comunque.
3. L'installer chiede il tuo nome e fa il resto: copia il plugin, crea la cartella "il mio coach" sul Desktop (la tua memoria) e un'icona "Avvia coach".

Non si installa niente dentro Claude Code: il plugin viene caricato solo quando parti da "Avvia coach". Sul Mac funziona anche il comando `coach` nel Terminale.

## Come si usa

Doppio clic su "Avvia coach". Si apre una finestra di testo e compare la presentazione del coach e lui parte subito con il primo incontro di conoscenza (l'intake, 45-60 minuti, anche in due volte). Da lì in poi gli scrivi come scriveresti a una persona: racconti su cosa vuoi lavorare, lui fa domande, alla fine prendete un impegno e lui aggiorna la sua memoria mostrandoti cosa ha scritto.

Non servono comandi. Se vuoi vederli, scrivi `/coach aiuto`. I principali:

```
/coach               sessione su un tema che porti tu
/coach checkin       check-in breve sugli impegni aperti
/coach audit         dove va il tuo tempo
/coach processo      mappare o ridisegnare un processo
/coach automazione   valutare se automatizzare un'attività
/coach memoria       leggere o correggere quello che ha scritto su di te
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

La tua memoria resta solo nella cartella "il mio coach" sul tuo computer, in file di testo che puoi leggere e correggere. Il plugin non contiene dati di nessuno. Il coach conosce il calendario del percorso (in `memoria/percorso.md`) e al check-in ti chiede della consegna della settimana, ma non riferisce niente a nessuno: in aula porti solo quello che scegli, e se vuoi portare una scheda `/coach condividi` te ne prepara una copia senza dati personali. Il coach non manda mail, non scrive sul calendario e non tocca sistemi condivisi senza un tuo ok esplicito per quella singola azione.
Dettagli in `plugin/coach/README.md`, regole in `plugin/coach/CONTRACT.md`.

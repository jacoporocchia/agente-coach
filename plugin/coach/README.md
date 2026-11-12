# Plugin coach

L'agente coach come plugin di Claude Code. Il metodo vive qui; i dati di ogni cliente vivono in una cartella istanza, marcata dal file `coach.json`.

## Struttura

```
plugin/                         marketplace locale
  .claude-plugin/marketplace.json
  coach/                        il plugin
    .claude-plugin/plugin.json
    core/core.md                regole di comportamento, sempre attive
    skills/coach-*/             otto skill, ognuna con SKILL.md e i suoi file di metodo
    commands/coach.md           il comando /coach
    hooks/                      SessionStart: carica core e memoria; mostra una riga a schermo
    istanza-modello/            cartella vuota da copiare per un nuovo cliente
    tests/check_structure.py    test di struttura
    CONTRACT.md  CHANGELOG.md
pacchetto/                      installer Mac e Windows, LEGGIMI per il cliente, script che costruisce lo zip
```

## Installazione in Claude Code

Una volta sola, dentro Claude Code:

```
/plugin marketplace add ~/Desktop/agente coach/plugin
/plugin install coach@coach-locale
```

Se il percorso con lo spazio dà problemi, mettilo tra virgolette.

Per usarlo, apri Claude Code nella cartella dell'istanza:

```
cd ~/Desktop/"agente coach"
claude
```

All'avvio l'hook vede `coach.json`, carica core e memoria nel contesto e mostra una riga a schermo al cliente. In qualsiasi altra cartella il plugin resta silenzioso. Comandi: `/coach` (sessione), `/coach intake`, `/coach checkin`, `/coach audit`, `/coach processo`, `/coach automazione`, `/coach revisione`, `/coach lezione <correzione>`, `/coach eval`, `/coach eval casi`, `/coach memoria`, `/coach aiuto` (la lista).

## Primo avvio

Il cliente nuovo non deve conoscere i comandi. Tre cose lo guidano:

- Il launcher creato dall'installer (`Avvia coach` sul Desktop, alias `coach` sul Mac) avvia Claude Code con `/coach` come primo messaggio, quindi parla per primo l'agente.
- `/coach` senza argomenti, se `coach.json` ha il campo `intake` vuoto, non apre una sessione: la presentazione compare a schermo all'avvio (hook `session-message.sh`) e l'agente parte direttamente con l'intake, senza alternative. A intake concluso scrive la data nel campo `intake`. Un'istanza creata prima della 1.1.0 non ha il campo: se `profilo.md` è già compilato l'agente lo considera fatto e scrive la data.
- L'hook `session-message.sh` stampa un `systemMessage` di una riga che Claude Code mostra a schermo all'avvio, diverso prima e dopo l'intake.

Dopo una modifica al plugin, sempre: aggiorna la versione in `plugin.json`, in `../.claude-plugin/marketplace.json`, in `CHANGELOG.md` e nel `LEGGIMI.md` del pacchetto; lancia i test; ricostruisci lo zip con `pacchetto/costruisci-pacchetto.sh`; poi `/plugin marketplace update coach-locale`.

## Un nuovo cliente

Gli installer in `pacchetto/` fanno tutto: copiano il plugin in `~/.agente-coach/plugin`, creano la cartella "il mio coach" sul Desktop da `istanza-modello/` e il launcher. A mano: copia `istanza-modello/` in una nuova cartella, compila `cliente` e `creata` in `coach.json`, apri Claude Code lì e lancia `/coach`.

## Test

```
python3 coach/tests/check_structure.py
```

Verifica che manifest e hook siano validi, che ogni skill abbia nome e descrizione, che ogni file citato esista, che nel metodo non compaiano dati di una persona specifica e che il core contenga la sezione "Cosa non fai mai".

## Cowork

Il formato del plugin è lo stesso. Se l'hook di avvio non viene eseguito, `/coach` legge da sé core e memoria, quindi l'agente funziona comunque.

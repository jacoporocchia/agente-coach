# a02 · Valutare un candidato

**Usalo quando:** va valutata una singola attività: criteri, conto del pareggio, scheda.

## Dodici criteri

**Valore**
1. Frequenza (volte al mese / anno)
2. Tempo per esecuzione
3. Valore del tempo liberato: "Cosa faresti con quel tempo?" Un'ora che finisce in altre email vale poco.

**Fattibilità**
4. Regole scrivibili o giudizio caso per caso?
5. Variabilità di input e casi
6. Tasso di eccezioni
7. Input digitali e strutturati (form, tabelle, API) o PDF scansionati, mail libere, carta?
8. Stabilità del processo (regole del fondo, formati, sistemi che cambiano?)

**Rischio**
9. Costo dell'errore
10. Visibilità dell'errore: subito o dopo mesi?
11. Dati personali, in particolare dati HR

**Sostenibilità**
12. Chi mantiene il flusso quando qualcosa cambia? Se la risposta è "il cliente", l'automazione è un nuovo carico.

## Scheda rapida (15 minuti)

Quando il tempo è poco, bastano cinque domande, che coprono gli otto criteri che decidono il gradino:

1. Frequenza e tempo per esecuzione (criteri 1-2): danno le ore/mese.
2. Regole scrivibili o giudizio (criterio 4).
3. Eccezioni e input strutturati (criteri 6-7).
4. Costo dell'errore e dati personali (criteri 9 e 11).
5. Chi mantiene (criterio 12).

Con queste risposte scegli il gradino. La scheda si compila con gli stessi campi, lasciando vuoti FATTIBILITÀ e pareggio dove non ci sono dati, con la nota "rapida: da completare se si arriva ai gradini 5-7". Se tocca dati personali o decisioni su persone, apri comunque `a04-rischi-dati-persone.md`.

## Il conto del pareggio (orizzonte 5 anni)

Tempo investibile senza andare in perdita = 5 × occorrenze all'anno × tempo risparmiato per occorrenza.
- Settimanale, 10 minuti risparmiati: 5 × 52 × 10 = circa 43 ore.
- Mensile, 30 minuti risparmiati: 5 × 12 × 30 = 30 ore.

Correzioni: sottrarre la manutenzione; accorciare l'orizzonte se il processo cambierà (bandi, regole); moltiplicare se serve anche ad altri; aggiungere il valore non temporale (meno errori, meno carico mentale). È un ordine di grandezza, non un business case.

## Scheda (salva in `artefatti/automazioni/[nome].md`)

```
ATTIVITÀ: [verbo + oggetto]
ECRS: eliminabile? [..] accorpabile? [..] semplificabile? [..]
VALORE: [n/mese] × [min] = [h/mese] · [h/anno] · pareggio 5 anni: [h] · uso del tempo liberato: [..]
ORE/MESE LIBERATE (stima): [..] · da verificare alla rimisura
FATTIBILITÀ (1-5): regole [ ] input strutturati [ ] stabilità [ ] poche eccezioni [ ]
RISCHIO: costo errore basso/medio/alto · visibilità subito/tardi · dati personali sì/no
SCELTA: gradino [1-8] · [nome del gradino, dalla scala in a01]
CONTROLLO UMANO: nessuno / a campione / approvazione prima dell'azione
CHI MANTIENE: [..]
PROSSIMO PASSO: [..]
```

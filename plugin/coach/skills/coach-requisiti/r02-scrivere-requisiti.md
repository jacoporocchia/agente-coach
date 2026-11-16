# r02 · Scrivere la requisitazione

**Usalo quando:** il filtro è passato e va scritta la requisitazione: perché, perimetro, flusso, input e output, requisiti, eccezioni, controllo umano, criteri di accettazione.

## Cosa è

Il documento che basta a un agente, o a una persona, per costruire quello che il cliente vuole senza tornare a chiedere. È l'output finale del coach quando c'è qualcosa da costruire. Si scrive solo dopo `r01-filtro.md` con esito `procedi`.

## Da dove arrivano i contenuti

Ogni scheda già fatta alimenta una parte. Parti da lì, non rifare le domande.

| Fonte | Sezione |
|---|---|
| Goal e filtro idee (`coach-chiarire`) | 1. Perché, indicatore |
| Sintesi del time audit (`artefatti/time-audit/`) | 1. Costo oggi |
| Scheda processo (`artefatti/processi/`) | 3. Flusso, 8. Eccezioni |
| Scheda automazione (`artefatti/automazioni/`) | 2. Gradino e soluzione, 9. Controllo umano, 10. Rischio, 12. Chi mantiene |

## Come si lavora

È lavoro in modalità consulente: dichiaralo. Scrivi una bozza con quello che c'è, poi chiedi solo quello che manca, una domanda per volta, partendo dalle sezioni obbligatorie. Quello che il cliente non sa resta in DOMANDE APERTE: non lo inventi. Se tocca dati personali, decisioni su persone o fondi, apri `../coach-automazione/a04-rischi-dati-persone.md` prima della sezione 10.

Due lettori insieme: una persona che costruisce e un modello che costruisce. Ogni requisito è una frase sola, verificabile, numerata. Ogni input e output ha un esempio reale, anonimizzato. Non scegli lo strumento al posto del cliente: se non l'ha deciso, va tra le domande aperte. Non scrivi cose che il sistema "potrebbe" fare: o è dentro, o è fuori.

## Versione rapida (20 minuti)

Sezioni obbligatorie: 0, 1, 3, 6, 8, 9, 11. Le altre restano con la nota "da completare prima di costruire". Una requisitazione rapida ha stato `bozza` e non passa a `da costruire`.

## Quando è pronta

Lo stato passa da `bozza` a `da costruire` solo con il sì del cliente e quando: la sezione 0 dice `procedi`; DOMANDE APERTE è vuota; ogni requisito R ha almeno un criterio di accettazione; ogni eccezione E ha un comportamento; c'è un nome in CHI MANTIENE; c'è almeno un caso di prova reale. Poi `r03-consegna-agenti.md`.

## Modello (salva in `artefatti/requisiti/[nome].md`)

Stesso `[nome]` delle schede di processo e di automazione della stessa attività, se ci sono. Intestazione comune: `../coach-processi/m07-template-processo.md`.

```
---
tipo: requisiti
titolo: [verbo + oggetto]
stato: bozza
versione: 0.1
creata: AAAA-MM-GG
aggiornata: AAAA-MM-GG
collegata a: processi/[nome].md · automazioni/[nome].md · time-audit/[...] · goal [G..]
---

# REQUISITI · [verbo + oggetto]

## 0. Filtro
Se non lo fai: [...]
Si può fare con meno: [...]
Indicatore che sposta: [...]
Serve o piace costruirlo: [...]
Esito: procedi / semplifica / elimina · deciso dal cliente il AAAA-MM-GG

## 1. Perché
Problema oggi: [...]
Costo oggi: [n/mese] × [min] = [h/mese] (dalla scheda)
Risultato atteso: [...]
Indicatore di successo: [misura] da [valore oggi] a [valore atteso] entro [data di rimisura]

## 2. Perimetro
Dentro: [...]
Fuori, esplicitamente: [...]
Gradino: [dalla scheda di automazione, se c'è] · soluzione: [flusso a regole / flusso con un passaggio LLM / agente / strumento / processo] · strumento: [deciso dal cliente, oppure "da decidere"]

## 3. Flusso
Parte quando: [evento, orario o persona che lo avvia]
P1. [verbo + oggetto] · tipo: regola / LLM / umano · sistema: [...]
P2. [...]
Finisce quando: [output prodotto e dove arriva]

## 4. Input
| nome | da dove | formato | obbligatorio | esempio |
|---|---|---|---|---|

## 5. Output
| nome | dove va | formato | chi lo riceve | esempio |
|---|---|---|---|---|

## 6. Requisiti
R1. Il sistema [fa cosa] quando [condizione].
R2. [...]

## 7. Regole e passaggi LLM
Regole: D1. Se [condizione] allora [azione].
Per ogni passaggio LLM: cosa deve fare · cosa non deve fare mai · formato dell'output · controllo a regole sull'output (formato, campi obbligatori, valori ammessi) · cosa succede se il controllo fallisce

## 8. Eccezioni
E1. [input mancante / formato sbagliato / LLM incerto / sistema non raggiungibile / caso nuovo] → [cosa fa il sistema, chi viene avvisato]

## 9. Controllo umano
Chi approva: [...] · cosa: [...] · prima di quale azione: [...]
Revisione a campione: [quanti casi, ogni quanto, chi]

## 10. Dati e rischi
Dati personali: sì/no · quali · dove stanno · chi li vede (vedi a04)
Costo dell'errore: basso / medio / alto · visibilità: subito / tardi
Log: [cosa si registra, dove, per quanto]

## 11. Criteri di accettazione
A1 (R1). Dato [input], quando [evento], allora [risultato atteso].
A2 (E1). [...]
Casi di prova: [almeno uno reale, anonimizzato, con input e output attesi]

## 12. Manutenzione
Chi mantiene: [nome o ruolo]
Cosa cambia di solito: [regole del fondo, formati, sistemi]
Allarme: [chi viene avvisato se si ferma]
Procedura manuale di riserva: [dove è scritta]

## 13. Domande aperte
- [...]

## Consegna
[brief per chi costruisce, scritto con r03]
```

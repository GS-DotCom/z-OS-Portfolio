# Totale dei movimenti bancari per sportello

**Obiettivo:** partendo da un file di movimenti bancari (un record per operazione),
ottenere un dataset con **un solo record per sportello** contenente il totale
dei movimenti registrati: l'equivalente batch di un `GROUP BY` con `SUM` in SQL.

**Tecnologie:** JCL, DFSORT (`INREC`, `SORT`, `SUM FIELDS`), IDCAMS

---

## Layout del record in input

| Campo              | Posizione | Lungh. | Tipo |
|--------------------|-----------|--------|------|
| Codice transazione | 1         | 3      | CH   |
| Codice utente      | 4         | 3      | CH   |
| Codice sportello   | 7         | 3      | CH   |
| Movimento bancario | 10        | 7      | ZD   |
| Data transazione   | 17        | 10     | CH   |

## Layout del record in output (LRECL 15)

| Campo              | Posizione | Lungh. | Tipo |
|--------------------|-----------|--------|------|
| Codice sportello   | 1         | 3      | CH   |
| *(spazio)*         | 4         | 1      |      |
| Totale movimenti   | 5         | 11     | ZD   |

---

## Step del job

1. **STEPDEL (IDCAMS)**: cancellazione preventiva dell'output, così il job si può
   rieseguire senza errori di dataset già esistente.
2. **STEPSUM (SORT)**:
   - `INREC` costruisce un record ridotto con i soli campi utili: codice sportello
     e importo, quest'ultimo allungato a 11 cifre anteponendo `0000`;
   - `SORT` ordina per codice sportello;
   - `SUM FIELDS` somma gli importi dei record con la stessa chiave e ne lascia uno solo.

`INREC` agisce **prima** dell'ordinamento: il sort lavora su record di 15 byte
invece che su quelli completi, e la somma avviene già sul campo allargato.

---

## Scelte e difficoltà

**Spazio per la somma.** Un campo di 7 cifre può contenere un singolo movimento,
ma non necessariamente il totale di decine di movimenti. Gli zeri aggiunti con
`INREC` danno al campo la capienza necessaria ed evitano l'overflow
(che DFSORT segnala lasciando i record non sommati).

**Il bug che i dati nascondevano.** Nella prima versione il campo riformattato
occupava 9 byte, ma la somma era dichiarata su 7 (`SUM FIELDS=(4,7,ZD)`):
venivano sommate solo le prime cifre e le ultime due restavano quelle del primo
record di ogni gruppo. Il risultato coincideva comunque con quello atteso perché
**tutti gli importi di test terminavano con `00`**, quindi l'errore non si vedeva.
Con dati diversi i totali sarebbero stati sbagliati. Nella versione attuale
la posizione e la lunghezza di `SUM` coincidono esattamente con il campo
costruito da `INREC`.

*Lezione:* un risultato corretto sui dati di test non dimostra che la logica sia
corretta; vanno sempre verificate posizioni e lunghezze dei campi.

**Segno dei campi ZD.** Sommando campi zoned decimal, DFSORT può scrivere
il segno nell'ultima cifra (che apparirebbe come una lettera, es. `{` o `A`).
Se succede, si aggiunge `OPTION ZDPRINT` per ottenere cifre leggibili.

---

## Risultato

- RC=0000 su entrambi gli step
- 22 record in output, uno per sportello, ordinati per codice

<!-- Incolla qui le prime righe dell'output dopo aver rieseguito il job corretto, es.:
A01 000XXXXXXXX
A02 000XXXXXXXX
...
-->

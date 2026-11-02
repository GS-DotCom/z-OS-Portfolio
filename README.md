# zos-portfolio

Esercizi pratici su **IBM z/OS** svolti durante il mio percorso di formazione come
**z/OS System Administrator** (2026): elaborazione batch con JCL e DFSORT,
database DB2 e SQL, automazione con REXX e, in corso, programmazione COBOL.

Ogni esercizio è documentato come un piccolo caso reale: obiettivo, layout dei dati,
step del job, scelte tecniche, difficoltà incontrate e risultato ottenuto.

---

## Competenze trattate nel percorso

| Area | Argomenti |
|---|---|
| **JCL & DFSORT** | job multi-step, allocazione e gestione dataset, filtri `INCLUDE`, ordinamenti su più chiavi, `OUTFIL`, `OUTREC IFTHEN`, `MERGE`, report con `ICETOOL` |
| **DB2 & SQL** | modellazione di relazioni uno-a-molti e molti-a-molti, chiavi esterne e indici, query di reportistica, utility `UNLOAD`, `LOAD`, `RUNSTATS`, `REORG`, `COPY`/`RECOVER` |
| **REXX** | script TSO con parametri, `LISTCAT`, data stack (`MAKEBUF`, `PUSH`/`QUEUE`, `PULL`), compound variables |
| **COBOL** | *in corso*: programmi batch su dataset sequenziali e DB2 |

---

## Indice degli esercizi

### JCL & DFSORT
| Esercizio | Descrizione | Strumenti |
|---|---|---|
| [07-gdg-generazioni](jcl-dfsort/07-gdg-generazioni) | Creazione e gestione di un Generation Data Group: definizione della base, nuova generazione a ogni esecuzione, cancellazione | IDCAMS `DEFINE GDG`, IEFBR14, `LISTCAT` |
| [08-somma-movimenti-sportello](jcl-dfsort/08-somma-movimenti-sportello) | Totale dei movimenti bancari per sportello | DFSORT `INREC`, `SUM FIELDS` |

*In arrivo: job multi-step con ICETOOL, filtri con `OUTFIL`, `OUTREC IFTHEN`, `MERGE`.*

### DB2 & SQL
*In arrivo: modellazione di un database con relazioni 1-a-molti e molti-a-molti,
query di reportistica, utility `UNLOAD`/`LOAD` e manutenzione di un tablespace.*

### REXX
*In arrivo: report su dataset con `LISTCAT`, gestione ordini con il data stack.*

### COBOL
*Sezione in costruzione: verrà aggiornata man mano con i programmi sviluppati.*

---

## Struttura di ogni esercizio

```
nome-esercizio/
├── README.md        ← obiettivo, layout dei record, step, scelte, risultato
├── *.jcl            ← job (o *.rexx / *.sql / *.cbl)
└── input-layout.md  ← tracciato record (dove serve)
```

Ogni README segue lo stesso schema:

1. **Obiettivo**: cosa deve fare il job o lo script
2. **Layout dei dati**: posizione, lunghezza e tipo di ogni campo
3. **Step / logica**: cosa fa ogni step e perché
4. **Scelte e difficoltà**: i punti in cui ho dovuto ragionare (es. `RECFM=VB` per i report ICETOOL, input ordinato per `OCCUR`)
5. **Risultato**: return code ed estratto essenziale del SYSOUT

---

## Ambiente e strumenti

- **Sistema:** IBM z/OS (ambiente di formazione), DB2 for z/OS
- **Interfacce:** TSO/ISPF, SDSF per il monitoraggio dei job, SPUFI per SQL
- **Strumenti moderni:** VS Code con Zowe Explorer e Zowe CLI per scaricare i membri dei PDS e versionarli con Git

---

## Note

- Gli **high-level qualifier** reali sono stati sostituiti con il segnaposto `USERID`
  (es. `USERID.BANCA.ACCREDITI`): per eseguire i job basta sostituirlo con il proprio.
- I **dati di esempio** sono inventati; le tracce degli esercizi sono riformulate con parole mie.
- Nessun riferimento a sistemi, utenze o configurazioni reali è incluso nel repository.

---

## Altri progetti

- **[mainframe-bridge-api](../mainframe-bridge-api)**: Web API .NET che importa un dataset
  a record fisso prodotto su z/OS, lo salva su SQL Server e lo espone via REST.
  *(in sviluppo)*

---

## Contatti

**Giuliano Simone** · Sviluppatore · Sistemista IT · Roma
[LinkedIn](https://www.linkedin.com/in/giuliano-simone-713196358/)

Traccia Esercizio:

---

Esercizio GDG – JCL per creazione e gestione di un GDG.

Scrivi un job che con l’utility IDCAMS vada a creare il contenitore per un dataset GDG che dovrà avere le seguenti caratteristiche:

Dataset name: USERID.MYGDG.TEST1

Massimo numero di generazioni: 5

Deve scatalogare tutte le vecchie generazioni quando il limite è raggiunto ma senza cancellarle definitivamente dalla memoria.



Successivamente attraverso l’utility IEFBR14, sviluppa un secondo job che vada a creare una generazione per il dataset GDG ad ogni esecuzione e verificare che questo avvenga correttamente. Infine controllare la loro scatalogazione al raggiungimento del limite (5).  In sostanza, eseguendo il job per la sesta volta dovrai vedere nella dslist solo la sesta generazione mentre le 5 precedenti dovranno essere scatalogate. Per ogni generazione prevedere una lunghezza record di 80 bytes e utilizzare il disco ZAPRD7.



Terminare l’esercizio facendo un terzo job che vada a cancellare dalla memoria il GDG nella sua totalità (sia il base che le generazioni catalogate) attarverso l’utility IDCAMS (le versioni scatalogate rimarranno in memoria ma inutilizzabili). 

Per eseguire questo esericizio consultare manuali online e siti specializzati nell’utilizzo del JCL, saranno molto apprezzati il Problem Solving e l’autonomia del discente nell’esecuzione di questo task.

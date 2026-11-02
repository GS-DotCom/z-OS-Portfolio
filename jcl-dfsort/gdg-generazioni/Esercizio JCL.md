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




\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* SVOLGIMENTO \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*





JOB 1



\*\*\*\*\*\* \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Top of Data \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

&#x20;000001 //JCL1113L JOB (ACADEMY,2026),'ETL',NOTIFY=\&SYSUID,CLASS=D,             

&#x20;000002 //       MSGCLASS=T,MSGLEVEL=(1,1)                                      

&#x20;000003 //\*\*\*\*\*\*\*\*\*\* STEP CREAZIONE GDG \*\*\*\*\*\*\*\*                                

&#x20;000004 //STEPDEF  EXEC PGM=IDCAMS                                              

&#x20;000005 //SYSPRINT DD SYSOUT=\*                                                  

&#x20;000006 //SYSIN    DD \*                                                         

&#x20;000007   DEFINE GDG-                                                           

&#x20;000008   (NAME(ADCDL.MYGDG.TEST1)-                                             

&#x20;000009   EMPTY-                                                                

&#x20;000010   NOSCRATCH-                                                            

&#x20;000011   LIMIT(5))                                                             

&#x20;000012 /\*                    



JOB 2

&#x20;\*\*\*\*\*\* \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Top of Data \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

&#x20;000001 //GNG1113 JOB (ACADEMY,2026),'ETL',NOTIFY=\&SYSUID,CLASS=D,              

&#x20;000002 //       MSGCLASS=T,MSGLEVEL=(1,1)                                      

&#x20;000003 //\*\*\*\*\*\*\*\*\*\*\* CREAZIONE DATASET GENERAZIONALE \*\*\*\*\*\*\*\*\*                 

&#x20;000004 //DSGEN    EXEC PGM=IEFBR14                                                                                     

&#x20;000006 //GDG01    DD DSN=ADCDL.MYGDG.TEST1(+1),DISP=(NEW,CATLG,DELETE),        

&#x20;000007 //            SPACE=(TRK,(1,1),RLSE),                                   

&#x20;000008 //            UNIT=SYSDA,                                               

&#x20;000009 //            VOL=SER=ZAPRD7,                                           

&#x20;000010 //            DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)                                                                      

&#x20;\*\*\*\*\*\* \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Bottom of Data \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*



JOB 3

\*\*\*\*\*\* \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Top of Data \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

000001 //GNG1113D JOB (ACADEMY,2026),'ETL',NOTIFY=\&SYSUID,CLASS=D,             

000002 //       MSGCLASS=T,MSGLEVEL=(1,1)                                      

000003 //\*\*\*\*\*\*\*\*\* CANCELLAZIONE DSCAM GDG BASE \*\*\*\*\*\*\*\*\*\*\*\*                   

000004 //STEPDEL  EXEC PGM=IDCAMS                                              

000005 //SYSPRINT DD SYSOUT=\*                                                  

000006 //SYSIN    DD \*                                                         

000007   DELETE ADCDL.MYGDG.TEST1 GDG FORCE                                    

000008   SET LASTCC=0                                                          

000009   SET MAXCC=0                                                           

000010 /\*                                                                      

\*\*\*\*\*\* \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* Bottom of Data \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*




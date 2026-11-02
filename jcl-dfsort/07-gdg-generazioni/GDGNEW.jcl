//GDGNEW   JOB (ACCT),'NUOVA GENERAZIONE',CLASS=A,MSGCLASS=X,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*------------------------------------------------------------
//* JOB 2 - CREA UNA NUOVA GENERAZIONE (+1) A OGNI ESECUZIONE
//*  ALLA SESTA ESECUZIONE, GRAZIE A EMPTY, LE 5 GENERAZIONI
//*  PRECEDENTI VENGONO SCATALOGATE: IN 3.4 RESTA VISIBILE
//*  SOLO L'ULTIMA GENERAZIONE CREATA.
//*  NOTA: NEL CORSO ERA INDICATO ANCHE VOL=SER=<DISCO>,
//*  OMESSO QUI PERCHE' DIPENDE DAL SISTEMA.
//*------------------------------------------------------------
//STEPGEN  EXEC PGM=IEFBR14
//GDGOUT   DD DSN=USERID.MYGDG.TEST1(+1),
//            DISP=(NEW,CATLG,DELETE),
//            UNIT=SYSDA,
//            SPACE=(TRK,(1,1),RLSE),
//            DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)
//*------------------------------------------------------------
//* VERIFICA: ELENCO DELLA BASE GDG E DELLE GENERAZIONI
//*------------------------------------------------------------
//STEPLIST EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  LISTCAT ENTRIES(USERID.MYGDG.TEST1) ALL
/*

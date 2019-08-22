/*********************************************************************************
 ** APPLICATION   : ULTRAFUNDS                                                  **
 ** AUTHOR        : SRAVAN(SDD)                                                 **
 ** DATE          : 27/06/2019                                                  **
 ** FILENAME      : C_OPERATION_FEE.sql                                         **
 ** DESCRIPTION   : TABLE SCRIPT FOR DEV. ON OPERATION FEE, REF: FRD-321        **
 ********************************************************************************/

Prompt Droping Table Cascade OPERATION_FEE...
DROP TABLE OPERATION_FEE CASCADE CONSTRAINTS;

Prompt Dropping Public Synonym OPERATION_FEE...
DROP PUBLIC SYNONYM OPERATION_FEE;

CREATE TABLE OPERATION_FEE
(
  NPTF                   VARCHAR2(10)     NOT NULL,
  XLIBELLE               VARCHAR2(100),
  ACCRUAL_METHOD         VARCHAR2(10)     NOT NULL,
  FEE_TYPE               VARCHAR2(4)      NOT NULL,
  FEE_TYPE_DESC          VARCHAR2(80),
  CALC_CODE              VARCHAR2(2),
  EFFECTIVE_DATE         DATE             NOT NULL,
  END_DATE               DATE             NOT NULL,
  FEE_RATE               NUMBER(14,6),
  FEE_FORMULA_BASIS      VARCHAR2(2000),
  FEE_FORMULA            VARCHAR2(2000)   NOT NULL,
  NAV_CODE               VARCHAR2(3),
  SUB_TYPE               VARCHAR2(4),
  STATUS                 VARCHAR2(2),
  CREATED_BY             VARCHAR2(30),
  DCREATED               DATE,
  UPDATED_BY             VARCHAR2(30),
  DUPDATED               DATE
)
tablespace DAT_STATICS_1;


PROMPT Create Index I_OPERATION_FEE$PRIM...
CREATE UNIQUE INDEX I_OPERATION_FEE$PRIM ON OPERATION_FEE
(NPTF, FEE_TYPE, EFFECTIVE_DATE)
LOGGING
TABLESPACE IDX_STATICS_1;


PROMPT  Create trigger BIUT_OPERATION_FEE BEFORE INSERT OR UPDATE...
CREATE OR REPLACE TRIGGER BIUT_OPERATION_FEE
  BEFORE INSERT OR UPDATE
  ON  OPERATION_FEE
  FOR EACH ROW
BEGIN
  IF INSERTING  THEN
    :NEW.DCREATED     := SYSDATE;
    :NEW.CREATED_BY   := USER;
  ELSE
    :NEW.DUPDATED     := SYSDATE;
    :NEW.UPDATED_BY   := USER;
  END IF;

END;
/

SHOW ERRORS
/

﻿
ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" DROP CONSTRAINT "SYS_C0040459"
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" DROP CONSTRAINT "SYS_C0040458"
/

ALTER TABLE "ITABLE_CONSTRAINTS_REF_COLUMNS" DROP CONSTRAINT "IT_CON_REF_COLS"
/

DROP INDEX "DIMGR"."XPKINTER_TABLE_CONSTRAINTS_REF"
/

DROP INDEX "DIMGR"."XIF2INTER_TABLE_CONSTRAINTS_RE"
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" DROP CONSTRAINT "SYS_C0040435"
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS" DROP CONSTRAINT "SYS_C0040437"
/


ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" DROP CONSTRAINT "SYS_C0040458"
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS" DROP CONSTRAINT "IT_CON_HAS_TYPE"
/
CREATE TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS_DF7729"(
  "OWNER" Varchar2(30 ) NOT NULL,
  "TABLE_NAME" Varchar2(30 ) NOT NULL,
  "CONSTRAINT_NAME" Varchar2(50 ),
  "CONSTRAINT_DESC" Varchar2(500 ),
  "CONSTRAINT_VALIDATION_QRY" Clob,
  "TYPE" Varchar2(20 )
)
/
INSERT INTO "DIMGR"."INTER_TABLE_CONSTRAINTS_DF7729" ("CONSTRAINT_NAME", "CONSTRAINT_DESC", "CONSTRAINT_VALIDATION_QRY", "TYPE") SELECT "CONSTRAINT_NAME", "CONSTRAINT_DESC", "CONSTRAINT_VALIDATION_QRY", "TYPE" FROM "DIMGR"."INTER_TABLE_CONSTRAINTS"
/



DROP TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS"
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS_DF7729" RENAME TO "INTER_TABLE_CONSTRAINTS"
/


ALTER TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS" MODIFY ("CONSTRAINT_NAME" CONSTRAINT "SYS_C0040436" NOT NULL)
/

CREATE INDEX "DIMGR"."XIF1INTER_TABLE_CONSTRAINTS" ON "DIMGR"."INTER_TABLE_CONSTRAINTS" ("TYPE")
/

CREATE UNIQUE INDEX "DIMGR"."XPKINTER_TABLE_CONSTRAINTS" ON "DIMGR"."INTER_TABLE_CONSTRAINTS" ("CONSTRAINT_NAME")
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS" ADD CONSTRAINT "SYS_C0040437" PRIMARY KEY ("OWNER","TABLE_NAME","CONSTRAINT_NAME")
   USING INDEX "DIMGR"."XPKINTER_TABLE_CONSTRAINTS"
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" ADD
(
   "REF_OWNER" Varchar2(30 ) NOT NULL,
   "REF_TABLE_NAME" Varchar2(30 ) NOT NULL
)
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" ADD CONSTRAINT "SYS_C0040435" PRIMARY KEY ("CONSTRAINT_NAME","OWNER","TABLE_NAME","REF_OWNER","REF_TABLE_NAME")
   USING INDEX "DIMGR"."XPKINTER_TABLE_CONSTRAINTS_REF"
/
CREATE INDEX "DIMGR"."XIF2INTER_TABLE_CONSTRAINTS_RE" ON "DIMGR"."INTER_TABLE_CONS_REF_TABLES" ()
/
CREATE UNIQUE INDEX "DIMGR"."XPKINTER_TABLE_CONSTRAINTS_REF" ON "DIMGR"."INTER_TABLE_CONS_REF_TABLES" ("CONSTRAINT_NAME")
/
ALTER TABLE "ITABLE_CONSTRAINTS_REF_COLUMNS" ADD CONSTRAINT "IT_CON_REF_COLS" FOREIGN KEY ("OWNER", "TABLE_NAME", "CONSTRAINT_NAME") REFERENCES "DIMGR"."INTER_TABLE_CONSTRAINTS" ("OWNER", "TABLE_NAME", "CONSTRAINT_NAME")
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" ADD CONSTRAINT "ITCON_REF_TABLES" FOREIGN KEY ("OWNER", "TABLE_NAME", "CONSTRAINT_NAME") REFERENCES "DIMGR"."INTER_TABLE_CONSTRAINTS" ("OWNER", "TABLE_NAME", "CONSTRAINT_NAME")
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" ADD CONSTRAINT "TBL_ISREFBY_ITCON_REFT" FOREIGN KEY ("REF_OWNER", "REF_TABLE_NAME") REFERENCES "DIMGR"."TABLES" ("OWNER", "TABLE_NAME")
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS" ADD CONSTRAINT "TBL_ISREFBY_ITCON" FOREIGN KEY ("OWNER", "TABLE_NAME") REFERENCES "DIMGR"."TABLES" ("OWNER", "TABLE_NAME")
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" MODIFY ("OWNER" NULL)
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" MODIFY ("OWNER" NOT NULL)
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" MODIFY ("TABLE_NAME" NULL)
/
ALTER TABLE "DIMGR"."INTER_TABLE_CONS_REF_TABLES" MODIFY ("TABLE_NAME" NOT NULL)
/

ALTER TABLE "DIMGR"."INTER_TABLE_CONSTRAINTS" ADD CONSTRAINT "IT_CON_HAS_TYPE" FOREIGN KEY ("TYPE") REFERENCES "DIMGR"."CONSTRAINT_TYPES" ("TYPE") ON DELETE SET NULL
/
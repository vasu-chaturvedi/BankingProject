CREATE OR REPLACE TYPE scheme_rec IS object (
    FIN_SCHEME_CODE    VARCHAR2(5),
    INT_TBL_CODE       VARCHAR2(5),
    GL_SUB_HEAD_CODE   VARCHAR2(5),
    STAFF_FLG          CHAR(1)
  );
/

create OR REPLACE type tda_dep_period_rec is object (
    DEP_MONTHS  VARCHAR2(5),
    DEP_DAYS    VARCHAR2(3)
);
/

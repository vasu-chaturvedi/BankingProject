CREATE OR REPLACE PACKAGE CasaPack AS
--{
    PROCEDURE CS001(InpSolId IN VARCHAR2);
    PROCEDURE CS002(InpSolId IN VARCHAR2);
    PROCEDURE CS003(InpSolId IN VARCHAR2);
    PROCEDURE CS004(InpSolId IN VARCHAR2);
    PROCEDURE CS005(InpSolId IN VARCHAR2);
    PROCEDURE CS006(InpSolId IN VARCHAR2);
    PROCEDURE CS007(InpSolId IN VARCHAR2);
    PROCEDURE CS008(InpSolId IN VARCHAR2);
    PROCEDURE CS009(InpSolId IN VARCHAR2);
    --PROCEDURE CS011(InpSolId IN VARCHAR2);
    PROCEDURE CS014(InpSolId IN VARCHAR2);
    PROCEDURE CS015(InpSolId IN VARCHAR2);
    PROCEDURE CS016(InpSolId IN VARCHAR2);
    PROCEDURE CS019(InpSolId IN VARCHAR2);
--}
END CasaPack;
/

CREATE OR REPLACE PACKAGE BODY MOCKSTG.CasaPack AS
--{
    PROCEDURE CS001 (InpSolId IN VARCHAR2) IS
    --{
        v_fin_yr_start_dt				  date:='';
        v_fin_yr_start_dt1				  date:='';
        V_ACCOUNT_NumBER                                  Numeric(16) := '';
        V_WITHHOLDING_TAX_FLAG                            NVarchar2(1) := '';
        V_WITHHOLDING_TAX_AMT_SCOPE_FLAG                  NVarchar2(1) := '';
        V_WITHHOLDING_TAX_PERCENT                         NVarchar2(8) := '';
        V_WITHHOLDING_TAX_FLOOR_LIMIT                     Numeric(14,2) := '';
        V_CIF_ID                                          numeric(32) := '';
        V_CUSTOMER_CREDIT_PREF                            NVarchar2(10) := '';
        V_CUSTOMER_DEBIT_PREF                             NVarchar2(10) := '';
        V_ACCOUNT_CREDIT_PREF                             NVarchar2(10) := '';
        V_ACCOUNT_DEBIT_PREF                              NVarchar2(10) := '';
        V_CHANNEL_CREDIT_PREF                             NVarchar2(10) := '';
        V_CHANNEL_DEBIT_PREF                              NVarchar2(10) := '';
        V_PEGGED_FLAG                                     NVarchar2(1) := '';
        V_PEG_FREQUENCY_IN_MONTHS                         NVarchar2(4) := '';
        V_PEG_FREQUENCY_IN_DAYS                           NVarchar2(3) := '';
        V_INT_FREQ_TYPE_CREDIT                            NVarchar2(1) := '';
        V_INT_FREQ_WEEK_NUM_CREDIT                        NVarchar2(1) := '';
        V_INT_FREQ_WEEK_DAY_CREDIT                        NVarchar2(1) := '';
        V_INT_FREQ_START_DD_CREDIT                        NVarchar2(2) := '';
        V_INT_FREQ_HLDY_STAT_CREDIT                       NVarchar2(1) := '';
        V_NEXT_CREDIT_INTEREST_RUN_DATE                   NVarchar2(10) := '';
        V_INT_FREQ_TYPE_DEBIT                             NVarchar2(1) := '';
        V_INT_FREQ_WEEK_NUM_DEBIT                         NVarchar2(1) := '';
        V_INT_FREQ_WEEK_DAY_DEBIT                         NVarchar2(1) := '';
        V_INT_FREQ_START_DD_DEBIT                         NVarchar2(2) := '';
        V_INT_FREQ_HLDY_STAT_DEBIT                        NVarchar2(1) := '';
        V_NEXT_DEBIT_INTEREST_RUN_DATE                    Date         := '';
        V_LEDGER_Number                                   NVarchar2(3) := '';
        V_EMPLOYEE_ID                                     NVarchar2(10) := '';
        V_ACCOUNT_OPEN_DATE                               Date         := '';
        V_MODE_OF_OPERATION_CODE                          NVarchar2(5) := '';
        V_GL_SUB_HEAD_CODE                                NVarchar2(5) := '';
        V_SCHEME_CODE                                     NVarchar2(5) := '';
        V_CHEQUE_ALLOWED_FLAG                             NVarchar2(1) := '';
        V_PASS_BOOK                                       NVarchar2(1) := '';
        V_FREEZE_CODE                                     NVarchar2(1) := '';
        V_FREEZE_REASON_CODE                              NVarchar2(5) := '';
        V_FREE_TEXT                                       NVarchar2(240) := '';
        V_ACCOUNT_DORMANT_FLAG                            NVarchar2(1) := '';
        V_FREE_CODE_1                                     NVarchar2(5) := '';
        V_FREE_CODE_2                                     NVarchar2(5) := '';
        V_FREE_CODE_3                                     NVarchar2(5) := '';
        V_FREE_CODE_4                                     NVarchar2(5) := '';
        V_FREE_CODE_5                                     NVarchar2(5) := '';
        V_FREE_CODE_6                                     NVarchar2(5) := '';
        V_FREE_CODE_7                                     NVarchar2(5) := '';
        V_FREE_CODE_8                                     NVarchar2(5) := '';
        V_FREE_CODE_9                                     NVarchar2(5) := '';
        V_FREE_CODE_10                                    NVarchar2(5) := '';
        V_INTEREST_TABLE_CODE                             NVarchar2(5) := '';
        V_ACCOUNT_LOCATION_CODE                           NVarchar2(5) := '';
        V_CURRENCY_CODE                                   NVarchar2(3) := '';
        V_SERVICE_OUTLET                                  NVarchar2(8) := '';
        V_ACCOUNT_MGR_USER_ID                             NVarchar2(15) := '';
        V_ACCOUNT_NAME                                    NVarchar2(80) := '';
        V_SWIFT_ALLOWED_FLG                               NVarchar2(1) := '';
        V_LAST_TRANSACTION_DATE                           Date         := '';
        V_LAST_TRANSACTION_ANY_DATE                       Date         := '';
        V_EXCLUDE_FOR_COMBINED_STATEMENT                  NVarchar2(1) := '';
        V_STATEMENT_CUSTOMER_ID                           NVarchar2(32) := '';
        V_CHARGE_LEVEL_CODE                               NVarchar2(5) := '';
        V_PBF_DOWNLOAD_FLAG                               NVarchar2(1) := '';
        V_WTAX_LEVEL_FLG                                  NVarchar2(1) := '';
        V_SANCTION_LIMIT                                  Numeric(14,2) := '';
        V_DRAWING_POWER                                   Numeric(14,2) := '';
        V_DACC_ABSOLUTE_LIMIT                             Numeric(14,2) := '';
        V_DACC_PERCENT_LIMIT                              Numeric(8) := '';
        V_MAXIMUM_ALLOWED_LIMIT                           Numeric(14,2) := '';
        V_HEALTH_CODE                                     NVarchar2(5) := '';
        V_SANCTION_LEVEL_CODE                             NVarchar2(5) := '';
        V_SANCTION_REFERENCE_Number                       NVarchar2(25) := '';
        V_LIMIT_SANCTION_DATE                             Date         := '';
        V_LIMIT_EXPIRY_DATE                               Date         := '';
        V_ACCOUNT_REVIEW_DATE                             Date         := '';
        V_LOAN_PAPER_DATE                                 Date         := '';
        V_SANCTION_AUTHORITY_CODE                         NVarchar2(5) := '';
        V_LAST_COMPOUND_DATE                              Date         := '';
        V_DAILY_COMP_OF_INTEREST_FLAG                     NVarchar2(1) := '';
        V_COMP_REST_DAY_FLAG                              NVarchar2(1) := '';
        V_USE_DISCOUNT_RATE_FLG                           NVarchar2(1) := '';
        V_DUMMY                                           NVarchar2(100) := '';
        V_ACCOUNT_STATUS_DATE                             Date         := '';
        V_IBAN_Number                                     NVarchar2(34) := '';
        V_IAS_CODE                                        NVarchar2(5) := '';
        V_CHANNEL_ID                                      NVarchar2(5) := '';
        V_CHANNEL_LEVEL_CODE                              NVarchar2(5) := '';
        V_INT_SUSPENSE_AMT                                NVarchar2(17) := '';
        V_PENAL_INT_SUSPENSE_AMT                          NVarchar2(17) := '';
        V_CHRGE_OFF_FLG                                   NVarchar2(1) := '';
        V_PD_FLG                                          NVarchar2(1) := '';
        V_PD_XFER_DATE                                    Date        := '';
        V_CHRGE_OFF_DATE                                  Date        := '';
        V_CHRGE_OFF_PRINCIPAL                             Numeric(14,2) := '';
        V_PENDING_INTEREST                                Numeric(14,2) := '';
        V_PRINCIPAL_RECOVERY                              Numeric(14,2) := '';
        V_INTEREST_RECOVERY                               Numeric(14,2) := '';
        V_CHARGE_OFF_TYPE                                 NVarchar2(1) := '';
        V_MASTER_ACCT_NUM                                 NVarchar2(16) := '';
        V_PS_DIFF_FREQ_REL_PARTY_FLG                      NVarchar2(1) := '';
        V_SWIFT_DIFF_FREQ_REL_PARTY_FLG                   NVarchar2(1) := '';
        V_ADDRESS_TYPE                                    NVarchar2(12) := '';
        V_PHONE_TYPE                                      NVarchar2(12) := '';
        V_EMAIL_TYPE                                      NVarchar2(12) := '';
        V_ALTERNATE_ACCOUNT_NAME                          NVarchar2(80) := '';
        V_INTEREST_RATE_PERIOD_MONTHS                     NVarchar2(4) := '';
        V_INTEREST_RATE_PERIOD_DAYS                       NVarchar2(3) := '';
        V_INTERPOLATION_METHOD                            NVarchar2(1) := '';
        V_IS_ACCOUNT_HEDGED_FLAG                          NVarchar2(1) := '';
        V_USED_FOR_NETTING_OFF_FLAG                       NVarchar2(1) := '';
        V_SECURITY_INDICATOR                              NVarchar2(10) := '';
        V_DEBT_SECURITY                                   NVarchar2(1) := '';
        V_SECURITY_CODE                                   NVarchar2(8) := '';
        V_DEBIT_INTEREST_METHOD                           NVarchar2(1) := '';
        V_SERVICE_CHARGE_COLLECTION_FLAG                  NVarchar2(1) := '';
        V_LAST_PURGE_DATE                                 Date         := '';
        V_TOTAL_PROFIT_AMOUNT                             Numeric(14,2) := '';
        V_MINIMUM_AGE_NOT_MET_AMOUNT                      Numeric(14,2) := '';
        V_BROKEN_PERIOD_PROFIT_PAID_FLAG                  NVarchar2(1) := '';
        V_BROKEN_PERIOD_PROFIT_AMOUNT                     Numeric(14,2) := '';
        V_PROFIT_TO_BE_RECOVERED                          Numeric(14,2) := '';
        V_PROFIT_DISTRIBUTED_UPTO_DATE                    Date        := '';
        V_NEXT_PROFIT_DISTRIBUTED_DATE                    Date        := '';
        V_ACRD_AMT_TILL_INT_CALC_DATE_CR                  NVarchar2(17) := '';
        V_ACID                                            NVarchar2(11) := '';
        V_NEG_CR_INT_ALLOWED_FLG                          NVarchar2(1) := '';
        V_UNCLAIM_STATUS                                  NVarchar2(1) := '';
        V_UNCLAIM_STATUS_DATE                             Date         := '';
        V_GL_SUB_HEAD_CODE1                               NVarchar2(5) := '';

        V_SCHM_REC      SCHEME_REC;
        V_STAFF_FLG     CHAR(1) := '';

        CURSOR C1 (CurSolId VARCHAR2) IS
        SELECT 
            ENTITY_NUM
            ,SOL_ID
            ,INTERNAL_ACNUM
            ,CIF
            ,ACTUAL_ACNUM
            ,PROD_CODE
            ,GROUP_CODE
            ,DECODE(ACNTS_DORMANT_ACNT,1,'D',0,'A') As Account_Dormant_Flag
        FROM VALID_CASA WHERE SOL_ID = CurSolId;
        
        BEGIN
        --{
            V_WITHHOLDING_TAX_FLAG := 'T';
            V_PEGGED_FLAG := 'N';
            V_INT_FREQ_TYPE_CREDIT := 'Q';
            V_INT_FREQ_START_DD_CREDIT := '31';
            V_INT_FREQ_HLDY_STAT_CREDIT := 'P';
            V_NEXT_CREDIT_INTEREST_RUN_DATE := UTK_FN_GET_NEXT_QUARTER_END_DT;
            V_INT_FREQ_TYPE_DEBIT := 'M';
            V_INT_FREQ_START_DD_DEBIT := '31';
            V_INT_FREQ_HLDY_STAT_DEBIT := 'P';
            V_NEXT_DEBIT_INTEREST_RUN_DATE := UTK_FN_GET_NEXT_MONTH_END_DT;
            V_PASS_BOOK := 'B';
            V_FREE_CODE_3 := '003';
            V_CURRENCY_CODE := 'INR';
            V_SWIFT_ALLOWED_FLG := 'N';
            V_EXCLUDE_FOR_COMBINED_STATEMENT := 'N';
            V_DAILY_COMP_OF_INTEREST_FLAG := 'N';
            V_UNCLAIM_STATUS := 'N';

            for i in c1(InpSolId)
            loop
            --{
                V_ACCOUNT_NUMBER        := I.ACTUAL_ACNUM;
                V_CIF_ID                := I.CIF;
                V_ACCOUNT_DORMANT_FLAG  := NVL(I.ACCOUNT_DORMANT_FLAG,'A');
                V_FREEZE_CODE           := UTK_FN_CHK_ACNTFREZ_INTERNAL_ACNUM(i.internal_acnum);
                V_SERVICE_OUTLET        := I.SOL_ID;

                V_SCHM_REC := CommonExtractionPack.GetSchemeMapping('CASA',I.PROD_CODE,null,null);

                V_GL_SUB_HEAD_CODE := V_SCHM_REC.GL_SUB_HEAD_CODE;
                V_SCHEME_CODE := V_SCHM_REC.FIN_SCHEME_CODE;
                V_INTEREST_TABLE_CODE := V_SCHM_REC.INT_TBL_CODE;
                V_STAFF_FLG := V_SCHM_REC.STAFF_FLG;

                IF (V_STAFF_FLG = 'Y') THEN
                --{
                    BEGIN
                        SELECT 
                            INDCLIENT_EMPLOYEE_NUM 
                        INTO
                            V_EMPLOYEE_ID
                        FROM 
                            CBS.INDCLIENTS 
                        WHERE 
                            INDCLIENT_CODE = V_CIF_ID;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                        V_EMPLOYEE_ID := null;
                    END;
                --}
                ELSE
                --{
                    V_EMPLOYEE_ID := null;
                --}
                END IF;

                BEGIN
                    SELECT 
                        ACNTS_OPENING_DATE
                        ,decode(ACNTS_MODE_OF_OPERN,'0','1',ACNTS_MODE_OF_OPERN)
                        ,decode(acnts.ACNTS_CHQBK_REQD,'1','Y','N')
                        ,ACNTS_LOCN_CODE
                        ,ACNTS_AC_NAME1
                        ,NVL(ACNTS_NON_FIN_TRAN_DATE,ACNTS_NONSYS_LAST_DATE)
                        ,ACNTS_LAST_TRAN_DATE
                        ,ACNTS_AC_NAME2
                    INTO
                        V_ACCOUNT_OPEN_DATE
                        ,V_MODE_OF_OPERATION_CODE
                        ,V_CHEQUE_ALLOWED_FLAG
                        ,V_ACCOUNT_LOCATION_CODE
                        ,V_ACCOUNT_NAME
                        ,V_LAST_TRANSACTION_DATE
                        ,V_LAST_TRANSACTION_ANY_DATE
                        ,V_ALTERNATE_ACCOUNT_NAME
                    FROM
                        CBS.ACNTS
                    WHERE 
                        ACNTS_INTERNAL_ACNUM = I.INTERNAL_ACNUM
                    AND ACNTS_ENTITY_NUM = I.ENTITY_NUM;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_ACCOUNT_OPEN_DATE := null;
                    V_MODE_OF_OPERATION_CODE := null;
                    V_CHEQUE_ALLOWED_FLAG := null;
                    V_ACCOUNT_LOCATION_CODE := null;
                    V_ACCOUNT_NAME := null;
                    V_LAST_TRANSACTION_DATE := null;
                    V_LAST_TRANSACTION_ANY_DATE := null;
                    V_ALTERNATE_ACCOUNT_NAME := null;
                END;

                BEGIN
                    SELECT 
                        --NVL(ACNTSTATUS_EFF_DATE,ACNTSTATUS_ENTD_ON)
                        MAX(ACNTSTATUS_EFF_DATE)
                    INTO
                        V_ACCOUNT_STATUS_DATE
                    FROM
                        CBS.ACNTSTATUS
                    WHERE
                        ACNTSTATUS_INTERNAL_ACNUM = I.INTERNAL_ACNUM
                    AND ACNTSTATUS_ENTITY_NUM = I.ENTITY_NUM;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_ACCOUNT_STATUS_DATE:= V_ACCOUNT_OPEN_DATE;
                END;

                IF(V_FREEZE_CODE IS NOT NULL) THEN
                --{
                    V_FREEZE_REASON_CODE := '2';
                --}
                ELSE
                --{
                    V_FREEZE_REASON_CODE := null;
                --}
                END IF;

                INSERT INTO cs001 VALUES
                (
                    V_ACCOUNT_Number                                 ,
                    V_WITHHOLDING_TAX_FLAG                           ,
                    V_WITHHOLDING_TAX_AMT_SCOPE_FLAG                 ,
                    V_WITHHOLDING_TAX_PERCENT                        ,
                    V_WITHHOLDING_TAX_FLOOR_LIMIT                    ,
                    V_CIF_ID                                         ,
                    V_CUSTOMER_CREDIT_PREF                           ,
                    V_CUSTOMER_DEBIT_PREF                            ,
                    V_ACCOUNT_CREDIT_PREF                            ,
                    V_ACCOUNT_DEBIT_PREF                             ,
                    V_CHANNEL_CREDIT_PREF                            ,
                    V_CHANNEL_DEBIT_PREF                             ,
                    V_PEGGED_FLAG                                    ,
                    V_PEG_FREQUENCY_IN_MONTHS                        ,
                    V_PEG_FREQUENCY_IN_DAYS                          ,
                    V_INT_FREQ_TYPE_CREDIT                           ,
                    V_INT_FREQ_WEEK_NUM_CREDIT                       ,
                    V_INT_FREQ_WEEK_DAY_CREDIT                       ,
                    V_INT_FREQ_START_DD_CREDIT                       ,
                    V_INT_FREQ_HLDY_STAT_CREDIT                      ,
                    V_NEXT_CREDIT_INTEREST_RUN_DATE                  ,
                    V_INT_FREQ_TYPE_DEBIT                            ,
                    V_INT_FREQ_WEEK_NUM_DEBIT                        ,
                    V_INT_FREQ_WEEK_DAY_DEBIT                        ,
                    V_INT_FREQ_START_DD_DEBIT                        ,
                    V_INT_FREQ_HLDY_STAT_DEBIT                       ,
                    V_NEXT_DEBIT_INTEREST_RUN_DATE                   ,
                    V_LEDGER_Number                                  ,
                    V_EMPLOYEE_ID                                    ,
                    V_ACCOUNT_OPEN_DATE                              ,
                    V_MODE_OF_OPERATION_CODE                         ,
                    V_GL_SUB_HEAD_CODE                               ,
                    V_SCHEME_CODE                                    ,
                    V_CHEQUE_ALLOWED_FLAG                            ,
                    V_PASS_BOOK                                      ,
                    V_FREEZE_CODE                                    ,
                    V_FREEZE_REASON_CODE                             ,
                    V_FREE_TEXT                                      ,
                    V_ACCOUNT_DORMANT_FLAG                           ,
                    V_FREE_CODE_1                                    ,
                    V_FREE_CODE_2                                    ,
                    V_FREE_CODE_3                                    ,
                    V_FREE_CODE_4                                    ,
                    V_FREE_CODE_5                                    ,
                    V_FREE_CODE_6                                    ,
                    V_FREE_CODE_7                                    ,
                    V_FREE_CODE_8                                    ,
                    V_FREE_CODE_9                                    ,
                    V_FREE_CODE_10                                   ,
                    V_INTEREST_TABLE_CODE                             ,
                    V_ACCOUNT_LOCATION_CODE                           ,
                    V_CURRENCY_CODE                                  ,
                    V_SERVICE_OUTLET                                  ,
                    V_ACCOUNT_MGR_USER_ID                             ,
                    V_ACCOUNT_NAME                                    ,
                    V_SWIFT_ALLOWED_FLG                               ,
                    V_LAST_TRANSACTION_DATE                           ,
                    V_LAST_TRANSACTION_ANY_DATE                       ,
                    V_EXCLUDE_FOR_COMBINED_STATEMENT                  ,
                    V_STATEMENT_CUSTOMER_ID                           ,
                    V_CHARGE_LEVEL_CODE                               ,
                    V_PBF_DOWNLOAD_FLAG                               ,
                    V_WTAX_LEVEL_FLG                                  ,
                    V_SANCTION_LIMIT                                  ,
                    V_DRAWING_POWER                                   ,
                    V_DACC_ABSOLUTE_LIMIT                             ,
                    V_DACC_PERCENT_LIMIT                             ,
                    V_MAXIMUM_ALLOWED_LIMIT                          ,
                    V_HEALTH_CODE                                    ,
                    V_SANCTION_LEVEL_CODE                            ,
                    V_SANCTION_REFERENCE_Number                      ,
                    V_LIMIT_SANCTION_DATE                            ,
                    V_LIMIT_EXPIRY_DATE                              ,
                    V_ACCOUNT_REVIEW_DATE                            ,
                    V_LOAN_PAPER_DATE                                ,
                    V_SANCTION_AUTHORITY_CODE                        ,
                    V_LAST_COMPOUND_DATE                             ,
                    V_DAILY_COMP_OF_INTEREST_FLAG                    ,
                    V_COMP_REST_DAY_FLAG                             ,
                    V_USE_DISCOUNT_RATE_FLG                          ,
                    V_DUMMY                                          ,
                    V_ACCOUNT_STATUS_DATE                            ,
                    V_IBAN_Number                                    ,
                    V_IAS_CODE                                       ,
                    V_CHANNEL_ID                                     ,
                    V_CHANNEL_LEVEL_CODE                             ,
                    V_INT_SUSPENSE_AMT                               ,
                    V_PENAL_INT_SUSPENSE_AMT                         ,
                    V_CHRGE_OFF_FLG                                  ,
                    V_PD_FLG                                         ,
                    V_PD_XFER_DATE                                   ,
                    V_CHRGE_OFF_DATE                                 ,
                    V_CHRGE_OFF_PRINCIPAL                            ,
                    V_PENDING_INTEREST                               ,
                    V_PRINCIPAL_RECOVERY                             ,
                    V_INTEREST_RECOVERY                              ,
                    V_CHARGE_OFF_TYPE                                ,
                    V_MASTER_ACCT_NUM                                ,
                    V_PS_DIFF_FREQ_REL_PARTY_FLG                     ,
                    V_SWIFT_DIFF_FREQ_REL_PARTY_FLG                  ,
                    V_ADDRESS_TYPE                                   ,
                    V_PHONE_TYPE                                     ,
                    V_EMAIL_TYPE                                     ,
                    V_ALTERNATE_ACCOUNT_NAME                         ,
                    V_INTEREST_RATE_PERIOD_MONTHS                     ,
                    V_INTEREST_RATE_PERIOD_DAYS                      ,
                    V_INTERPOLATION_METHOD                           ,
                    V_IS_ACCOUNT_HEDGED_FLAG                         ,
                    V_USED_FOR_NETTING_OFF_FLAG                      ,
                    V_SECURITY_INDICATOR                             ,
                    V_DEBT_SECURITY                                  ,
                    V_SECURITY_CODE                                  ,
                    V_DEBIT_INTEREST_METHOD                          ,
                    V_SERVICE_CHARGE_COLLECTION_FLAG                 ,
                    V_LAST_PURGE_DATE                                ,
                    V_TOTAL_PROFIT_AMOUNT                            ,
                    V_MINIMUM_AGE_NOT_MET_AMOUNT                     ,
                    V_BROKEN_PERIOD_PROFIT_PAID_FLAG                 ,
                    V_BROKEN_PERIOD_PROFIT_AMOUNT                    ,
                    V_PROFIT_TO_BE_RECOVERED                         ,
                    V_PROFIT_DISTRIBUTED_UPTO_DATE                   ,
                    V_NEXT_PROFIT_DISTRIBUTED_DATE                   ,
                    V_ACRD_AMT_TILL_INT_CALC_DATE_CR                 ,
                    V_ACID                                           ,
                    V_NEG_CR_INT_ALLOWED_FLG                         ,
                    V_UNCLAIM_STATUS                                 ,
                    V_UNCLAIM_STATUS_DATE                            ,
                    V_GL_SUB_HEAD_CODE1,
                    InpSolId
                );
            --}
            end loop;
            commit;
        --}
        END CS001;
    --} Procudre CS001 End

    PROCEDURE CS002 (InpSolId IN VARCHAR2) IS
    --{
        v_ACCOUNT_NUMBER  								NVarchar2(16)  := '';
        v_WITHHOLDING_TAX_FLAG  						NVarchar2(1)  := '';
        v_WITHHOLDING_TAX_AMOUNT_FLAG  					NVarchar2(1)  := '';
        v_WITHHOLDING_TAX_PERCENT  						Numeric(8)  := '';
        v_WITHHOLDING_TAX_FLOOR_LIMIT  					Numeric(14,2)  := '';
        v_CIF_ID  										NVarchar2(32)  := '';
        v_CUSTOMER_CREDIT_PREF_PERCENT  				Numeric(10)  := '';
        v_CUSTOMER_DEBIT_PREFE_PERCENT  				Numeric(10)  := '';
        v_ACCOUNT_CREDIT_PREF_PERCENT  					Numeric(10)  := '';
        v_ACCOUNT_DEBIT_PREF_PERCENT  					Numeric(10)  := '';
        v_CHANNEL_CREDIT_PREF_PERCENT  					Numeric(10)  := '';
        v_CHANNEL_DEBIT_PREF_PERCENT  					Numeric(10)  := '';
        v_PEGGED_FLAG  									NVarchar2(1)  := '';
        v_PEG_FREQ_IN_MONTHS  							Numeric(4)  := '';
        v_PEG_FREQ_IN_DAYS  							Numeric(3)  := '';
        v_INT_FREQ_TYPE_CREDIT  						NVarchar2(1)  := '';
        v_INT_FREQ_WEEK_NUM_CREDIT  					NVarchar2(1)  := '';
        v_INT_FREQ_WEEK_DAY_CREDIT  					Numeric(1)  := '';
        v_INT_FREQ_START_DD_CREDIT  					Numeric(2)  := '';
        v_INT_FREQ_HLDY_STAT_CREDIT  					NVarchar2(1)  := '';
        v_NEXT_CREDIT_INTEREST_RUN_DATE  				Date := '';
        v_INT_FREQ_TYPE_DEBIT  							NVarchar2(1)  := '';
        v_INT_FREQ_WEEK_NUM_DEBIT  						NVarchar2(1)  := '';
        v_INT_FREQ_WEEK_DAY_DEBIT  						Numeric(1)  := '';
        v_INT_FREQ_START_DD_DEBIT  						Numeric(2)  := '';
        v_INT_FREQ_HLDY_STAT_DEBIT  					NVarchar2(1)  := '';
        v_NEXT_DEBIT_INTEREST_RUN_DATE  				Date := '';
        v_LEDGER_NUMBER  								NVarchar2(3)  := '';
        v_EMPLOYEE_ID  									NVarchar2(10)  := '';
        v_ACCOUNT_OPEN_DATE  							Date := '';
        v_MODE_OF_OPERATION_CODE  						NVarchar2(5)  := '';
        v_GL_SUB_HEAD_CODE  							NVarchar2(5)  := '';
        v_SCHEME_CODE  									NVarchar2(5)  := '';
        v_CHEQUE_ALLOWED_FLAG  							NVarchar2(1)  := '';
        v_PASS_BOOK_PASS_SHEET_CODE  					NVarchar2(1)  := '';
        v_FREEZE_CODE  									NVarchar2(1)  := '';
        v_FREEZE_REASON_CODE  							NVarchar2(5)  := '';
        v_FREE_TEXT  									NVarchar2(240)  := '';
        v_ACCOUNT_DORMANT_FLAG  						NVarchar2(1)  := '';
        v_FREE_CODE_1  									NVarchar2(5)  := '';
        v_FREE_CODE_2  									NVarchar2(5)  := '';
        v_FREE_CODE_3  									NVarchar2(5)  := '';
        v_FREE_CODE_4  									NVarchar2(5)  := '';
        v_FREE_CODE_5  									NVarchar2(5)  := '';
        v_FREE_CODE_6  									NVarchar2(5)  := '';
        v_FREE_CODE_7  									NVarchar2(5)  := '';
        v_FREE_CODE_8  									NVarchar2(5)  := '';
        v_FREE_CODE_9  									NVarchar2(5)  := '';
        v_FREE_CODE_10  								NVarchar2(5)  := '';
        v_INTEREST_TABLE_CODE  							NVarchar2(5)  := '';
        v_ACCOUNT_LOCATION_CODE  						NVarchar2(5)  := '';
        v_CURRENCY_CODE  								NVarchar2(3)  := '';
        v_SERVICE_OUTLET  								NVarchar2(8)  := '';
        v_ACCOUNT_MGR_USER_ID  							NVarchar2(15)  := '';
        v_ACCOUNT_NAME  								NVarchar2(80)  := '';
        v_SWIFT_ALLOWED_FLG  							NVarchar2(1)  := '';
        v_LAST_TRANSACTION_DATE  						Date := '';
        v_LAST_TRANSACTION_ANY_DATE  					Date := '';
        v_EXCLUDE_FOR_COMBINED_STATEMENT  				NVarchar2(1)  := '';
        v_STATEMENT_CUSTOMER_ID  						NVarchar2(32)  := '';
        v_CHARGE_LEVEL_CODE  							NVarchar2(5)  := '';
        v_PBF_DOWNLOAD_FLAG  							NVarchar2(1)  := '';
        v_WTAX_LEVEL_FLG  								NVarchar2(1)  := '';
        v_SECTOR_CODE  									NVarchar2(5)  := '';
        v_SUB_SECTOR_CODE  								NVarchar2(5)  := '';
        v_PURPOSE_OF_ADVN_CODE  						NVarchar2(5)  := '';
        v_NATURE_OF_ADVN_CODE  							NVarchar2(5)  := '';
        v_INDUSTRY_TYPE_CODE  							NVarchar2(5)  := '';
        v_DEBIT_INTEREST_ACCOUNT_FLAG  					NVarchar2(1)  := '';
        v_DEBIT_INTEREST_ACCOUNT  						NVarchar2(16)  := '';
        v_SANCTION_LIMIT  								Numeric(14,2)  := '';
        v_DRAWING_POWER  								Numeric(14,2)  := '';
        v_DACC_ABSOLUTE_LIMIT  							Numeric(14,2)  := '';
        v_DACC_PERCENT_LIMIT  							Numeric(5,2)  := '';
        v_MAXIMUM_ALLOWED_LIMIT  						Numeric(14,2)  := '';
        v_HEALTH_CODE  									NVarchar2(5)  := '';
        v_SANCTION_LEVEL_CODE  							NVarchar2(5)  := '';
        v_SANCTION_REFERENCE_NUMBER  					NVarchar2(25)  := '';
        v_LIMIT_SANCTION_DATE  							Date := '';
        v_LIMIT_EXPIRING_DATE  							Date := '';
        v_ACCOUNT_REVIEW_DATE  							Date := '';
        v_LOAN_PAPER_DATE  								Date := '';
        v_SANCTION_AUTHORITY_CODE  						NVarchar2(5)  := '';
        v_ECGC_APPLICABLE_FLAG  						NVarchar2(1)  := '';
        v_ECGC_ACCOUNT  								NVarchar2(16)  := '';
        v_DUE_DATE  									Date := '';
        v_RPC_ACCOUNT_FLAG  							NVarchar2(1)  := '';
        v_DISBURSEMENT_INDICATOR  						NVarchar2(1)  := '';
        v_LAST_COMPOUND_DATE  							NVarchar2(10)  := '';
        v_DAILY_COMP_OF_INTEREST_FLAG  					NVarchar2(1)  := '';
        v_COMP_REST_DAY_FLAG  							NVarchar2(1)  := '';
        v_USE_DISCOUNT_RATE_FLG  						NVarchar2(1)  := '';
        v_DUMMY  										NVarchar2(100)  := '';
        v_ACCOUNT_STATUS_DATE  							Date := '';
        v_IBAN_NUMBER  									NVarchar2(34)  := '';
        v_IAS_CODE  									NVarchar2(5)  := '';
        v_CHANNEL_ID  									Numeric(5)  := '';
        v_CHANNEL_LEVEL_CODE  							Numeric(5)  := '';
        v_INT_SUSPENSE_AMT  							NVarchar2(17)  := '';
        v_PENAL_INT_SUSPENSE_AMT  						NVarchar2(17)  := '';
        v_CHRGE_OFF_FLG  								NVarchar2(1)  := '';
        v_PD_FLG  										NVarchar2(1)  := '';
        v_PD_XFER_DATE  								Date := '';
        v_CHRGE_OFF_DATE  								Date := '';
        v_CHRGE_OFF_PRINCIPAL  							Numeric(14,2)  := '';
        v_PENDING_INTEREST  							Numeric(14,2)  := '';
        v_PRINCIPAL_RECOVERY  							Numeric(14,2)  := '';
        v_INTEREST_RECOVERY  							Numeric(14,2)  := '';
        v_CHARGE_OFF_TYPE  								NVarchar2(1)  := '';
        v_MASTER_ACCT_NUM  								NVarchar2(16)  := '';
        v_PENAL_PROD_MTHD_FLG  							NVarchar2(1)  := '';
        v_PENAL_RATE_MTHD_FLG  							NVarchar2(1)  := '';
        v_WAIVE_MIN_COLL_INT  							NVarchar2(1)  := '';
        v_RULE_CODE  									NVarchar2(5)  := '';
        v_PS_DIFF_FREQ_REL_PARTY_FLG  					NVarchar2(1)  := '';
        v_SWIFT_DIFF_FREQ_REL_PARTY_FLG  				NVarchar2(1)  := '';
        v_ADDRESS_TYPE  								NVarchar2(12)  := '';
        v_PHONE_TYPE  									NVarchar2(12)  := '';
        v_EMAIL_TYPE  									NVarchar2(12)  := '';
        v_ACCRUED_PENAL_INT_RECOVERY  					Numeric(14,2)  := '';
        v_PENAL_INT_RECOVERY  							Numeric(14,2)  := '';
        v_COLL_INT_RECOVERY  							Numeric(14,2)  := '';
        v_COLL_PENAL_INT_RECOVERY  						Numeric(14,2)  := '';
        v_PENDING_PENAL_INTEREST  						Numeric(14,2)  := '';
        v_PENDING_PENAL_BOOKED_INTEREST  				Numeric(14,2)  := '';
        v_INT_RATE_PRD_IN_MONTHS  						Numeric(3)  := '';
        v_INT_RATE_PRD_IN_DAYS  						Numeric(3)  := '';
        v_PENAL_INT_TBL_CODE  							NVarchar2(5)  := '';
        v_PENAL_PREF_PCNT  								Numeric(10)  := '';
        v_INTERPOLATION_METHOD  						NVarchar2(1)  := '';
        v_IS_ACCOUNT_HEDGED_FLAG  						NVarchar2(1)  := '';
        v_USED_FOR_NETTING_OF_FLAG  					NVarchar2(1)  := '';
        v_ALTERNATE_ACCOUNT_NAME  						NVarchar2(80)  := '';
        v_SECURITY_INDICATOR  							NVarchar2(10)  := '';
        v_DEBT_SENIORITY  								NVarchar2(1)  := '';
        v_SECURITY_CODE  								NVarchar2(8)  := '';
        v_DEBIT_INTEREST_METHOD  						NVarchar2(1)  := '';
        v_SERVICE_CHARGE_COLLECTION_FLAG  				NVarchar2(1)  := '';
        v_LAST_PURGE_DATE  								Date := '';
        v_TOTAL_PROJECT_COST  							Numeric(14,2)  := '';
        v_LOSS_CARRY_FORWARD  							NVarchar2(1)  := '';
        v_UNADJUSTED_PROFIT_CARRY_FWARD  				NVarchar2(1)  := '';
        v_COLLECT_EXCESS_PROFIT  						NVarchar2(1)  := '';
        v_ADJUSTMENT_ORDER_FOR_CARRY_FWARD  			NVarchar2(1)  := '';
        v_BANK_PROFIT_SHARE_PERCENTAGE  				Numeric(9)  := '';
        v_BANK_LOSS_SHARE_PERCENTAGE  					Numeric(9)  := '';
        v_PROFIT_ADJ_FREQ_TYPE  						NVarchar2(1)  := '';
        v_PROFIT_ADJ_FREQ_WEEK_NUM  					NVarchar2(1)  := '';
        v_PROFIT_ADJ_FREQ_WEEK_DAY  					Numeric(1)  := '';
        v_PROFIT_ADJ_FREQ_START_DD  					Numeric(2)  := '';
        v_PROFIT_ADJ_FREQ_HLDY_STAT  					NVarchar2(1)  := '';
        v_NEXT_PROFIT_ADJ_DUE_DATE  					Date := '';
        v_TOTAL_BANK_CAPITAL_PERCENTAGE  				Numeric(9)  := '';
        v_ADJUSTMENT_GRACE_PRD_IN_MONTHS  				Numeric(4)  := '';
        v_ADJUSTMENT_GRACE_PRD_IN_DAYS  				Numeric(3)  := '';
        v_ADJUSTMENT_CYCLE_END_DATE  					Date := '';
        v_UNADJUSTED_PRFT_CARRY_FWD_AMT  				Numeric(14,2)  := '';
        v_UNADJUSTED_PRFT_SETTLED_AMT  					Numeric(14,2)  := '';
        v_UNADJUSTED_PRFT_CHARGE_OFF_AMT  				Numeric(14,2)  := '';
        v_UNADJUSTED_LOSS_CARRY_FWD_AMT  				Numeric(14,2)  := '';
        v_UNADJUSTED_LOSS_SETTLED_AMT  					Numeric(14,2)  := '';
        v_UNADJUSTED_LOSS_CHARGE_OFF_AMT  				Numeric(14,2)  := '';
        v_TOTAL_SHORTFALL_IN_PROF_ADJUSTED  			Numeric(14,2)  := '';
        v_LOSS_ADJUSTED_AMT_ADJUST  					Numeric(14,2)  := '';
        v_TOTAL_EXP_BANK_PROF_AMT_ADJ  					Numeric(14,2)  := '';
        v_BANK_PROFIT_SHARE_AMT_ADJ  					Numeric(14,2)  := '';
        v_BANK_LOSS_SHARE_AMT_ADJ  						Numeric(14,2)  := '';
        v_ACTUAL_PROFIT_AMT_ADJ  						Numeric(14,2)  := '';
        v_ACTUAL_LOSS_AMT_ADJ  							Numeric(14,2)  := '';
        v_AMOUNT_COLLECT_ADJ  							Numeric(14,2)  := '';
        v_EXCESS_PROFIT_AMT_ADJ  						Numeric(14,2)  := '';
        v_BROKEN_PRD_AMT_IN_LEGACY  					Numeric(14,2)  := '';
        v_ACID  										NVarchar2(11)  := '';
        v_UNCLAIM_STATUS  								NVarchar2(1)  := '';
        v_UNCLAIM_STATUS_DATE  							Date := '';
        v_GL_SUB_HEAD_CODE2  							NVarchar2(5)  := '';
        v_PAIS_APPLICABILITY_FLAG  						NVarchar2(1)  := '';
        v_PAIS_BANK_CONTRIBUTION_AMOUNT  				Numeric(14,2)  := '';
        v_PAIS_CUSTOMER_CONT_AMOUNT  					Numeric(14,2)  := '';
        v_PAIS_COLLECTED_AMOUNT  						Numeric(14,2)  := '';
        v_PAIS_EFFECTIVE_DATE  							Date := '';
        v_PAIS_END_COVERAGE_DATE  						Date := '';
        v_PRIMARY_CROP_CODE  							NVarchar2(5)  := '';
        v_PRIMARY_CROP_STATE_CODE  						NVarchar2(5)  := '';
        v_PRIMARY_NO_OF_CROPS_IN_YEAR  					NVarchar2(1)  := '';



        cursor c1(CurInpSol VARCHAR2) is
        select IACLINK.IACLINK_ACTUAL_ACNUM as Account_number,
        'N' as Withholding_tax_flag,
        null as WITHHOLDING_TAX_AMOUNT_FLAG,
        null as Withholding_tax_percent,
        null as Withholding_tax_floor_limit,
        case when cbslink.JNTCLDTL_INDIV_CLIENT_CODE is not null then cbslink.JNTCLDTL_INDIV_CLIENT_CODE else acnts.ACNTS_CLIENT_NUM end as cif_id,
        null as CUSTOMER_CREDIT_PREF_PERCENT,
        null as CUSTOMER_DEBIT_PREFE_PERCENT,
        null as ACCOUNT_CREDIT_PREF_PERCENT,
        --(cl006mb.FAC_MARGIN + cl006mb.FAC_TOT_RT) as ACCOUNT_DEBIT_PREF_PERCENT,
        case P_MAP.FINACLE_SCHM when 'ODFDR' then (cl006mb.FAC_MARGIN + cl006mb.FAC_TOT_RT) else cl006mb.FAC_MARGIN end ACCOUNT_DEBIT_PREF_PERCENT,
        null as CHANNEL_CREDIT_PREF_PERCENT,
        null as CHANNEL_DEBIT_PREF_PERCENT,
        'N' as Pegged_Flag,
        null as PEG_FREQ_IN_MONTHS,
        null as PEG_FREQ_IN_DAYS,
        null as Int_freq_type_Credit,
        null as Int_Freq_Week_Num_Credit,
        null as Int_Freq_Week_Day_Credit,
        null as Int_Freq_Start_DD_Credit,
        null as Int_Freq_Hldy_Stat_Credit,
        null as Next_Credit_Interest_Run_Date,
        'M' as Int_Freq_Type_Debit,
        null as Int_Freq_Week_Num_Debit,
        null as Int_Freq_Week_Day_Debit,
        '31' as Int_Freq_Start_DD_Debit,
        'P' as Int_Freq_Hldy_Stat_Debit,
        UTK_FN_GET_NEXT_MONTH_END_DT() as Next_Debit_Interest_Run_Date,
        null as Ledger_Number,
        memp.MEMP_NUM as Employee_Id,
        acnts.ACNTS_OPENING_DATE as Account_Open_Date,
        acnts.ACNTS_MODE_OF_OPERN as Mode_of_Operation_Code,
        P_MAP.GL_SUBHEAD_CODE as GL_Sub_Head_Code,
        P_MAP.FINACLE_SCHM as Scheme_Code,
        decode(acnts.ACNTS_CHQBK_REQD,'1','Y','N') as Cheque_Allowed_Flag,
        'S' as Pass_Book_Pass_Sheet_Code,
        UTK_FN_CHK_ACNTFREZ_INTERNAL_ACNUM(acnts.acnts_internal_acnum) as Freeze_Code,
        null as Freeze_Reason_Code,
        null as FREE_TEXT,
        decode(ACNTS.ACNTS_DORMANT_ACNT,1,'D',0,'A') As Account_Dormant_Flag,
        null as Free_Code_1,
        null as Free_Code_2,
        null as Free_Code_3,
        null as Free_Code_4,
        null as Free_Code_5,
        null as Free_Code_6,
        null as Free_Code_7,
        null as Free_Code_8,
        null as FREE_CODE_9,
        null as Free_Code_10,
        P_MAP.INTEREST_TABLE_CODE as Interest_Table_Code,
        acnts.ACNTS_LOCN_CODE as Account_Location_Code,
        'INR' as Currency_Code,
        acnts.ACNTS_BRN_CODE as Service_Outlet,
        null as Account_Mgr_User_Id,
        ACNTS.ACNTS_AC_NAME1 as Account_Name,
        --trim(ACNTS.ACNTS_AC_NAME1||' '||acnts.ACNTS_AC_NAME2) as Account_Name,
        'Y' as Swift_Allowed_Flg,
        case when acnts.ACNTS_NON_FIN_TRAN_DATE is null then acnts.ACNTS_NONSYS_LAST_DATE else acnts.ACNTS_NON_FIN_TRAN_DATE end as Last_Transaction_Date,
        acnts.ACNTS_LAST_TRAN_DATE as Last_Transaction_Any_date,
        'N' as EXCLUDE_FOR_COMBINED_STATEMENT,
        null as Statement_Customer_Id,
        null as Charge_Level_Code,
        null as PBF_Download_Flag,
        null as Wtax_level_flg,
        null as Sector_Code,
        null Sub_Sector_Code,
        null Purpose_Of_Advn_Code,
        null Nature_Of_Advn_Code,
        null Industry_Type_Code,
        'S' as Debit_Interest_Account_Flag,
        null as Debit_Interest_Account,
        cl006mb.LCY_ALLOWED_LMT as Sanction_Limit,
        cl006mb.LCY_ALLOWED_LMT as Drawing_Power,
        null as DACC_ABSOLUTE_LIMIT,
        null as DACC_PERCENT_LIMIT,
        cl006mb.LCY_ALLOWED_LMT as Maximum_Allowed_Limit,
        '1' as Health_Code,
        'MIGRA' as Sanction_Level_Code,
        'MIG' as Sanction_Reference_Number,
        trunc(cl006mb.START_DT) as Limit_Sanction_Date,
        trunc(cl006mb.MATURITY_DT) as LIMIT_EXPIRING_DATE,
        (trunc(cl006mb.MATURITY_DT) - 1) as Account_Review_Date,
        acnts.ACNTS_OPENING_DATE as Loan_Paper_Date,
        'Migra' as Sanction_Authority_Code,
        null as ECGC_Applicable_Flag,
        null as ECGC_Account,
        null as Due_Date,
        null as RPC_Account_Flag,
        null as Disbursement_Indicator,
        null as Last_Compound_Date,
        'N' as DAILY_COMP_OF_INTEREST_FLAG,
        'N' as Comp_Rest_Day_Flag,
        null as Use_Discount_Rate_Flg,
        null as Dummy,
        ACNTSTATUS.ACNTSTATUS_ENTD_ON as Account_Status_Date,
        null as Iban_number,
        null as Ias_code,
        null as channel_id,
        null as channel_level_code,
        null as int_suspense_amt,
        null as penal_int_suspense_amt,
        null as chrge_off_flg,
        null as pd_flg,
        null as pd_xfer_date,
        null as chrge_off_date,
        null as chrge_off_principal,
        null as pending_interest,
        null as principal_recovery,
        null as interest_recovery,
        null as charge_off_type,
        null as master_acct_num,
        'F' as penal_prod_mthd_flg,
        null as penal_rate_mthd_flg,
        null as waive_min_coll_int,
        null as rule_code,
        null as ps_diff_freq_rel_party_flg,
        null as swift_diff_freq_rel_party_flg,
        null as Address_Type,
        null as Phone_Type,
        null as Email_Type,
        null as accrued_penal_int_recovery,
        null as penal_int_recovery,
        null as coll_int_recovery,
        null as coll_penal_int_recovery,
        null as pending_penal_interest,
        null as pending_penal_booked_interest,
        null as int_rate_prd_in_months,
        null as int_rate_prd_in_days,
        null as penal_int_tbl_code,
        null as penal_pref_pcnt,
        null as interpolation_method,
        null as Is_Account_Hedged_Flag,
        null as Used_For_Netting_Of_Flag,
        acnts.ACNTS_AC_NAME2 as Alternate_Account_Name,
        null as Security_Indicator,
        null as DEBT_SENIORITY,
        null as Security_Code,
        null as Debit_Interest_Method,
        null as Service_Charge_Collection_Flag,
        null as Last_Purge_Date,
        null as Total_Project_Cost,
        null as Loss_Carry_Forward,
        null as UNADJUSTED_PROFIT_CARRY_FWARD,
        null as Collect_Excess_Profit,
        null as ADJUSTMENT_ORDER_FOR_CARRY_FWARD,
        null as BANK_PROFIT_SHARE_AMT_ADJ,
        null as BANK_LOSS_SHARE_AMT_ADJ,
        null as Profit_Adj_freq_type,
        null as Profit_Adj_freq_week_num,
        null as Profit_Adj_freq_week_day,
        null as Profit_Adj_freq_start_dd,
        null as Profit_Adj_freq_hldy_stat,
        null as Next_Profit_Adj_Due_date,
        null as TOTAL_BANK_CAPITAL_PERCENTAGE,
        null as Adjustment_Grace_Prd_in_Months,
        null as Adjustment_Grace_Prd_in_Days,
        null as Adjustment_Cycle_End_Date,
        null as UNADJUSTED_PRFT_CARRY_FWD_AMT,
        null as Unadjusted_Prft_Settled_Amt,
        null as Unadjusted_Prft_Charge_off_Amt,
        null as Unadjusted_Loss_Carry_Fwd_Amt,
        null as Unadjusted_Loss_Settled_Amt,
        null as Unadjusted_Loss_Charge_off_Amt,
        null as TOTAL_SHORTFALL_IN_PROF_ADJUSTED,
        null as LOSS_ADJUSTED_AMT_ADJUST,
        null as TOTAL_EXP_BANK_PROF_AMT_ADJ,
        null as BANK_PROFIT_SHARE_PERCENTAGE,
        null as BANK_LOSS_SHARE_PERCENTAGE,
        null as ACTUAL_PROFIT_AMT_ADJ,
        null as ACTUAL_LOSS_AMT_ADJ,
        null as AMOUNT_COLLECT_ADJ,
        null as EXCESS_PROFIT_AMT_ADJ,
        null as BROKEN_PRD_AMT_IN_LEGACY,
        null as acid,
        'N' as Unclaim_Status,
        null as Unclaim_Status_Date,
        null as GL_Sub_Head_Code2,
        null as PAIS_applicability_flag,
        null as PAIS_BANK_CONTRIBUTION_AMOUNT,
        null as PAIS_CUSTOMER_CONT_AMOUNT,
        null as PAIS_collected_amount,
        null as PAIS_effective_date,
        null as PAIS_end_coverage_date,
        null as Primary_crop_code,
        null as Primary_crop_state_code,
        null as Primary_no_of_crops_in_year
        from cbs.acnts
        inner join CASA_PROD_MAP P_MAP
        ON (ACNTS.ACNTS_PROD_CODE=P_MAP.INTELLECT_SCHM)
        inner join cbs.IACLINK IACLINK
        on(IACLINK.IACLINK_ENTITY_NUM=ACNTS.ACNTS_ENTITY_NUM AND IACLINK.IACLINK_INTERNAL_ACNUM=ACNTS.ACNTS_INTERNAL_ACNUM)
        inner join cbs.products products
        on(ACNTS.ACNTS_PROD_CODE=products.PRODUCT_CODE
        and products.PRODUCT_GROUP_CODE in('11'))
        left join
        (select INDCLIENT_CODE,MEMP_NUM from cbs.memp a, cbs.INDCLIENTS b
        where a.MEMP_NUM=b.INDCLIENT_EMPLOYEE_NUM) memp
        on(acnts.ACNTS_CLIENT_NUM=memp.INDCLIENT_CODE)

        /*left join
        (select ACNTFRZ_INTERNAL_ACNUM,ACNTFRZ_STOP_DB, ACNTFRZ_STOP_CR,
        case
        when ACNTFRZ_STOP_DB=1 and ACNTFRZ_STOP_CR=0 then 'D'
        when ACNTFRZ_STOP_DB=0 and ACNTFRZ_STOP_CR=1 then 'C'
        when ACNTFRZ_STOP_DB=1 and ACNTFRZ_STOP_CR=1 then 'B' else null end as FreezeCode,ACNTFRZ_REASON1
        from ACNTFRZ@cbslink) ACNTFRZ
        on(ACNTFRZ.ACNTFRZ_INTERNAL_ACNUM=ACNTS.ACNTS_INTERNAL_ACNUM)*/

        left join(select a.ACNTSTATUS_INTERNAL_ACNUM,a.ACNTSTATUS_FLG,a.ACNTSTATUS_ENTD_ON
        from cbs.acntstatus a where a.ACNTSTATUS_FLG='D' and a.ACNTSTATUS_EFF_DATE=(select max(ACNTSTATUS_EFF_DATE) from cbs.acntstatus
        where a.ACNTSTATUS_INTERNAL_ACNUM=ACNTSTATUS_INTERNAL_ACNUM and a.ACNTSTATUS_FLG=ACNTSTATUS_FLG)) ACNTSTATUS
        on(ACNTSTATUS.ACNTSTATUS_INTERNAL_ACNUM=acnts.ACNTS_INTERNAL_ACNUM and ACNTSTATUS.ACNTSTATUS_FLG=decode(ACNTS.ACNTS_DORMANT_ACNT,1,'D',0,'A'))
        left join cbs.JOINTCLIENTSDTL cbslink on(acnts.ACNTS_CLIENT_NUM=cbslink.JNTCLDTL_CLIENT_CODE and cbslink.JNTCLDTL_DTL_SL=1)
        left join clms.cl006mb cl006mb on(IACLINK.IACLINK_ACTUAL_ACNUM=cl006mb.FACILITY_CODE and cl006mb.ACCOUNT_TYPE='Account')
        where ACNTS.ACNTS_BRN_CODE=CurInpSol
        --and acnts.ACNTS_CLOSURE_DATE is null
        --and ((trunc(acnts.ACNTS_CLOSURE_DATE) is null) or 
        and (trunc(acnts.ACNTS_CLOSURE_DATE) > UTK_FN_GET_CURR_FIN_YR_START_DT);

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                v_ACCOUNT_NUMBER  							:=i.ACCOUNT_NUMBER;
                v_WITHHOLDING_TAX_FLAG 						:=i.WITHHOLDING_TAX_FLAG;
                v_WITHHOLDING_TAX_AMOUNT_FLAG  				:=i.WITHHOLDING_TAX_AMOUNT_FLAG;
                v_WITHHOLDING_TAX_PERCENT  					:=i.WITHHOLDING_TAX_PERCENT;
                v_WITHHOLDING_TAX_FLOOR_LIMIT  				:=i.WITHHOLDING_TAX_FLOOR_LIMIT;
                v_CIF_ID  									:=i.CIF_ID;
                v_CUSTOMER_CREDIT_PREF_PERCENT  			:=i.CUSTOMER_CREDIT_PREF_PERCENT;
                v_CUSTOMER_DEBIT_PREFE_PERCENT  			:=i.CUSTOMER_DEBIT_PREFE_PERCENT;
                v_ACCOUNT_CREDIT_PREF_PERCENT  				:=i.ACCOUNT_CREDIT_PREF_PERCENT;
                v_ACCOUNT_DEBIT_PREF_PERCENT  				:=i.ACCOUNT_DEBIT_PREF_PERCENT;
                v_CHANNEL_CREDIT_PREF_PERCENT  				:=i.CHANNEL_CREDIT_PREF_PERCENT;
                v_CHANNEL_DEBIT_PREF_PERCENT  				:=i.CHANNEL_DEBIT_PREF_PERCENT;
                v_PEGGED_FLAG  								:=i.PEGGED_FLAG;
                v_PEG_FREQ_IN_MONTHS  						:=i.PEG_FREQ_IN_MONTHS;
                v_PEG_FREQ_IN_DAYS  						:=i.PEG_FREQ_IN_DAYS;
                v_INT_FREQ_TYPE_CREDIT  					:=i.INT_FREQ_TYPE_CREDIT;
                v_INT_FREQ_WEEK_NUM_CREDIT  				:=i.INT_FREQ_WEEK_NUM_CREDIT;
                v_INT_FREQ_WEEK_DAY_CREDIT  				:=i.INT_FREQ_WEEK_DAY_CREDIT;
                v_INT_FREQ_START_DD_CREDIT  				:=i.INT_FREQ_START_DD_CREDIT;
                v_INT_FREQ_HLDY_STAT_CREDIT  				:=i.INT_FREQ_HLDY_STAT_CREDIT;
                v_NEXT_CREDIT_INTEREST_RUN_DATE  			:=i.NEXT_CREDIT_INTEREST_RUN_DATE;
                v_INT_FREQ_TYPE_DEBIT  						:=i.INT_FREQ_TYPE_DEBIT;
                v_INT_FREQ_WEEK_NUM_DEBIT  					:=i.INT_FREQ_WEEK_NUM_DEBIT;
                v_INT_FREQ_WEEK_DAY_DEBIT  					:=i.INT_FREQ_WEEK_DAY_DEBIT;
                v_INT_FREQ_START_DD_DEBIT  					:=i.INT_FREQ_START_DD_DEBIT;
                v_INT_FREQ_HLDY_STAT_DEBIT  				:=i.INT_FREQ_HLDY_STAT_DEBIT;
                v_NEXT_DEBIT_INTEREST_RUN_DATE  			:=i.NEXT_DEBIT_INTEREST_RUN_DATE;
                v_LEDGER_NUMBER  							:=i.LEDGER_NUMBER;
                v_EMPLOYEE_ID  								:=i.EMPLOYEE_ID;
                v_ACCOUNT_OPEN_DATE  						:=i.ACCOUNT_OPEN_DATE;
                v_MODE_OF_OPERATION_CODE  					:=i.MODE_OF_OPERATION_CODE;
                v_GL_SUB_HEAD_CODE  						:=i.GL_SUB_HEAD_CODE;
                v_SCHEME_CODE  								:=i.SCHEME_CODE;
                v_CHEQUE_ALLOWED_FLAG  						:=i.CHEQUE_ALLOWED_FLAG;
                v_PASS_BOOK_PASS_SHEET_CODE  				:=i.PASS_BOOK_PASS_SHEET_CODE;
                v_FREEZE_CODE  								:=i.FREEZE_CODE;
                v_FREEZE_REASON_CODE  						:=i.FREEZE_REASON_CODE;
                v_FREE_TEXT  								:=i.FREE_TEXT;
                v_ACCOUNT_DORMANT_FLAG  					:=i.ACCOUNT_DORMANT_FLAG;
                v_FREE_CODE_1  								:=i.FREE_CODE_1;
                v_FREE_CODE_2  								:=i.FREE_CODE_2;
                v_FREE_CODE_3  								:=i.FREE_CODE_3;
                v_FREE_CODE_4  								:=i.FREE_CODE_4;
                v_FREE_CODE_5  								:=i.FREE_CODE_5;
                v_FREE_CODE_6  								:=i.FREE_CODE_6;
                v_FREE_CODE_7  								:=i.FREE_CODE_7;
                v_FREE_CODE_8  								:=i.FREE_CODE_8;
                v_FREE_CODE_9  								:=i.FREE_CODE_9;
                v_FREE_CODE_10  							:=i.FREE_CODE_10;
                v_INTEREST_TABLE_CODE  						:=i.INTEREST_TABLE_CODE;
                v_ACCOUNT_LOCATION_CODE  					:=i.ACCOUNT_LOCATION_CODE;
                v_CURRENCY_CODE  							:=i.CURRENCY_CODE;
                v_SERVICE_OUTLET  							:=i.SERVICE_OUTLET;
                v_ACCOUNT_MGR_USER_ID  						:=i.ACCOUNT_MGR_USER_ID;
                v_ACCOUNT_NAME  							:=i.ACCOUNT_NAME;
                v_SWIFT_ALLOWED_FLG  						:=i.SWIFT_ALLOWED_FLG;
                v_LAST_TRANSACTION_DATE  					:=i.LAST_TRANSACTION_DATE;
                v_LAST_TRANSACTION_ANY_DATE  				:=i.LAST_TRANSACTION_ANY_DATE;
                v_EXCLUDE_FOR_COMBINED_STATEMENT  			:=i.EXCLUDE_FOR_COMBINED_STATEMENT;
                v_STATEMENT_CUSTOMER_ID  					:=i.STATEMENT_CUSTOMER_ID;
                v_CHARGE_LEVEL_CODE  						:=i.CHARGE_LEVEL_CODE;
                v_PBF_DOWNLOAD_FLAG  						:=i.PBF_DOWNLOAD_FLAG;
                v_WTAX_LEVEL_FLG  							:=i.WTAX_LEVEL_FLG;
                v_SECTOR_CODE  								:=i.SECTOR_CODE;
                v_SUB_SECTOR_CODE  							:=i.SUB_SECTOR_CODE;
                v_PURPOSE_OF_ADVN_CODE  					:=i.PURPOSE_OF_ADVN_CODE;
                v_NATURE_OF_ADVN_CODE  						:=i.NATURE_OF_ADVN_CODE;
                v_INDUSTRY_TYPE_CODE  						:=i.INDUSTRY_TYPE_CODE;
                v_DEBIT_INTEREST_ACCOUNT_FLAG  				:=i.DEBIT_INTEREST_ACCOUNT_FLAG;
                v_DEBIT_INTEREST_ACCOUNT  					:=i.DEBIT_INTEREST_ACCOUNT;
                v_SANCTION_LIMIT  							:=i.SANCTION_LIMIT;
                v_DRAWING_POWER  							:=i.DRAWING_POWER;
                v_DACC_ABSOLUTE_LIMIT  						:=i.DACC_ABSOLUTE_LIMIT;
                v_DACC_PERCENT_LIMIT  						:=i.DACC_PERCENT_LIMIT;
                v_MAXIMUM_ALLOWED_LIMIT  					:=i.MAXIMUM_ALLOWED_LIMIT;
                v_HEALTH_CODE  								:=i.HEALTH_CODE;
                v_SANCTION_LEVEL_CODE  						:=i.SANCTION_LEVEL_CODE;
                v_SANCTION_REFERENCE_NUMBER  				:=i.SANCTION_REFERENCE_NUMBER;
                v_LIMIT_SANCTION_DATE  						:=i.LIMIT_SANCTION_DATE;
                v_LIMIT_EXPIRING_DATE  						:=i.LIMIT_EXPIRING_DATE;
                v_ACCOUNT_REVIEW_DATE  						:=i.ACCOUNT_REVIEW_DATE;
                v_LOAN_PAPER_DATE  							:=i.LOAN_PAPER_DATE;
                v_SANCTION_AUTHORITY_CODE  					:=i.SANCTION_AUTHORITY_CODE;
                v_ECGC_APPLICABLE_FLAG  					:=i.ECGC_APPLICABLE_FLAG;
                v_ECGC_ACCOUNT  							:=i.ECGC_ACCOUNT;
                v_DUE_DATE  								:=i.DUE_DATE;
                v_RPC_ACCOUNT_FLAG  						:=i.RPC_ACCOUNT_FLAG;
                v_DISBURSEMENT_INDICATOR  					:=i.DISBURSEMENT_INDICATOR;
                v_LAST_COMPOUND_DATE  						:=i.LAST_COMPOUND_DATE;
                v_DAILY_COMP_OF_INTEREST_FLAG  				:=i.DAILY_COMP_OF_INTEREST_FLAG;
                v_COMP_REST_DAY_FLAG  						:=i.COMP_REST_DAY_FLAG;
                v_USE_DISCOUNT_RATE_FLG  					:=i.USE_DISCOUNT_RATE_FLG;
                v_DUMMY  									:=i.DUMMY;
                v_ACCOUNT_STATUS_DATE  						:=i.ACCOUNT_STATUS_DATE;
                v_IBAN_NUMBER  								:=i.IBAN_NUMBER;
                v_IAS_CODE  								:=i.IAS_CODE;
                v_CHANNEL_ID  								:=i.CHANNEL_ID;
                v_CHANNEL_LEVEL_CODE  						:=i.CHANNEL_LEVEL_CODE;
                v_INT_SUSPENSE_AMT  						:=i.INT_SUSPENSE_AMT;
                v_PENAL_INT_SUSPENSE_AMT  					:=i.PENAL_INT_SUSPENSE_AMT;
                v_CHRGE_OFF_FLG  							:=i.CHRGE_OFF_FLG;
                v_PD_FLG  									:=i.PD_FLG;
                v_PD_XFER_DATE  							:=i.PD_XFER_DATE;
                v_CHRGE_OFF_DATE  							:=i.CHRGE_OFF_DATE;
                v_CHRGE_OFF_PRINCIPAL  						:=i.CHRGE_OFF_PRINCIPAL;
                v_PENDING_INTEREST  						:=i.PENDING_INTEREST;
                v_PRINCIPAL_RECOVERY  						:=i.PRINCIPAL_RECOVERY;
                v_INTEREST_RECOVERY  						:=i.INTEREST_RECOVERY;
                v_CHARGE_OFF_TYPE  							:=i.CHARGE_OFF_TYPE;
                v_MASTER_ACCT_NUM  							:=i.MASTER_ACCT_NUM;
                v_PENAL_PROD_MTHD_FLG  						:=i.PENAL_PROD_MTHD_FLG;
                v_PENAL_RATE_MTHD_FLG  						:=i.PENAL_RATE_MTHD_FLG;
                v_WAIVE_MIN_COLL_INT  						:=i.WAIVE_MIN_COLL_INT;
                v_RULE_CODE  								:=i.RULE_CODE;
                v_PS_DIFF_FREQ_REL_PARTY_FLG  				:=i.PS_DIFF_FREQ_REL_PARTY_FLG;
                v_SWIFT_DIFF_FREQ_REL_PARTY_FLG  			:=i.SWIFT_DIFF_FREQ_REL_PARTY_FLG;
                v_ADDRESS_TYPE  							:=i.ADDRESS_TYPE;
                v_PHONE_TYPE  								:=i.PHONE_TYPE;
                v_EMAIL_TYPE  								:=i.EMAIL_TYPE;
                v_ACCRUED_PENAL_INT_RECOVERY  				:=i.ACCRUED_PENAL_INT_RECOVERY;
                v_PENAL_INT_RECOVERY  						:=i.PENAL_INT_RECOVERY;
                v_COLL_INT_RECOVERY  						:=i.COLL_INT_RECOVERY;
                v_COLL_PENAL_INT_RECOVERY  					:=i.COLL_PENAL_INT_RECOVERY;
                v_PENDING_PENAL_INTEREST  					:=i.PENDING_PENAL_INTEREST;
                v_PENDING_PENAL_BOOKED_INTEREST  			:=i.PENDING_PENAL_BOOKED_INTEREST;
                v_INT_RATE_PRD_IN_MONTHS  					:=i.INT_RATE_PRD_IN_MONTHS;
                v_INT_RATE_PRD_IN_DAYS  					:=i.INT_RATE_PRD_IN_DAYS;
                v_PENAL_INT_TBL_CODE  						:=i.PENAL_INT_TBL_CODE;
                v_PENAL_PREF_PCNT  							:=i.PENAL_PREF_PCNT;
                v_INTERPOLATION_METHOD  					:=i.INTERPOLATION_METHOD;
                v_IS_ACCOUNT_HEDGED_FLAG  					:=i.IS_ACCOUNT_HEDGED_FLAG;
                v_USED_FOR_NETTING_OF_FLAG  				:=i.USED_FOR_NETTING_OF_FLAG;
                v_ALTERNATE_ACCOUNT_NAME  					:=i.ALTERNATE_ACCOUNT_NAME;
                v_SECURITY_INDICATOR  						:=i.SECURITY_INDICATOR;
                v_DEBT_SENIORITY  							:=i.DEBT_SENIORITY;
                v_SECURITY_CODE  							:=i.SECURITY_CODE;
                v_DEBIT_INTEREST_METHOD  					:=i.DEBIT_INTEREST_METHOD;
                v_SERVICE_CHARGE_COLLECTION_FLAG  			:=i.SERVICE_CHARGE_COLLECTION_FLAG;
                v_LAST_PURGE_DATE  							:=i.LAST_PURGE_DATE;
                v_TOTAL_PROJECT_COST  						:=i.TOTAL_PROJECT_COST;
                v_LOSS_CARRY_FORWARD  						:=i.LOSS_CARRY_FORWARD;
                v_UNADJUSTED_PROFIT_CARRY_FWARD  			:=i.UNADJUSTED_PROFIT_CARRY_FWARD;
                v_COLLECT_EXCESS_PROFIT  					:=i.COLLECT_EXCESS_PROFIT;
                v_ADJUSTMENT_ORDER_FOR_CARRY_FWARD  		:=i.ADJUSTMENT_ORDER_FOR_CARRY_FWARD;
                v_BANK_PROFIT_SHARE_PERCENTAGE  			:=i.BANK_PROFIT_SHARE_PERCENTAGE;
                v_BANK_LOSS_SHARE_PERCENTAGE  				:=i.BANK_LOSS_SHARE_PERCENTAGE;
                v_PROFIT_ADJ_FREQ_TYPE  					:=i.PROFIT_ADJ_FREQ_TYPE;
                v_PROFIT_ADJ_FREQ_WEEK_NUM  				:=i.PROFIT_ADJ_FREQ_WEEK_NUM;
                v_PROFIT_ADJ_FREQ_WEEK_DAY  				:=i.PROFIT_ADJ_FREQ_WEEK_DAY;
                v_PROFIT_ADJ_FREQ_START_DD  				:=i.PROFIT_ADJ_FREQ_START_DD;
                v_PROFIT_ADJ_FREQ_HLDY_STAT  				:=i.PROFIT_ADJ_FREQ_HLDY_STAT;
                v_NEXT_PROFIT_ADJ_DUE_DATE  				:=i.NEXT_PROFIT_ADJ_DUE_DATE;
                v_TOTAL_BANK_CAPITAL_PERCENTAGE  			:=i.TOTAL_BANK_CAPITAL_PERCENTAGE;
                v_ADJUSTMENT_GRACE_PRD_IN_MONTHS  			:=i.ADJUSTMENT_GRACE_PRD_IN_MONTHS;
                v_ADJUSTMENT_GRACE_PRD_IN_DAYS  			:=i.ADJUSTMENT_GRACE_PRD_IN_DAYS;
                v_ADJUSTMENT_CYCLE_END_DATE  				:=i.ADJUSTMENT_CYCLE_END_DATE;
                v_UNADJUSTED_PRFT_CARRY_FWD_AMT  			:=i.UNADJUSTED_PRFT_CARRY_FWD_AMT;
                v_UNADJUSTED_PRFT_SETTLED_AMT  				:=i.UNADJUSTED_PRFT_SETTLED_AMT;
                v_UNADJUSTED_PRFT_CHARGE_OFF_AMT  			:=i.UNADJUSTED_PRFT_CHARGE_OFF_AMT;
                v_UNADJUSTED_LOSS_CARRY_FWD_AMT  			:=i.UNADJUSTED_LOSS_CARRY_FWD_AMT;
                v_UNADJUSTED_LOSS_SETTLED_AMT  				:=i.UNADJUSTED_LOSS_SETTLED_AMT;
                v_UNADJUSTED_LOSS_CHARGE_OFF_AMT  			:=i.UNADJUSTED_LOSS_CHARGE_OFF_AMT;
                v_TOTAL_SHORTFALL_IN_PROF_ADJUSTED  		:=i.TOTAL_SHORTFALL_IN_PROF_ADJUSTED;
                v_LOSS_ADJUSTED_AMT_ADJUST  				:=i.LOSS_ADJUSTED_AMT_ADJUST;
                v_TOTAL_EXP_BANK_PROF_AMT_ADJ  				:=i.TOTAL_EXP_BANK_PROF_AMT_ADJ;
                v_BANK_PROFIT_SHARE_AMT_ADJ  				:=i.BANK_PROFIT_SHARE_AMT_ADJ;
                v_BANK_LOSS_SHARE_AMT_ADJ  					:=i.BANK_LOSS_SHARE_AMT_ADJ;
                v_ACTUAL_PROFIT_AMT_ADJ  					:=i.ACTUAL_PROFIT_AMT_ADJ;
                v_ACTUAL_LOSS_AMT_ADJ  						:=i.ACTUAL_LOSS_AMT_ADJ;
                v_AMOUNT_COLLECT_ADJ  						:=i.AMOUNT_COLLECT_ADJ;
                v_EXCESS_PROFIT_AMT_ADJ  					:=i.EXCESS_PROFIT_AMT_ADJ;
                v_BROKEN_PRD_AMT_IN_LEGACY  				:=i.BROKEN_PRD_AMT_IN_LEGACY;
                v_ACID  									:=i.ACID;
                v_UNCLAIM_STATUS  							:=i.UNCLAIM_STATUS;
                v_UNCLAIM_STATUS_DATE  						:=i.UNCLAIM_STATUS_DATE;
                ----v_GL_SUB_HEAD_CODE2  						:=i.GL_SUB_HEAD_CODE2;
                v_PAIS_APPLICABILITY_FLAG  					:=i.PAIS_APPLICABILITY_FLAG;
                v_PAIS_BANK_CONTRIBUTION_AMOUNT  			:=i.PAIS_BANK_CONTRIBUTION_AMOUNT;
                v_PAIS_CUSTOMER_CONT_AMOUNT  				:=i.PAIS_CUSTOMER_CONT_AMOUNT;
                v_PAIS_COLLECTED_AMOUNT  					:=i.PAIS_COLLECTED_AMOUNT;
                v_PAIS_EFFECTIVE_DATE  						:=i.PAIS_EFFECTIVE_DATE;
                v_PAIS_END_COVERAGE_DATE  					:=i.PAIS_END_COVERAGE_DATE;
                v_PRIMARY_CROP_CODE  						:=i.PRIMARY_CROP_CODE;
                v_PRIMARY_CROP_STATE_CODE  					:=i.PRIMARY_CROP_STATE_CODE;
                v_PRIMARY_NO_OF_CROPS_IN_YEAR  				:=i.PRIMARY_NO_OF_CROPS_IN_YEAR;

                IF(V_FREEZE_CODE IS NOT NULL) THEN
                --{
                    V_FREEZE_REASON_CODE := '2';
                --}
                END IF;

                if (v_Account_Status_Date is null) then
                --{Account_Status_Date
                    v_Account_Status_Date:=v_ACCOUNT_OPEN_DATE;
                --}
                end if;

                if (v_Account_Dormant_Flag is null) then
                --{Account_Status_Date
                    v_Account_Dormant_Flag:='A';
                --}
                end if;

                INSERT INTO CS002 VALUES
                (
                    v_ACCOUNT_NUMBER,
                    v_WITHHOLDING_TAX_FLAG,
                    v_WITHHOLDING_TAX_AMOUNT_FLAG,
                    v_WITHHOLDING_TAX_PERCENT,
                    v_WITHHOLDING_TAX_FLOOR_LIMIT,
                    v_CIF_ID,
                    v_CUSTOMER_CREDIT_PREF_PERCENT,
                    v_CUSTOMER_DEBIT_PREFE_PERCENT,
                    v_ACCOUNT_CREDIT_PREF_PERCENT,
                    v_ACCOUNT_DEBIT_PREF_PERCENT,
                    v_CHANNEL_CREDIT_PREF_PERCENT,
                    v_CHANNEL_DEBIT_PREF_PERCENT,
                    v_PEGGED_FLAG,
                    v_PEG_FREQ_IN_MONTHS,
                    v_PEG_FREQ_IN_DAYS,
                    v_INT_FREQ_TYPE_CREDIT,
                    v_INT_FREQ_WEEK_NUM_CREDIT,
                    v_INT_FREQ_WEEK_DAY_CREDIT,
                    v_INT_FREQ_START_DD_CREDIT,
                    v_INT_FREQ_HLDY_STAT_CREDIT,
                    v_NEXT_CREDIT_INTEREST_RUN_DATE,
                    v_INT_FREQ_TYPE_DEBIT,
                    v_INT_FREQ_WEEK_NUM_DEBIT,
                    v_INT_FREQ_WEEK_DAY_DEBIT,
                    v_INT_FREQ_START_DD_DEBIT,
                    v_INT_FREQ_HLDY_STAT_DEBIT,
                    v_NEXT_DEBIT_INTEREST_RUN_DATE,
                    v_LEDGER_NUMBER,
                    v_EMPLOYEE_ID,
                    v_ACCOUNT_OPEN_DATE,
                    v_MODE_OF_OPERATION_CODE,
                    v_GL_SUB_HEAD_CODE,
                    v_SCHEME_CODE,
                    v_CHEQUE_ALLOWED_FLAG,
                    v_PASS_BOOK_PASS_SHEET_CODE,
                    v_FREEZE_CODE,
                    v_FREEZE_REASON_CODE,
                    v_FREE_TEXT,
                    v_ACCOUNT_DORMANT_FLAG,
                    v_FREE_CODE_1,
                    v_FREE_CODE_2,
                    v_FREE_CODE_3,
                    v_FREE_CODE_4,
                    v_FREE_CODE_5,
                    v_FREE_CODE_6,
                    v_FREE_CODE_7,
                    v_FREE_CODE_8,
                    v_FREE_CODE_9,
                    v_FREE_CODE_10,
                    v_INTEREST_TABLE_CODE,
                    v_ACCOUNT_LOCATION_CODE,
                    v_CURRENCY_CODE,
                    v_SERVICE_OUTLET,
                    v_ACCOUNT_MGR_USER_ID,
                    v_ACCOUNT_NAME,
                    v_SWIFT_ALLOWED_FLG,
                    v_LAST_TRANSACTION_DATE,
                    v_LAST_TRANSACTION_ANY_DATE,
                    v_EXCLUDE_FOR_COMBINED_STATEMENT,
                    v_STATEMENT_CUSTOMER_ID,
                    v_CHARGE_LEVEL_CODE,
                    v_PBF_DOWNLOAD_FLAG,
                    v_WTAX_LEVEL_FLG,
                    v_SECTOR_CODE,
                    v_SUB_SECTOR_CODE,
                    v_PURPOSE_OF_ADVN_CODE,
                    v_NATURE_OF_ADVN_CODE,
                    v_INDUSTRY_TYPE_CODE,
                    v_DEBIT_INTEREST_ACCOUNT_FLAG,
                    v_DEBIT_INTEREST_ACCOUNT,
                    v_SANCTION_LIMIT,
                    v_DRAWING_POWER,
                    v_DACC_ABSOLUTE_LIMIT,
                    v_DACC_PERCENT_LIMIT,
                    v_MAXIMUM_ALLOWED_LIMIT,
                    v_HEALTH_CODE,
                    v_SANCTION_LEVEL_CODE,
                    v_SANCTION_REFERENCE_NUMBER,
                    v_LIMIT_SANCTION_DATE,
                    v_LIMIT_EXPIRING_DATE,
                    v_ACCOUNT_REVIEW_DATE,
                    v_LOAN_PAPER_DATE,
                    v_SANCTION_AUTHORITY_CODE,
                    v_ECGC_APPLICABLE_FLAG,
                    v_ECGC_ACCOUNT,
                    v_DUE_DATE,
                    v_RPC_ACCOUNT_FLAG,
                    v_DISBURSEMENT_INDICATOR,
                    v_LAST_COMPOUND_DATE,
                    v_DAILY_COMP_OF_INTEREST_FLAG,
                    v_COMP_REST_DAY_FLAG,
                    v_USE_DISCOUNT_RATE_FLG,
                    v_DUMMY,
                    v_ACCOUNT_STATUS_DATE,
                    v_IBAN_NUMBER,
                    v_IAS_CODE,
                    v_CHANNEL_ID,
                    v_CHANNEL_LEVEL_CODE,
                    v_INT_SUSPENSE_AMT,
                    v_PENAL_INT_SUSPENSE_AMT,
                    v_CHRGE_OFF_FLG,
                    v_PD_FLG,
                    v_PD_XFER_DATE,
                    v_CHRGE_OFF_DATE,
                    v_CHRGE_OFF_PRINCIPAL,
                    v_PENDING_INTEREST,
                    v_PRINCIPAL_RECOVERY,
                    v_INTEREST_RECOVERY,
                    v_CHARGE_OFF_TYPE,
                    v_MASTER_ACCT_NUM,
                    v_PENAL_PROD_MTHD_FLG,
                    v_PENAL_RATE_MTHD_FLG,
                    v_WAIVE_MIN_COLL_INT,
                    v_RULE_CODE,
                    v_PS_DIFF_FREQ_REL_PARTY_FLG,
                    v_SWIFT_DIFF_FREQ_REL_PARTY_FLG,
                    v_ADDRESS_TYPE,
                    v_PHONE_TYPE,
                    v_EMAIL_TYPE,
                    v_ACCRUED_PENAL_INT_RECOVERY,
                    v_PENAL_INT_RECOVERY,
                    v_COLL_INT_RECOVERY,
                    v_COLL_PENAL_INT_RECOVERY,
                    v_PENDING_PENAL_INTEREST,
                    v_PENDING_PENAL_BOOKED_INTEREST,
                    v_INT_RATE_PRD_IN_MONTHS,
                    v_INT_RATE_PRD_IN_DAYS,
                    v_PENAL_INT_TBL_CODE,
                    v_PENAL_PREF_PCNT,
                    v_INTERPOLATION_METHOD,
                    v_IS_ACCOUNT_HEDGED_FLAG,
                    v_USED_FOR_NETTING_OF_FLAG,
                    v_ALTERNATE_ACCOUNT_NAME,
                    v_SECURITY_INDICATOR,
                    v_DEBT_SENIORITY,
                    v_SECURITY_CODE,
                    v_DEBIT_INTEREST_METHOD,
                    v_SERVICE_CHARGE_COLLECTION_FLAG,
                    v_LAST_PURGE_DATE,
                    v_TOTAL_PROJECT_COST,
                    v_LOSS_CARRY_FORWARD,
                    v_UNADJUSTED_PROFIT_CARRY_FWARD,
                    v_COLLECT_EXCESS_PROFIT,
                    v_ADJUSTMENT_ORDER_FOR_CARRY_FWARD,
                    v_BANK_PROFIT_SHARE_PERCENTAGE,
                    v_BANK_LOSS_SHARE_PERCENTAGE,
                    v_PROFIT_ADJ_FREQ_TYPE,
                    v_PROFIT_ADJ_FREQ_WEEK_NUM,
                    v_PROFIT_ADJ_FREQ_WEEK_DAY,
                    v_PROFIT_ADJ_FREQ_START_DD,
                    v_PROFIT_ADJ_FREQ_HLDY_STAT,
                    v_NEXT_PROFIT_ADJ_DUE_DATE,
                    v_TOTAL_BANK_CAPITAL_PERCENTAGE,
                    v_ADJUSTMENT_GRACE_PRD_IN_MONTHS,
                    v_ADJUSTMENT_GRACE_PRD_IN_DAYS,
                    v_ADJUSTMENT_CYCLE_END_DATE,
                    v_UNADJUSTED_PRFT_CARRY_FWD_AMT,
                    v_UNADJUSTED_PRFT_SETTLED_AMT,
                    v_UNADJUSTED_PRFT_CHARGE_OFF_AMT,
                    v_UNADJUSTED_LOSS_CARRY_FWD_AMT,
                    v_UNADJUSTED_LOSS_SETTLED_AMT,
                    v_UNADJUSTED_LOSS_CHARGE_OFF_AMT,
                    v_TOTAL_SHORTFALL_IN_PROF_ADJUSTED,
                    v_LOSS_ADJUSTED_AMT_ADJUST,
                    v_TOTAL_EXP_BANK_PROF_AMT_ADJ,
                    v_BANK_PROFIT_SHARE_AMT_ADJ,
                    v_BANK_LOSS_SHARE_AMT_ADJ,
                    v_ACTUAL_PROFIT_AMT_ADJ,
                    v_ACTUAL_LOSS_AMT_ADJ,
                    v_AMOUNT_COLLECT_ADJ,
                    v_EXCESS_PROFIT_AMT_ADJ,
                    v_BROKEN_PRD_AMT_IN_LEGACY,
                    v_ACID,
                    v_UNCLAIM_STATUS,
                    v_UNCLAIM_STATUS_DATE,
                    v_GL_SUB_HEAD_CODE2,
                    v_PAIS_APPLICABILITY_FLAG,
                    v_PAIS_BANK_CONTRIBUTION_AMOUNT,
                    v_PAIS_CUSTOMER_CONT_AMOUNT,
                    v_PAIS_COLLECTED_AMOUNT,
                    v_PAIS_EFFECTIVE_DATE,
                    v_PAIS_END_COVERAGE_DATE,
                    v_PRIMARY_CROP_CODE,
                    v_PRIMARY_CROP_STATE_CODE,
                    v_PRIMARY_NO_OF_CROPS_IN_YEAR,
                    InpSolId
                );
            --}
            end loop;
        --}
        END CS002;
    --} Procudre CS002 End

    PROCEDURE CS003 (InpSolId IN VARCHAR2) IS
    --{
        v_ACCOUNT_NUMBER  	NVarchar2(16)  := '';
        v_CURRENCY  	NVarchar2(3)  := '';
        v_SERVICE_OUTLET  	NVarchar2(8)  := '';
        v_RECORD_TYPE  	NVarchar2(1)  := '';
        v_NAME  	NVarchar2(80)  := '';
        v_DESIGNATION  	NVarchar2(5)  := '';
        v_AMOUNT_ALLOWED  	number(17)  := '';
        v_START_DATE  	Date := '';
        v_END_DATE  	Date := '';
        v_CIF_ID  	number(32)  := '';
        v_RELATION_CODE  	NVarchar2(5)  := '';
        v_PASS_SHEET_FLAG  	NVarchar2(1)  := '';
        v_STANDING_INSTRUCTION_FLAG  	NVarchar2(1)  := '';
        v_TERM_DEPOSIT_MATURITY_FLAG  	NVarchar2(1)  := '';
        v_LOAN_OVERDUE_NOTICE_FLAG  	NVarchar2(1)  := '';
        v_COMMUNICATION_ADDRESS_1  	NVarchar2(45)  := '';
        v_COMMUNICATION_ADDRESS_2  	NVarchar2(45)  := '';
        v_COMMUNICATION_ADDRESS_3  	NVarchar2(45)  := '';
        v_COMMUNICATION_CITY_CODE  	NVarchar2(5)  := '';
        v_COMMUNICATION_STATE_CODE  	NVarchar2(5)  := '';
        v_COMMUNICATION_PIN_CODE  	NVarchar2(10)  := '';
        v_COMMUNICATION_COUNTRY  	NVarchar2(5)  := '';
        v_COMMUNICATION_PHONE_NUMBER  	NVarchar2(15)  := '';
        v_COMMUNICATION_FAX_NUMBER  	NVarchar2(15)  := '';
        v_COMMUNICATION_TELEX_NUMBER  	NVarchar2(15)  := '';
        v_COMMUNICATION_EMAIL_ID  	NVarchar2(50)  := '';
        v_EXCLUDE_FOR_COMBINED_STATEMENT  	NVarchar2(1)  := '';
        v_STATEMENT_CIF_ID  	NVarchar2(32)  := '';
        v_CUSTOMER_TITLE_CODE  	NVarchar2(5)  := '';
        v_INCERT_PRINT_FLAG  	NVarchar2(1)  := '';
        v_INCERT_ADV_FLAG  	NVarchar2(1)  := '';
        v_GUARANTOR_LIAB_PCNT  	number(8)  := '';
        v_GUARANTOR_LIAB_SEQUENCE  	NVarchar2(2)  := '';
        v_PS_FREQUENCY_TYPE  	NVarchar2(1)  := '';
        v_PS_FREQUENCY_WEEK_NUMBER  	NVarchar2(1)  := '';
        v_PS_FREQUENCY_WEEK_DAY  	NVarchar2(1)  := '';
        v_PS_FREQUENCY_START_DD  	Date := '';
        v_PS_FREQUENCY_HOLIDAY_STATUS  	NVarchar2(1)  := '';
        v_SWIFT_STATEMENT_SERIAL_NUMBER  	NVarchar2(5)  := '';
        v_PS_DESPATCH_MODE  	NVarchar2(1)  := '';
        v_SWIFT_FREQUENCY_TYPE  	NVarchar2(1)  := '';
        v_SWIFT_FREQ_WEEK_NUMBER  	NVarchar2(1)  := '';
        v_SWIFT_FREQ_WEEK_DAY  	NVarchar2(1)  := '';
        v_SWIFT_FREQ_START_DAYS  	NVarchar2(2)  := '';
        v_SWIFT_FREQ_HOLIDAY_STATUS  	NVarchar2(1)  := '';
        v_SWIFT_MESSAGE_TYPE  	NVarchar2(1)  := '';
        v_SWIFT_MESSAGE_RECEIVER_BIC  	NVarchar2(12)  := '';
        v_ADDRESS_TYPE  	NVarchar2(12)  := '';
        v_PHONE_TYPE  	NVarchar2(12)  := '';
        v_EMAIL_TYPE  	NVarchar2(12)  := '';
        v_ALT1_ACCT_POA_AS_NAME  	NVarchar2(80)  := '';

        cursor c1(CurSolId VARCHAR2) is
        select distinct vca.actual_acnum as ACCOUNT_NUMBER,
        'INR' as Currency,
        vca.sol_id as Service_Outlet,
        'J' as Record_Type,
        null as Name,
        null as Designation,
        null as Amount_allowed,
        ACNTS.ACNTS_OPENING_DATE as Start_Date,
        TO_DATE('31-12-2099','DD-MM-YYYY') as End_Date,
        JOINTCLIENTSDTL.JNTCLDTL_INDIV_CLIENT_CODE as CIF_ID,
        null as Relation_Code,
        'N' as Pass_Sheet_flag,
        'N' as Standing_Instruction_advice_flg,
        'N' as TD_Maturity_Notice_Flag,
        'N' as Loan_Overdue_Notice_Flag,
        ADDRDTLS_ADDR1 as Communication_Address_1,
        ADDRDTLS_ADDR2 as Communication_Address_2,
        ADDRDTLS_ADDR3 as Communication_Address_3,
        ADDRDTLS_LOCN_CODE as Communication_City_Code,
        LOCN_STATE_CODE as Communication_State_Code,
        ADDRDTLS_PIN_ZIP_CODE as Communication_Pin_Code,
        ADDRDTLS_CNTRY_CODE as Communication_Country,
        ADDRDTLS_MOBILE_NUM as Communication_Phone_Number,
        null as Communication_FAX_Number,
        null as Communication_Telex_Number,
        EMAILREG_ID as Communication_Email_ID,
        'Y' as Exclude_for_combined_statement,
        null as Statement_CIF_Id,
        null as Customer_Title_Code,
        null as Incert_print_flag,
        null as Incert_adv_flag,
        null as Guarantor_liab_Pcnt,
        null as Guarantor_liab_sequence,
        null as PS_frequency_type,
        null as PS_frequency_week_number,
        null as PS_frequency_week_day,
        null as PS_Frequency_Start_DD,
        null as PS_frequency_holiday_status,
        null as SWIFT_statement_serial_number,
        null as PS_despatch_mode,
        null as SWIFT_frequency_type,
        null as SWIFT_freq_week_number,
        null as SWIFT_freq_week_day,
        null as SWIFT_freq_Start_days,
        null as SWIFT_freq_holiday_status,
        null as SWIFT_message_type,
        null as SWIFT_message_receiver_BIC,
        null as Address_type,
        null as Phone_type,
        null as Email_type,
        null as alt1_acct_poa_as_name
        from valid_casa vca
        inner join cbs.acnts acnts
        on (vca.entity_num=acnts.acnts_entity_num
            and vca.internal_acnum=acnts.acnts_internal_acnum)
/*        inner join cbs.IACLINK IACLINK
        on(IACLINK.IACLINK_ENTITY_NUM=ACNTS.ACNTS_ENTITY_NUM
            and IACLINK.IACLINK_ACCOUNT_NUMBER=ACNTS.ACNTS_ACCOUNT_NUMBER)*/
        inner join cbs.products products
        on(ACNTS.ACNTS_PROD_CODE=products.PRODUCT_CODE
        and products.PRODUCT_GROUP_CODE in('11','01','02'))
        inner join
        (select JOINTCLIENTSDTL.JNTCLDTL_CLIENT_CODE,JOINTCLIENTSDTL.JNTCLDTL_INDIV_CLIENT_CODE,JOINTCLIENTSDTL.JNTCLDTL_DTL_SL
            from cbs.clients clients, cbs.JOINTCLIENTSDTL JOINTCLIENTSDTL, cbs.acnts acnts
                where clients.CLIENTS_TYPE_FLG='J'
                    and acnts.ACNTS_CLIENT_NUM=JOINTCLIENTSDTL.JNTCLDTL_CLIENT_CODE
                    and JOINTCLIENTSDTL.JNTCLDTL_CLIENT_CODE=CLIENTS.CLIENTS_CODE
                    and JOINTCLIENTSDTL.JNTCLDTL_DTL_SL<>1) JOINTCLIENTSDTL
                        on(JOINTCLIENTSDTL.JNTCLDTL_CLIENT_CODE=acnts.ACNTS_CLIENT_NUM)
        left join
            (select * from
                (select JNTCLDTL_CLIENT_CODE, JNTCLDTL_INDIV_CLIENT_CODE,ADDRDTLS_ADDR1, ADDRDTLS_ADDR2, ADDRDTLS_ADDR3,ADDRDTLS_PIN_ZIP_CODE,ADDRDTLS_LOCN_CODE,ADDRDTLS_CNTRY_CODE,ADDRDTLS_MOBILE_NUM
                    from(select JOINTCLIENTSDTL.JNTCLDTL_CLIENT_CODE,JOINTCLIENTSDTL.JNTCLDTL_INDIV_CLIENT_CODE,JOINTCLIENTSDTL.JNTCLDTL_DTL_SL
                        from cbs.clients clients, cbs.JOINTCLIENTSDTL JOINTCLIENTSDTL, cbs.acnts acnts
                            where clients.CLIENTS_TYPE_FLG='J'
                                and acnts.ACNTS_CLIENT_NUM=JOINTCLIENTSDTL.JNTCLDTL_CLIENT_CODE
                                and JOINTCLIENTSDTL.JNTCLDTL_CLIENT_CODE=CLIENTS.CLIENTS_CODE
                                and JOINTCLIENTSDTL.JNTCLDTL_DTL_SL<>1) abc
        left join cbs.addrdtls addrdtls on(to_char(abc.JNTCLDTL_INDIV_CLIENT_CODE)=addrdtls.ADDRDTLS_SOURCE_KEY) 
                                            and addrdtls.ADDRDTLS_ADDR_TYPE='03') abc
        left join (select LOCN_CODE,LOCN_STATE_CODE from cbs.location) location
            on(abc.ADDRDTLS_LOCN_CODE=location.LOCN_CODE)) addr
            on(JOINTCLIENTSDTL.JNTCLDTL_INDIV_CLIENT_CODE=addr.JNTCLDTL_INDIV_CLIENT_CODE)
        left join (select EMAILREG_INTNUM,EMAILREG_ID from cbs.emailreg) emailreg
            on(emailreg.EMAILREG_INTNUM=acnts.ACNTS_INTERNAL_ACNUM)
        where ACNTS.ACNTS_BRN_CODE=CurSolId;
        --order by IACLINK.IACLINK_ACTUAL_ACNUM;

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                v_ACCOUNT_NUMBER                    :=i.ACCOUNT_NUMBER;
                v_CURRENCY                          :=i.Currency;
                v_SERVICE_OUTLET                    :=i.Service_Outlet;
                v_RECORD_TYPE                       :=i.Record_Type;
                v_NAME                              :=i.Name;
                v_DESIGNATION                       :=i.Designation;
                v_AMOUNT_ALLOWED                    :=i.Amount_allowed;
                v_START_DATE                        :=i.Start_Date;
                v_END_DATE                          :=i.End_Date;
                v_CIF_ID                            :=i.CIF_ID;
                v_RELATION_CODE                     :=i.Relation_Code;
                v_PASS_SHEET_FLAG                   :=i.Pass_Sheet_flag;
                v_STANDING_INSTRUCTION_FLAG         :=i.Standing_Instruction_advice_flg;
                v_TERM_DEPOSIT_MATURITY_FLAG        :=i.TD_Maturity_Notice_Flag;
                v_LOAN_OVERDUE_NOTICE_FLAG          :=i.Loan_Overdue_Notice_Flag;
                v_COMMUNICATION_ADDRESS_1           :=i.Communication_Address_1;
                v_COMMUNICATION_ADDRESS_2           :=i.Communication_Address_2;
                v_COMMUNICATION_ADDRESS_3           :=i.Communication_Address_3;
                v_COMMUNICATION_CITY_CODE           :=i.Communication_City_Code;
                v_COMMUNICATION_STATE_CODE          :=i.Communication_State_Code;
                v_COMMUNICATION_PIN_CODE            :=i.Communication_Pin_Code;
                v_COMMUNICATION_COUNTRY             :=i.Communication_Country;
                v_COMMUNICATION_PHONE_NUMBER        :=i.Communication_Phone_Number;
                v_COMMUNICATION_FAX_NUMBER          :=i.Communication_FAX_Number;
                v_COMMUNICATION_TELEX_NUMBER        :=i.Communication_Telex_Number;
                v_COMMUNICATION_EMAIL_ID            :=i.Communication_Email_ID;
                v_EXCLUDE_FOR_COMBINED_STATEMENT    :=i.Exclude_for_combined_statement;
                v_STATEMENT_CIF_ID  			    :=i.Statement_CIF_Id;
                v_CUSTOMER_TITLE_CODE  			    :=i.Customer_Title_Code;
                v_INCERT_PRINT_FLAG  			    :=i.Incert_print_flag;
                v_INCERT_ADV_FLAG  				    :=i.Incert_adv_flag;
                v_GUARANTOR_LIAB_PCNT  			    :=i.Guarantor_liab_Pcnt;
                v_GUARANTOR_LIAB_SEQUENCE  		    :=i.Guarantor_liab_sequence;
                v_PS_FREQUENCY_TYPE  			    :=i.PS_frequency_type;
                v_PS_FREQUENCY_WEEK_NUMBER  	    :=i.PS_frequency_week_number;
                v_PS_FREQUENCY_WEEK_DAY  		    :=i.PS_frequency_week_day;
                v_PS_FREQUENCY_START_DD  		    :=i.PS_Frequency_Start_DD;
                v_PS_FREQUENCY_HOLIDAY_STATUS  	    :=i.PS_frequency_holiday_status;
                v_SWIFT_STATEMENT_SERIAL_NUMBER     :=i.SWIFT_statement_serial_number;
                v_PS_DESPATCH_MODE  			    :=i.PS_despatch_mode;
                v_SWIFT_FREQUENCY_TYPE  		    :=i.SWIFT_frequency_type;
                v_SWIFT_FREQ_WEEK_NUMBER  		    :=i.SWIFT_freq_week_number;
                v_SWIFT_FREQ_WEEK_DAY  			    :=i.SWIFT_freq_week_day;
                v_SWIFT_FREQ_START_DAYS  		    :=i.SWIFT_freq_Start_days;
                v_SWIFT_FREQ_HOLIDAY_STATUS  	    :=i.SWIFT_freq_holiday_status;
                v_SWIFT_MESSAGE_TYPE  			    :=i.SWIFT_message_type;
                v_SWIFT_MESSAGE_RECEIVER_BIC  	    :=i.SWIFT_message_receiver_BIC;
                v_ADDRESS_TYPE  				    :=i.Address_type;
                v_PHONE_TYPE  					    :=i.Phone_type;
                v_EMAIL_TYPE  					    :=i.Email_type;
                v_ALT1_ACCT_POA_AS_NAME  		    :=i.alt1_acct_poa_as_name;

                INSERT INTO CS003 VALUES
                (
                    v_ACCOUNT_NUMBER  ,
                    v_CURRENCY  ,
                    v_SERVICE_OUTLET  ,
                    v_RECORD_TYPE  ,
                    v_NAME  ,
                    v_DESIGNATION  ,
                    v_AMOUNT_ALLOWED  ,
                    v_START_DATE  ,
                    v_END_DATE  ,
                    v_CIF_ID  ,
                    v_RELATION_CODE  ,
                    v_PASS_SHEET_FLAG  ,
                    v_STANDING_INSTRUCTION_FLAG  ,
                    v_TERM_DEPOSIT_MATURITY_FLAG  ,
                    v_LOAN_OVERDUE_NOTICE_FLAG  ,
                    v_COMMUNICATION_ADDRESS_1  ,
                    v_COMMUNICATION_ADDRESS_2  ,
                    v_COMMUNICATION_ADDRESS_3  ,
                    v_COMMUNICATION_CITY_CODE  ,
                    v_COMMUNICATION_STATE_CODE  ,
                    v_COMMUNICATION_PIN_CODE  ,
                    v_COMMUNICATION_COUNTRY  ,
                    v_COMMUNICATION_PHONE_NUMBER  ,
                    v_COMMUNICATION_FAX_NUMBER  ,
                    v_COMMUNICATION_TELEX_NUMBER  ,
                    v_COMMUNICATION_EMAIL_ID  ,
                    v_EXCLUDE_FOR_COMBINED_STATEMENT  ,
                    v_STATEMENT_CIF_ID  ,
                    v_CUSTOMER_TITLE_CODE  ,
                    v_INCERT_PRINT_FLAG  ,
                    v_INCERT_ADV_FLAG  ,
                    v_GUARANTOR_LIAB_PCNT  ,
                    v_GUARANTOR_LIAB_SEQUENCE  ,
                    v_PS_FREQUENCY_TYPE  ,
                    v_PS_FREQUENCY_WEEK_NUMBER  ,
                    v_PS_FREQUENCY_WEEK_DAY  ,
                    v_PS_FREQUENCY_START_DD  ,
                    v_PS_FREQUENCY_HOLIDAY_STATUS  ,
                    v_SWIFT_STATEMENT_SERIAL_NUMBER  ,
                    v_PS_DESPATCH_MODE  ,
                    v_SWIFT_FREQUENCY_TYPE  ,
                    v_SWIFT_FREQ_WEEK_NUMBER  ,
                    v_SWIFT_FREQ_WEEK_DAY  ,
                    v_SWIFT_FREQ_START_DAYS  ,
                    v_SWIFT_FREQ_HOLIDAY_STATUS  ,
                    v_SWIFT_MESSAGE_TYPE  ,
                    v_SWIFT_MESSAGE_RECEIVER_BIC  ,
                    v_ADDRESS_TYPE  ,
                    v_PHONE_TYPE  ,
                    v_EMAIL_TYPE  ,
                    v_ALT1_ACCT_POA_AS_NAME,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END CS003;
    --} Procudre CS003 End

    PROCEDURE CS004 (InpSolId IN VARCHAR2) IS
    --{
        V_ACCOUNT_NUMBER                   	NVARCHAR2(16) := '';
        V_CURRENCY_CODE                    	NVARCHAR2(3) := '';
        V_SERVICE_OUTLET                   	NVARCHAR2(8) := '';
        V_NOMINATION_SERIAL_NUMBER         	NVARCHAR2(3) := '';
        V_NOMINEE_NAME                     	NVARCHAR2(40) := '';
        V_ADDRESS_1ST_LINE                 	NVARCHAR2(45) := '';
        V_ADDRESS_2ND_LINE                 	NVARCHAR2(45) := '';
        V_ADDRESS_3RD_LINE                 	NVARCHAR2(45) := '';
        V_NOMINEE_RELATION_CODE            	NVARCHAR2(5) := '';
        V_NOMINEE_REGISTRATION_NUMBER      	NVARCHAR2(15) := '';
        V_CITY_CODE                        	NVARCHAR2(5) := '';
        V_STATE_CODE                       	NVARCHAR2(5) := '';
        V_COUNTRY_CODE                     	NVARCHAR2(5) := '';
        V_PIN_CODE                         	NVARCHAR2(6) := '';
        V_MINOR_OR_GUARDIAN_CODE           	NVARCHAR2(1) := '';
        V_NOMINEE_DATE_OF_BIRTH            	DATE := '';
        V_MINOR_FLAG                       	NVARCHAR2(1) := '';
        V_NOMINATION_PERCENTAGE            	NVARCHAR2(10) := '';
        V_LAST_NOMINEE_FLAG                	NVARCHAR2(1) := '';
        V_PREFERABLE_LANGUAGE_CODE         	NVARCHAR2(10) := '';
        V_PREFERABLE_LANGUAGE_NOMINEE_NAME 	NVARCHAR2(40) := '';
        V_DUMMY                            	NVARCHAR2(100) := '';
        V_NOMINEE_CIF_ID                   	NVARCHAR2(50) := '';

        cursor c1(CurSolId VARCHAR2) is
        select IACLINK.IACLINK_ACTUAL_ACNUM as Account_Number,
        'INR' as Currency_Code,
        IACLINK.IACLINK_BRN_CODE as Service_Outlet,
        '001' as Nomination_Serial_Number,
        case replace(connpinfo.CONNP_CLIENT_NAME,' ','') 
            when null then clnt.CLIENTS_NAME 
            else CONNP_CLIENT_NAME
        end Nominee_Name,
        case replace (CONNP_CLIENT_ADDR1,' ','') 
           when null then clnt.CLIENTS_ADDR1
           else CONNP_CLIENT_ADDR1
        end as  Address_1st_Line,
        case replace (CONNP_CLIENT_ADDR2,' ','') 
           when null then clnt.CLIENTS_ADDR2
           else CONNP_CLIENT_ADDR2
        end as  Address_2nd_Line,
        case replace (substr(trim(CONNP_CLIENT_ADDR3||CONNP_CLIENT_ADDR4||CONNP_CLIENT_ADDR5),1,45),' ','') 
           when  null then substr(trim(clnt.CLIENTS_ADDR3||clnt.CLIENTS_ADDR4||clnt.CLIENTS_ADDR5),1,45)
           else substr(trim(CONNP_CLIENT_ADDR3||CONNP_CLIENT_ADDR4||CONNP_CLIENT_ADDR5),1,45) 
        end as  Address_3rd_Line,
        '2' as Nominee_Relation_Code,
        'MIG' as Nominee_Registration_Number,
        ACNTS_LOCN_CODE as City_Code,
        LOCN_STATE_CODE as State_Code,
        LOCN_CNTRY_CODE as Country_Code,
        nvl(PINACC.PINACC_PINCODE,'MIG') as Pin_Code,
        decode(UPPER(Guardian.CONNP_RELATIONSHIP_INFO),'FATHER','F','MOTHER','M','') as Minor_or_Guardian_Code,
        connpinfo.CONNP_DATE_OF_BIRTH as Nominee_Date_of_Birth,
        case when FLOOR(MONTHS_BETWEEN(SYSDATE,connpinfo.CONNP_DATE_OF_BIRTH)/12)<18 then 'Y' else 'N' end as Minor_Flag,
        '100' as Nomination_Percentage,
        'Y' as Last_Nominee_Flag,
        'INFENG' as Preferable_Language_Code,
        null as PREFERABLE_LANGUAGE_NOMINEE_NAME,
        null as Dummy,
        replace(CONNP_CLIENT_NUM,0,null) as Nominee_CIF_Id
        from valid_casa vca 
        inner join cbs.IACLINK IACLINK
            on(vca.ENTITY_NUM=IACLINK.IACLINK_ENTITY_NUM
                and vca.INTERNAL_ACNUM=iaclink.IACLINK_INTERNAL_ACNUM
                )
        inner join cbs.products products
            on(IACLINK.IACLINK_PROD_CODE=products.PRODUCT_CODE
                and products.PRODUCT_GROUP_CODE in('11','01','02'))
        inner join cbs.acnts acnts
        on(vca.ENTITY_NUM=acnts.ACNTS_ENTITY_NUM
            and vca.INTERNAL_ACNUM=acnts.ACNTS_INTERNAL_ACNUM
           )
        inner join cbs.connpinfo connpinfo on(connpinfo.CONNP_SOURCE_KEY=IACLINK.IACLINK_INTERNAL_ACNUM and connpinfo.CONNP_CONN_ROLE='02' and connpinfo.CONNP_INV_NUM=acnts.ACNTS_CONNP_INV_NUM)
        left join cbs.location location
        on(acnts.ACNTS_LOCN_CODE=location.LOCN_CODE)
        left join
        (select a.CONNP_SOURCE_KEY,a.CONNP_DATE_OF_BIRTH,b.CONNP_RELATIONSHIP_INFO from cbs.connpinfo a
        inner join (select * from cbs.connpinfo b where b.CONNP_CONN_ROLE='03'
        and b.CONNP_RELATIONSHIP_INFO is not null) b
        on(a.CONNP_SOURCE_KEY=b.CONNP_SOURCE_KEY)
        where a.CONNP_CONN_ROLE='02'
        and FLOOR(MONTHS_BETWEEN(SYSDATE,a.CONNP_DATE_OF_BIRTH)/12)<18) Guardian
        on(Guardian.CONNP_SOURCE_KEY=IACLINK.IACLINK_INTERNAL_ACNUM)
        left join cbs.PINACC PINACC
        on(IACLINK.IACLINK_CIF_NUMBER=PINACC.PINACC_CLIENT_NUM)
        left outer join cbs.clients clnt
        on (connpinfo.CONNP_CLIENT_NUM=clnt.CLIENTS_CODE)
        where vca.SOL_ID=CurSolId;
        --order by IACLINK.IACLINK_ACTUAL_ACNUM;

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                V_ACCOUNT_NUMBER								 :=i.ACCOUNT_NUMBER;
                V_CURRENCY_CODE									 :=i.CURRENCY_CODE;
                V_SERVICE_OUTLET								 :=i.SERVICE_OUTLET;
                V_NOMINATION_SERIAL_NUMBER						 :=i.NOMINATION_SERIAL_NUMBER;
                V_NOMINEE_NAME									 := SUBSTR(i.NOMINEE_NAME,0,40);
                V_ADDRESS_1ST_LINE								 :=i.ADDRESS_1ST_LINE;
                V_ADDRESS_2ND_LINE								 :=i.ADDRESS_2ND_LINE;
                V_ADDRESS_3RD_LINE								 :=i.ADDRESS_3RD_LINE;
                V_NOMINEE_RELATION_CODE							 :=i.NOMINEE_RELATION_CODE;
                V_NOMINEE_REGISTRATION_NUMBER					 :=i.NOMINEE_REGISTRATION_NUMBER;
                V_CITY_CODE										 :=i.CITY_CODE;
                V_STATE_CODE									 :=i.STATE_CODE;
                V_COUNTRY_CODE									 :=i.COUNTRY_CODE;
                V_PIN_CODE										 :=i.PIN_CODE;
                V_MINOR_OR_GUARDIAN_CODE						 :=i.MINOR_OR_GUARDIAN_CODE;
                V_NOMINEE_DATE_OF_BIRTH							 :=i.NOMINEE_DATE_OF_BIRTH;
                V_MINOR_FLAG									 :=i.MINOR_FLAG;
                V_NOMINATION_PERCENTAGE							 :=i.NOMINATION_PERCENTAGE;
                V_LAST_NOMINEE_FLAG								 :=i.LAST_NOMINEE_FLAG;
                V_PREFERABLE_LANGUAGE_CODE						 :=i.PREFERABLE_LANGUAGE_CODE;
                V_PREFERABLE_LANGUAGE_NOMINEE_NAME				 :=i.PREFERABLE_LANGUAGE_NOMINEE_NAME;
                V_DUMMY											 :=i.DUMMY;
                V_NOMINEE_CIF_ID								 :=i.NOMINEE_CIF_ID;

                IF(V_MINOR_FLAG = 'N') THEN
                --{
                    V_NOMINEE_DATE_OF_BIRTH := null;
                --}
                END IF;
                

                INSERT INTO cs004 VALUES
                (
                    V_ACCOUNT_NUMBER					,
                    V_CURRENCY_CODE						,
                    V_SERVICE_OUTLET					,
                    V_NOMINATION_SERIAL_NUMBER			,
                    V_NOMINEE_NAME						,
                    V_ADDRESS_1ST_LINE					,
                    V_ADDRESS_2ND_LINE					,
                    V_ADDRESS_3RD_LINE					,
                    V_NOMINEE_RELATION_CODE				,
                    V_NOMINEE_REGISTRATION_NUMBER		,
                    V_CITY_CODE							,
                    V_STATE_CODE						,
                    V_COUNTRY_CODE						,
                    V_PIN_CODE							,
                    V_MINOR_OR_GUARDIAN_CODE			,
                    V_NOMINEE_DATE_OF_BIRTH				,
                    V_MINOR_FLAG						,
                    V_NOMINATION_PERCENTAGE				,
                    V_LAST_NOMINEE_FLAG					,
                    V_PREFERABLE_LANGUAGE_CODE			,
                    V_PREFERABLE_LANGUAGE_NOMINEE_NAME	,
                    V_DUMMY								,
                    V_NOMINEE_CIF_ID,
                    InpSolId
                );
            --}
            end loop;
        --}
        END CS004;
    --} Procudre CS004 End

    PROCEDURE CS005 (InpSolId IN VARCHAR2) IS
    --{
        V_INDICATOR                                NVARCHAR2(3) := '';
        V_ACCOUNT_NUMBER                           NVARCHAR2(16) := '';
        V_AMOUNT                                   NUMERIC(14,2) := '';
        V_TRANSACTION_DATE                         NVARCHAR2(10) := '';
        V_CURRENCY_CODE                            NVARCHAR2(3) := '';
        V_SERVICE_OUTLET                           NVARCHAR2(8) := '';
        V_DUMMY                                    NVARCHAR2(100) := '';

        cursor c1(CurSolId VARCHAR2) is
        SELECT
        'BAL' as Indicator,
        vra.actual_acnum as ACCOUNT_NUMBER,
        cbs.fn_get_ason_acbal_mis(1,vra.internal_acnum,'INR',MC.mn_prev_business_date,mc.mn_curr_business_date)  as Amount,
        TRUNC(mc.mn_prev_business_date) as Transaction_Date,
        'INR' as Currency_Code,
        vra.sol_id as Service_Outlet,
        null as Dummy
        from valid_casa vra
            INNER JOIN CBS.MAINCONT MC
                ON (1=1)
            where vra.sol_id=CurSolId
        ;

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                V_INDICATOR								 :=i.INDICATOR;
                V_ACCOUNT_NUMBER						 :=i.ACCOUNT_NUMBER;
                V_AMOUNT								 :=i.AMOUNT;
                V_TRANSACTION_DATE						 :=i.TRANSACTION_DATE;
                V_CURRENCY_CODE							 :=i.CURRENCY_CODE;
                V_SERVICE_OUTLET						 := lpad(i.SERVICE_OUTLET,4,'0');
                V_DUMMY									 :=i.DUMMY;

                INSERT INTO cs005 VALUES
                (
                    V_INDICATOR,
                    V_ACCOUNT_NUMBER,
                    V_AMOUNT,
                    V_TRANSACTION_DATE,
                    V_CURRENCY_CODE,
                    V_SERVICE_OUTLET,
                    V_DUMMY,
                    InpSolId
                );
            --}
            end loop;
        --}
        END CS005;
    --} Procudre CS005 End

    PROCEDURE CS006 (InpSolId IN VARCHAR2) IS
    --{
        V_ACCOUNT_NUMBER                         NVARCHAR2(16) := '';
        V_CURRENCY_CODE                          NVARCHAR2(3) := '';
        V_SERVICE_OUTLET                         NVARCHAR2(8) := '';
        V_CREDIT_INTEREST_TRANSFER_AMOUNT        NUMERIC(14,2) := '';
        V_CREDIT_INTEREST_CAL_UPTO_DATE          DATE := '';
        V_CREDIT_INTEREST_ACRUED_UPTO_DATE       DATE := '';
        V_CREDIT_INTEREST_BOOKED_UPTO_DATE       DATE := '';
        V_DEBIT_INTEREST_TRANSFER_AMOUNT         NUMERIC(14,2) := '';
        V_DEBIT_INTEREST_CALCULATED_UPTO         DATE := '';
        V_DEBIT_INTEREST_ACCRUED_UPTO            DATE := '';
        V_DEBIT_INTEREST_BOOKED_UPTO             DATE := '';
        V_DUMMY                                  NVARCHAR2(100) := '';
        V_MIGRATED_CUMULATIVE_BAL_CREDIT         NUMERIC(14,2) := '';
        V_DATE_OF_MIGRATED_CUMULATIVE_BAL        DATE := '';

        cursor c1(CurSolId varchar2) is
        select account_number, Currency_Code,Service_Outlet,
        sum(Credit_Interest_Transfer_Amount) as Credit_Interest_Transfer_Amount,
        --sum (SBCAIA_AC_INT_ACTUAL_ACCR_AMT) as Credit_Interest_Transfer_Amount,
        CREDIT_INTEREST_CAL_UPTO_DATE, CREDIT_INTEREST_ACRUED_UPTO_DATE,
        Credit_interest_booked_upto_date, sum(Debit_Interest_Transfer_amount) as Debit_Interest_Transfer_amount,
        Debit_Interest_Calculated_upto, Debit_Interest_Accrued_Upto, Debit_Interest_Booked_Upto,
        Dummy, MIGRATED_CUMULATIVE_BAL_CREDIT, DATE_OF_MIGRATED_CUMULATIVE_BAL
        from (
        select IACLINK_ACTUAL_ACNUM as account_number,
        'INR' as Currency_Code,
        SBCAIA_BRN_CODE as Service_Outlet,
        SBCAIA_AC_INT_ACCR_AMT as Credit_Interest_Transfer_Amount,
        trunc (mc.MN_PREV_BUSINESS_DATE) as CREDIT_INTEREST_CAL_UPTO_DATE,
        trunc (mc.MN_PREV_BUSINESS_DATE) as CREDIT_INTEREST_ACRUED_UPTO_DATE,
        trunc (mc.MN_PREV_BUSINESS_DATE) as Credit_interest_booked_upto_date,
        0 as Debit_Interest_Transfer_amount,
        trunc (mc.MN_PREV_BUSINESS_DATE) as Debit_Interest_Calculated_upto,
        trunc (mc.MN_PREV_BUSINESS_DATE) as Debit_Interest_Accrued_Upto,
        trunc (mc.MN_PREV_BUSINESS_DATE) as Debit_Interest_Booked_Upto,
        null as Dummy,
        0 as MIGRATED_CUMULATIVE_BAL_CREDIT,
        trunc (mc.MN_PREV_BUSINESS_DATE) as DATE_OF_MIGRATED_CUMULATIVE_BAL,
        SBCAIA_UPTO_DATE
        from CBS.IACLINK IACLINK
        inner join CBS.products products
            on (IACLINK.IACLINK_PROD_CODE=products.PRODUCT_CODE
            and products.PRODUCT_GROUP_CODE in ('01','02'))
        inner join CBS.acnts acnts
            on(IACLINK.IACLINK_ENTITY_NUM=acnts.ACNTS_ENTITY_NUM
                AND IACLINK.IACLINK_INTERNAL_ACNUM=acnts.ACNTS_INTERNAL_ACNUM
                and (acnts.ACNTS_CLOSURE_DATE is null OR acnts.ACNTS_CLOSURE_DATE> UTK_FN_GET_CURR_FIN_YR_START_DT))
        inner join cbs.maincont mc
            on (1=1)
        inner join CBS.SBCAIA SBCAIA
            on(IACLINK.IACLINK_ENTITY_NUM= SBCAIA.SBCAIA_ENTITY_NUM
                AND IACLINK.IACLINK_INTERNAL_ACNUM=SBCAIA.SBCAIA_INTERNAL_ACNUM
                and SBCAIA.SBCAIA_UPTO_DATE>acnts.ACNTS_INT_DBCR_UPTO
                and SBCAIA.SBCAIA_INT_ACCR_DB_CR='C'
                and SBCAIA.SBCAIA_UPTO_DATE<=mc.MN_PREV_BUSINESS_DATE)
        where IACLINK.IACLINK_BRN_CODE=CurSolId
        ) abc
        group by account_number,Currency_Code,Service_Outlet,
        CREDIT_INTEREST_CAL_UPTO_DATE,CREDIT_INTEREST_ACRUED_UPTO_DATE,
        Debit_Interest_Calculated_upto,Debit_Interest_Accrued_Upto,
        Debit_Interest_Booked_Upto,Dummy,MIGRATED_CUMULATIVE_BAL_CREDIT,
        DATE_OF_MIGRATED_CUMULATIVE_BAL
        ;

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                V_ACCOUNT_NUMBER								 :=i.ACCOUNT_NUMBER;
                V_CURRENCY_CODE									 :=i.CURRENCY_CODE;
                V_SERVICE_OUTLET								 :=i.SERVICE_OUTLET;
                V_CREDIT_INTEREST_TRANSFER_AMOUNT				 :=i.CREDIT_INTEREST_TRANSFER_AMOUNT;
                V_CREDIT_INTEREST_CAL_UPTO_DATE					 :=i.CREDIT_INTEREST_CAL_UPTO_DATE;
                V_CREDIT_INTEREST_ACRUED_UPTO_DATE				 :=i.CREDIT_INTEREST_ACRUED_UPTO_DATE;
                V_CREDIT_INTEREST_BOOKED_UPTO_DATE				 :=i.CREDIT_INTEREST_BOOKED_UPTO_DATE;
                V_DEBIT_INTEREST_TRANSFER_AMOUNT				 :=i.DEBIT_INTEREST_TRANSFER_AMOUNT;
                V_DEBIT_INTEREST_CALCULATED_UPTO				 :=i.DEBIT_INTEREST_CALCULATED_UPTO;
                V_DEBIT_INTEREST_ACCRUED_UPTO					 :=i.DEBIT_INTEREST_ACCRUED_UPTO;
                V_DEBIT_INTEREST_BOOKED_UPTO					 :=i.DEBIT_INTEREST_BOOKED_UPTO;
                V_DUMMY											 :=i.DUMMY;
                V_MIGRATED_CUMULATIVE_BAL_CREDIT				 :=i.MIGRATED_CUMULATIVE_BAL_CREDIT;
                V_DATE_OF_MIGRATED_CUMULATIVE_BAL				 :=i.DATE_OF_MIGRATED_CUMULATIVE_BAL;

                INSERT INTO cs006 VALUES
                (
                    V_ACCOUNT_NUMBER								,
                    V_CURRENCY_CODE									,
                    V_SERVICE_OUTLET								,
                    V_CREDIT_INTEREST_TRANSFER_AMOUNT				,
                    V_CREDIT_INTEREST_CAL_UPTO_DATE					,
                    V_CREDIT_INTEREST_ACRUED_UPTO_DATE				,
                    V_CREDIT_INTEREST_BOOKED_UPTO_DATE				,
                    V_DEBIT_INTEREST_TRANSFER_AMOUNT				,
                    V_DEBIT_INTEREST_CALCULATED_UPTO				,
                    V_DEBIT_INTEREST_ACCRUED_UPTO					,
                    V_DEBIT_INTEREST_BOOKED_UPTO					,
                    V_DUMMY											,
                    V_MIGRATED_CUMULATIVE_BAL_CREDIT				,
                    V_DATE_OF_MIGRATED_CUMULATIVE_BAL,
                    InpSolId
                );
            --}
            end loop;
        --}
        END CS006;
    --} Procudre CS006 End

    PROCEDURE CS007 (InpSolId IN VARCHAR2) IS
    --{
        V_INDICATOR                     VARCHAR2(3) := '';
        V_ACCOUNT_NUMBER                VARCHAR2(16) := '';
        V_CURRENCY_CODE                 VARCHAR2(3) := '';
        V_BEGIN_CHEQUE_NUMBER           NUMBER(16) := '';
        V_NUMBER_OF_CHEQUE_LEAVES       NUMBER(4) := '';
        V_DATE_OF_ISSUE                 DATE := '';
        V_CHEQUE_LEAF_STATUS            VARCHAR2(100) := '';
        V_BEGIN_CHEQUE_ALPHA            VARCHAR2(6) := '';
        V_IS_DUMMY                      VARCHAR2(100) := '';

        CURSOR C1(CurSolId VARCHAR2) is
        SELECT ACTUAL_ACNUM,INTERNAL_ACNUM FROM VALID_CASA WHERE SOL_ID = CurSolId;

        CURSOR C2(CurInternalAcctNum VARCHAR2) IS
        WITH cheque_range (
            CBISS_CLIENT_ACNUM,
            CBISS_CHQBK_SIZE,
            CBISS_FROM_LEAF_NUM,
            CBISS_UPTO_LEAF_NUM,
            CBISS_ISSUE_DATE,
            CHQ_NUM
        ) AS (
            SELECT
                CBISS_CLIENT_ACNUM,
                CBISS_CHQBK_SIZE,
                CBISS_FROM_LEAF_NUM,
                CBISS_UPTO_LEAF_NUM,
                CBISS_ISSUE_DATE,
                CBISS_FROM_LEAF_NUM AS CHQ_NUM
            FROM CBS.CBISS
            WHERE CBISS_CLIENT_ACNUM = CurInternalAcctNum
            UNION ALL
            SELECT
                CBISS_CLIENT_ACNUM,
                CBISS_CHQBK_SIZE,
                CBISS_FROM_LEAF_NUM,
                CBISS_UPTO_LEAF_NUM,
                CBISS_ISSUE_DATE,
                CHQ_NUM + 1
            FROM cheque_range
            WHERE CHQ_NUM < CBISS_UPTO_LEAF_NUM
            AND CBISS_CLIENT_ACNUM = CurInternalAcctNum
        )
        SELECT
            CBISS_CLIENT_ACNUM,
            CBISS_ISSUE_DATE,
            CBISS_CHQBK_SIZE,
            CBISS_FROM_LEAF_NUM,
            CBISS_UPTO_LEAF_NUM,
            LISTAGG(
            CASE
                WHEN C.CHQUSG_CHQ_NUM IS NOT NULL THEN 'P'
                ELSE 'U'
            END, ''
            ) WITHIN GROUP (ORDER BY CHQ_NUM) AS cheque_status
        FROM
        cheque_range R
        LEFT JOIN
        CBS.CHQUSG C
        ON
        R.CBISS_CLIENT_ACNUM = C.CHQUSG_INTERNAL_AC_NUM
        AND C.CHQUSG_INTERNAL_AC_NUM = CurInternalAcctNum
        AND R.CHQ_NUM = C.CHQUSG_CHQ_NUM
        GROUP BY
            CBISS_CLIENT_ACNUM,
            CBISS_ISSUE_DATE,
            CBISS_FROM_LEAF_NUM,
            CBISS_UPTO_LEAF_NUM,
            CBISS_CHQBK_SIZE,
            CBISS_ISSUE_DATE;

        BEGIN
        --{
            V_INDICATOR := 'CBS';
            V_CURRENCY_CODE := 'INR';

            FOR J IN C1(InpSolId)
            LOOP
            --{
                FOR I IN C2(J.INTERNAL_ACNUM)
                LOOP
                --{
                    V_ACCOUNT_NUMBER := J.ACTUAL_ACNUM;
                    V_BEGIN_CHEQUE_NUMBER := I.CBISS_FROM_LEAF_NUM;
                    V_NUMBER_OF_CHEQUE_LEAVES := (I.CBISS_UPTO_LEAF_NUM - I.CBISS_FROM_LEAF_NUM);
                    V_DATE_OF_ISSUE := I.CBISS_ISSUE_DATE;

                    IF (LENGTH(I.CHEQUE_STATUS) < 100) THEN
                    --{
                        V_CHEQUE_LEAF_STATUS := I.CHEQUE_STATUS;

                        INSERT INTO CS007 VALUES
                        (
                            V_INDICATOR
                            ,V_ACCOUNT_NUMBER
                            ,V_CURRENCY_CODE
                            ,V_BEGIN_CHEQUE_NUMBER
                            ,V_NUMBER_OF_CHEQUE_LEAVES
                            ,V_DATE_OF_ISSUE
                            ,V_CHEQUE_LEAF_STATUS
                            ,V_BEGIN_CHEQUE_ALPHA
                            ,V_IS_DUMMY
                            ,InpSolId
                        );
                    --}
                    ELSE
                    --{
                        INSERT INTO CS007_FAIL VALUES (V_ACCOUNT_NUMBER,I.CBISS_FROM_LEAF_NUM,I.CBISS_UPTO_LEAF_NUM);
                    --}
                    END IF;
                --}
                END LOOP;
            --}
            END LOOP;
        --}
        END CS007;
    --} Procudre CS007 End

    PROCEDURE CS008 (InpSolId IN VARCHAR2) IS
    --{
        V_ACCOUNT_NUMBER                NVARCHAR2(16) := '';
        V_BEGIN_CHEQUE_NUMBER           NVARCHAR2(16) := '';
        V_SP_ACCEPTANCE_DATE            DATE := '';
        V_CHEQUE_DATE                   DATE := '';
        V_CHEQUE_AMOUNT                 NUMERIC(14,2) := '';
        V_PAYEE_NAME                    NVARCHAR2(40) := '';
        V_NO_OF_LEAVES                  NUMERIC(3,0) := '';
        V_CHEQUE_ALPHA_CODE             NVARCHAR2(6) := '';
        V_REASON_CODE_FOR_STOP_PAYMENT  NVARCHAR2(5) := '';
        V_ACCOUNT_BALANCE               NUMBER(14,2) := '';
        V_CURRENCY_CODE                 NVARCHAR2(3) := '';

        CURSOR C1(CurSolId VARCHAR2) IS
        SELECT 
            ACTUAL_ACNUM
            ,b.STOPCHQ_FROM_CHQ_NUM
            ,b.STOPCHQ_ENTRY_DATE
            ,b.STOPCHQ_NUM_CHQS_STOPPED 
        FROM 
            valid_casa a,cbs.STOPCHQ b
        WHERE 
            a.INTERNAL_ACNUM = b.STOPCHQ_INTERNAL_AC_NUM
        AND a.ENTITY_NUM = b.STOPCHQ_ENTITY_NUM
        AND a.SOL_ID = CurSolId
        AND a.ENTITY_NUM  = 1;

        /*cursor c1(CurSolId VARCHAR2) is
        select IACLINK.IACLINK_ACTUAL_ACNUM as Account_number,
        stopchq.STOPCHQ_FROM_CHQ_NUM as Begin_Cheque_Number,
        stopchq.STOPCHQ_ENTRY_DATE as SP_Acceptance_Date,
        STOPCHQ_CHQ_DATE Cheque_Date,
        STOPCHQ_CHQ_AMT as Cheque_Amount,
        STOPCHQ_CHQ_BENEF_NAME as Payee_Name,
        stopchq.STOPCHQ_NUM_CHQS_STOPPED as No_of_Leaves,
        null as Cheque_Alpha_Code,
        --'BPD' as REASON_CODE_FOR_STOP_PAYMENT,-----STOPCHQ_REASON1
        '007' as REASON_CODE_FOR_STOP_PAYMENT,-----STOPCHQ_REASON1
        null as Account_Balance,
        'INR' as Currency_Code
        from cbs.acnts acnts
        inner join cbs.IACLINK IACLINK
            on (IACLINK.IACLINK_ENTITY_NUM=ACNTS.ACNTS_ENTITY_NUM
                and IACLINK.IACLINK_ACCOUNT_NUMBER=ACNTS.ACNTS_ACCOUNT_NUMBER)
        inner join cbs.products products
            on (ACNTS.ACNTS_PROD_CODE=products.PRODUCT_CODE
                and products.PRODUCT_GROUP_CODE in('01','02','11'))
        inner join cbs.stopchq stopchq
            on (stopchq.STOPCHQ_ENTITY_NUM=IACLINK.IACLINK_ENTITY_NUM
                AND stopchq.STOPCHQ_INTERNAL_AC_NUM=IACLINK.IACLINK_INTERNAL_ACNUM)
        where ACNTS.ACNTS_BRN_CODE=CurSolId
            and (acnts.ACNTS_CLOSURE_DATE is null or acnts.ACNTS_CLOSURE_DATE>UTK_FN_GET_CURR_FIN_YR_START_DT)
        ;
        */

        BEGIN
        --{
            V_CURRENCY_CODE := 'INR';
            V_REASON_CODE_FOR_STOP_PAYMENT := '007';

            for i in c1(InpSolId)
            loop
            --{
                V_ACCOUNT_NUMBER        := I.ACTUAL_ACNUM;
                V_BEGIN_CHEQUE_NUMBER   := I.STOPCHQ_FROM_CHQ_NUM;
                V_SP_ACCEPTANCE_DATE    := I.STOPCHQ_ENTRY_DATE;
                V_NO_OF_LEAVES          := I.STOPCHQ_NUM_CHQS_STOPPED;
    
                INSERT INTO CS008 VALUES
                (
                    V_ACCOUNT_NUMBER,
                    V_BEGIN_CHEQUE_NUMBER,
                    V_SP_ACCEPTANCE_DATE,
                    V_CHEQUE_DATE,
                    V_CHEQUE_AMOUNT,
                    V_PAYEE_NAME,
                    V_NO_OF_LEAVES,
                    V_CHEQUE_ALPHA_CODE,
                    V_REASON_CODE_FOR_STOP_PAYMENT,
                    V_ACCOUNT_BALANCE,
                    V_CURRENCY_CODE,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END CS008;
    --} Procudre CS008 End

    PROCEDURE CS009 (InpSolId IN VARCHAR2) IS
    --{
        V_LIEN_ACCOUNT_NUMBER    NVARCHAR2(16) := '';
        V_LIEN_AMOUNT            NUMERIC(14,2) := '';
        V_CRNCY_CODE             NVARCHAR2(3) := '';
        V_LIEN_REASON_CODE       NVARCHAR2(5) := '';
        V_LIEN_START_DATE        DATE := '';
        V_LIEN_EXPIRY_DATE       DATE := '';
        V_LIEN_TYPE              NVARCHAR2(5) := '';
        V_ACCOUNT_ID             NVARCHAR2(16) := '';
        V_SI_CERTIFICATE_NUMBER  NVARCHAR2(20) := '';
        V_LIMIT_PREFIX           NVARCHAR2(12) := '';
        V_LIMIT_SUFFIX           NVARCHAR2(5) := '';
        V_DC_NUMBER              NVARCHAR2(16) := '';
        V_BG_NUMBER              NVARCHAR2(16) := '';
        V_SOL_ID                 NVARCHAR2(8) := '';
        V_LIEN_REMARKS           NVARCHAR2(50) := '';
        V_REQUESTED_BY           NVARCHAR2(80) := '';
        V_REQUESTED_DEPT         NVARCHAR2(80) := '';
        V_CONTACT_NO             NVARCHAR2(80) := '';
        V_IPO_INSTITUTION_NAME   NVARCHAR2(16) := '';
        V_IPO_APPLICATION_NO     NVARCHAR2(16) := '';

        cursor c1(CurSolId VARCHAR2) is
        SELECT
        VCA.ACTUAL_ACNUM AS Lien_Account_Number,
        ACNTLIEN.ACNTLIEN_LIEN_AMOUNT AS Lien_Amount,
        'INR' AS Crncy_Code,
        '3' AS Lien_Reason_Code,
        ACNTLIEN.ACNTLIEN_LIEN_DATE AS Lien_Start_Date,
        '' AS Lien_Expiry_Date,
        'ULIEN' AS Lien_Type,
        '' AS Account_ID,
        ACNTLIEN_LIEN_SL AS SI_Certificate_Number,
        NULL AS Limit_Prefix,
        NULL AS Limit_Suffix,
        NULL AS DC_Number,
        NULL AS BG_Number,
        TO_CHAR(ACNTLIEN.ACNTLIEN_LIEN_TO_BRN) AS SOL_ID,
        SUBSTR(ACNTLIEN_REASON1||ACNTLIEN_REASON2,1,50) AS Lien_Remarks,
        NULL AS Requested_By,
        'ACNTLIEN' AS Requested_Dept,
        NULL AS Contact_No,
        NULL AS IPO_Institution_Name,
        NULL AS IPO_Application_No
        --from cbs.acnts acnts
            from valid_casa vca
        /*        on (VCA.ENTITY_NUM=ACNTS.ACNTS_ENTITY_NUM
                AND vca.internal_acnum=ACNTS.ACNTS_INTERNAL_ACNUM)*/
            inner join CBS.ACNTLIEN ACNTLIEN
                on(VCA.ENTITY_NUM=ACNTLIEN.ACNTLIEN_ENTITY_NUM
                   AND vca.internal_acnum=ACNTLIEN.ACNTLIEN_INTERNAL_ACNUM
                   AND REPLACE(ACNTLIEN_REVOKED_ON,' ','') IS NULL)
        where (vca.sol_id=CurSolId)
        union all
        SELECT
        VCA.ACTUAL_ACNUM AS Lien_Account_Number,
        hovering.HOVERING_PENDING_AMT AS Lien_Amount,
        'INR' AS Crncy_Code,
        '3' AS Lien_Reason_Code,
        hovering.HOVERING_START_DATE AS Lien_Start_Date,
        '' AS Lien_Expiry_Date,
        'ULIEN' AS Lien_Type,
        VCA.ACTUAL_ACNUM AS Account_ID,
        HOVERING_SL_NUM AS SI_Certificate_Number,
        NULL AS Limit_Prefix,
        NULL AS Limit_Suffix,
        NULL AS DC_Number,
        NULL AS BG_Number,
        TO_CHAR(VCA.sol_id) AS SOL_ID,
        SUBSTR(HOVERING_RECOVERY_NARR1||HOVERING_RECOVERY_NARR2,1,50) AS Lien_Remarks,
        NULL AS Requested_By,
        'HOVERING' AS Requested_Dept,
        NULL AS Contact_No,
        NULL AS IPO_Institution_Name,
        NULL AS IPO_Application_No
        --from cbs.acnts acnts
            from valid_casa vca
        /*        on (VCA.ENTITY_NUM=ACNTS.ACNTS_ENTITY_NUM
                AND vca.internal_acnum=ACNTS.ACNTS_INTERNAL_ACNUM)*/
            inner join CBS.hovering hovering
                on(VCA.ENTITY_NUM=hovering.HOVERING_ENTITY_NUM
                   AND vca.internal_acnum=hovering.HOVERING_RECOVERY_FROM_ACNT)
        where (vca.sol_id=CurSolId AND hovering.HOVERING_PENDING_AMT > 0 ) ;

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                V_LIEN_ACCOUNT_NUMBER	:=i.LIEN_ACCOUNT_NUMBER;
                V_LIEN_AMOUNT			:=i.LIEN_AMOUNT;
                V_CRNCY_CODE			:=i.CRNCY_CODE;
                V_LIEN_REASON_CODE		:=i.LIEN_REASON_CODE;
                V_LIEN_START_DATE		:=i.LIEN_START_DATE;
                V_LIEN_EXPIRY_DATE		:=i.LIEN_EXPIRY_DATE;
                V_LIEN_TYPE				:=i.LIEN_TYPE;
                V_ACCOUNT_ID			:=i.ACCOUNT_ID;
                V_SI_CERTIFICATE_NUMBER :=i.SI_CERTIFICATE_NUMBER;
                V_LIMIT_PREFIX			:=i.LIMIT_PREFIX;
                V_LIMIT_SUFFIX			:=i.LIMIT_SUFFIX;
                V_DC_NUMBER				:=i.DC_NUMBER;
                V_BG_NUMBER				:=i.BG_NUMBER;
                V_SOL_ID				:=i.SOL_ID;
                V_LIEN_REMARKS			:=i.LIEN_REMARKS;
                V_REQUESTED_BY			:=i.REQUESTED_BY;
                V_REQUESTED_DEPT		:=i.REQUESTED_DEPT;
                V_CONTACT_NO			:=i.CONTACT_NO;
                V_IPO_INSTITUTION_NAME  :=i.IPO_INSTITUTION_NAME;
                V_IPO_APPLICATION_NO	:=i.IPO_APPLICATION_NO;

                INSERT INTO cs009 VALUES
                (
                    V_LIEN_ACCOUNT_NUMBER					,
                    V_LIEN_AMOUNT							,
                    V_CRNCY_CODE							,
                    V_LIEN_REASON_CODE						,
                    V_LIEN_START_DATE						,
                    V_LIEN_EXPIRY_DATE						,
                    V_LIEN_TYPE								,
                    V_ACCOUNT_ID							,
                    V_SI_CERTIFICATE_NUMBER					,
                    V_LIMIT_PREFIX							,
                    V_LIMIT_SUFFIX							,
                    V_DC_NUMBER								,
                    V_BG_NUMBER								,
                    V_SOL_ID								,
                    V_LIEN_REMARKS							,
                    V_REQUESTED_BY							,
                    V_REQUESTED_DEPT						,
                    V_CONTACT_NO							,
                    V_IPO_INSTITUTION_NAME					,
                    V_IPO_APPLICATION_NO
                );
            --}
            END LOOP;
        --}
        END CS009;
    --} Procudre CS009 End

    PROCEDURE CS014 (InpSolId IN VARCHAR2) IS
    --{
        v_SOL_ID  	                        NVarchar2(8)  := '';
        v_SI_FREQ_TYPE  	                NVarchar2(1)  := '';
        v_SI_FREQ_WEEK_NUM  	            NVarchar2(1)  := '';
        v_SI_FREQ_WEEK_DAY  	            NVarchar2(1)  := '';
        v_SI_FREQ_START_DD  	            NVarchar2(2)  := '';
        v_SI_FREQ_HLDY_STAT  	            NVarchar2(1)  := '';
        v_SI_EXEC_CODE  	                NVarchar2(1)  := '';
        v_SI_END_DATE  	                    Date := '';
        v_NEXT_EXEC_DATE  	                Date := '';
        v_TARGET_ACCOUNT  	                NVarchar2(16)  := '';
        v_BALANCE_INDICATOR  	            NVarchar2(1)  := '';
        v_EXCESS_SHORT_IND  	            NVarchar2(1)  := '';
        v_TGT_BALANCE  	                    Numeric(14,2)  := '';
        v_AUTO_PSTD_FLG  	                NVarchar2(1)  := '';
        v_CARRY_FOR_ALWD_FLG  	            NVarchar2(1)  := '';
        v_VALIDATE_CURRENCY_HOLIDAY_FLAG   	NVarchar2(1)  := '';
        v_DEL_TRAN_IF_NOT_PSTD  	        NVarchar2(1)  := '';
        v_CARRY_FORWARD_LIMIT  	            Numeric(5)  := '';
        v_SI_CLASS  	                    NVarchar2(1)  := '';
        v_CIF_ID  	                        NVarchar2(32)  := '';
        v_REMARKS  	                        NVarchar2(50)  := '';
        v_CLOSURE_REMARKS  	                NVarchar2(50)  := '';
        v_EXECUTION_CHARGE_CODE  	        NVarchar2(25)  := '';
        v_FAILURE_CHARGE_CODE  	            NVarchar2(25)  := '';
        v_CHARGE_RATE_CODE  	            NVarchar2(5)  := '';
        v_CHARGE_DEBIT_ACCOUNT_NUMBER  	    NVarchar2(16)  := '';
        v_AMOUNT_INDICATOR  	            NVarchar2(1)  := '';
        v_CREATE_MEMO_PAD_ENTRY  	        NVarchar2(1)  := '';
        v_CURRENCY_CODE  	                NVarchar2(3)  := '';
        v_FIXED_AMOUNT  	                Numeric(14,2)  := '';
        v_PART_TRAN_TYPE  	                NVarchar2(1)  := '';
        v_BALANCE_INDICATOR2  	            NVarchar2(1)  := '';
        v_EXCESS_SHORT_INDICATOR  	        NVarchar2(1)  := '';
        v_CREDIT_ACCOUNT_NO  	            NVarchar2(16)  := '';
        v_ACCOUNT_BALANCE  	                Numeric(14,2)  := '';
        v_CREDIT_PERCENTAGE  	            Numeric (8)  := '';
        v_CREDIT_AMOUNT_MULTIPLE  	        Numeric(14,2)  := '';
        v_CREDIT_ADM_ACCOUNT_NO  	        NVarchar2(16)  := '';
        v_ROUND_OFF_TYPE  	                NVarchar2(1)  := '';
        v_ROUND_OFF_VALUE  	                Numeric(14,2)  := '';
        v_COLLECT_CHARGES  	                NVarchar2(1)  := '';
        v_REPORT_CODE  	                    NVarchar2(5)  := '';
        v_REFERENCE_NUMBER  	            NVarchar2(20)  := '';
        v_TRAN_PARTICULAR  	                NVarchar2(50)  := '';
        v_TRAN_REMARKS  	                NVarchar2(30)  := '';
        v_INTENT_CODE  	                    NVarchar2(5)  := '';
        v_DD_PAYABLE_BANK_CODE  	        NVarchar2(6)  := '';
        v_DD_PAYABLE_BRANCH_CODE  	        NVarchar2(6)  := '';
        v_PAYEE_NAME  	                    NVarchar2(80)  := '';
        v_PURCHASE_ACCOUNT_NUMBER  	        NVarchar2(16)  := '';
        v_PURCHASE_NAME  	                NVarchar2(80)  := '';
        v_CR_ADV_PYMNT_FLG   	            NVarchar2(1)  := '';
        v_DR_AMOUNT_INDICATOR  	            NVarchar2(1)  := '';
        v_DEBIT_CREATE_MEMO_PAD_ENTRY  	    NVarchar2(1)  := '';
        v_DEBIT_ADM_ACCOUNT_NO  	        NVarchar2(16)  := '';
        v_ROUND_OFF_TYPE2  	                NVarchar2(1)  := '';
        v_ROUND_OFF_VALUE2  	            Numeric(14,2)  := '';
        v_DR_COLLECT_CHARGES  	            NVarchar2(1)  := '';
        v_REPORT_CODE2  	                NVarchar2(5)  := '';
        v_REFERENCE_NUMBER1  	            NVarchar2(20)  := '';
        v_DR_TRAN_PARTICULAR  	            NVarchar2(50)  := '';
        v_TRAN_REMARKS2  	                NVarchar2(30)  := '';
        v_DR_INTENT_CODE  	                NVarchar2(5)  := '';
        v_SI_PRIORITY  	                    NVarchar2(3)  := '';
        v_SI_FREQ_CAL_BASE  	            NVarchar2(2)  := '';
        v_CR_CEILING_AMT  	                Numeric(14,2)  := '';
        v_CR_CUMULATIVE_AMT  	            Numeric(14,2)  := '';
        v_DR_CEILING_AMT  	                Numeric(14,2)  := '';
        v_DR_CUMULATIVE_AMT  	            Numeric(14,2)  := '';
        v_SI_FREQ_N_DAYS  	                Numeric(3)  := '';
        v_SCRIPT_FILE_NAME  	            NVarchar2(100)  := '';
        v_CREDIT_CONVERSION_RATE_CODE  	    NVarchar2(5)  := '';
        v_DEBIT_CONVERSION_RATE_CODE  	    NVarchar2(5)  := '';

        V_SINDB_WEEK_DAY              varchar2(3) := '';
        V_SINDB_MONTHLY_DAY           varchar2(3) := '';
        V_SINDB_QHY_FREQ_DAY          varchar2(3) := '';

        CURSOR C1(CurSolId VARCHAR2) IS
        SELECT  
            SINDB_BRN_CODE
            ,SINDB_EXE_FREQ
            ,SINDB_WEEK_DAY
            ,SINDB_MONTHLY_DAY
            ,SINDB_QHY_FREQ_DAY
            ,DECODE(SINDB_HOLIDAY_CHOICE,'0','S','1','P','N') SI_FREQ_HLDY_STAT
            ,DECODE(SINDB_TIME_CHOICE,'1','B','A') SI_EXEC_CODE
            ,SINDB_END_DATE
            ,SINDB_CLIENT_NUM
            ,SINDB_REM_NOTES1
            ,SINDB_FIXED_AMT
            ,CBS.FACNO(1,SINDB.SINDB_INTERNAL_ACNUM) as DEBIT_ADM_ACCOUNT_NO
            ,SINDB_ENTITY_NUM
            ,SINDB_SIN_NUM
        FROM 
            CBS.SINDB 
        WHERE 
            SINDB_END_DATE > UTK_FN_GET_EOD_DATE 
        AND SINDB_AUTH_BY is not null
        AND SINDB_BRN_CODE = CurSolId
        AND NOT EXISTS (SELECT 1 FROM CBS.SINCANCEL 
                    WHERE SINCAN_SIN_NUM = SINDB.SINDB_SIN_NUM 
                    AND SINCAN_BRN_CODE = SINDB.SINDB_BRN_CODE
                    AND SINCAN_ENTITY_NUM = SINDB.SINDB_ENTITY_NUM);
        /*
        cursor c1(CurSolId VARCHAR2) is
        SELECT
        vsi.SINDB_BRN_CODE as SOL_ID,
        SINDB.SINDB_EXE_FREQ as SI_Freq_Type,
        null as SI_Freq_Week_Num, --- mandatory
        SINDB.SINDB_WEEK_DAY as SI_Freq_Week_Day,
            case SINDB.SINDB_EXE_FREQ
                WHEN 'W' then to_char(SINDB.SINDB_WEEK_DAY)
                WHEN 'M' then to_char(SINDB.SINDB_MONTHLY_DAY)
                WHEN 'Y' then to_char(SINDB.SINDB_QHY_FREQ_DAY)
            end as SI_Freq_Start_DD,
        case SINDB.SINDB_HOLIDAY_CHOICE
            WHEN '0' then 'S'
            WHEN '1' THEN 'P'
            ELSE 'N'
        END as SI_Freq_Hldy_Stat,
        case SINDB_TIME_CHOICE
            WHEN '1' THEN 'B'
            WHEN '2' THEN 'A'
            ELSE 'A'
        END as SI_exec_code,
        sindb.SINDB_END_DATE as SI_end_date,
        siexec.SINEXECSTAT_DUE_DATE_OF_EXEC as Next_exec_date, -- mandatory
        --cbs.facno(1,SINDB.SINDB_INTERNAL_ACNUM) as Target_Account,
        null as Target_Account,
        null as Balance_Indicator,
        null as Excess_Short_Ind,
        null as Tgt_balance,
        'Y' as Auto_pstd_flg,
        'Y' as Carry_for_alwd_flg,
        'N' as Validate_Currency_Holiday_Flag,
        'Y' as Del_tran_if_not_pstd,
        0 as Carry_forward_limit,
        'C' as SI_Class,
        SINDB.SINDB_CLIENT_NUM as CIF_ID,
        SINDB_REM_NOTES1 as Remarks,
        null as Closure_remarks,
        null as Execution_charge_code,
        null as Failure_charge_code,
        null as Charge_rate_code,
        null as Charge_debit_account_number,
        'F' as Amount_Indicator,
        'N' as Create_Memo_Pad_Entry,
        'INR' as Currency_Code,
        SINDB.SINDB_FIXED_AMT as Fixed_Amount,
        'D' as Part_Tran_Type,
        'C' as Balance_Indicator2,
        'S' as Excess_Short_Indicator,
        null as Credit_Account_No,
        null as Account_Balance,
        null as Credit_Percentage,
        null as Credit_Amount_multiple,
        cbs.facno(1,SINDBTRFDISP.SINDBTRFDISP_ACNT_NUM) as Credit_ADM_Account_No,
        --null as Credit_ADM_Account_No,
        null as Round_off_Type,
        null as Round_off_Value,
        'N' as Collect_Charges,
        null as Report_Code,
        null as Reference_Number,
        null as Tran_particular,
        null as Tran_remarks,
        null as Intent_Code,
        null as DD_payable_bank_code,
        null as DD_payable_branch_code,
        null as Payee_name,
        null as Purchase_Account_Number,
        null as Purchase_Name,
        null as cr_adv_pymnt_flg,
        'C' as Dr_Amount_Indicator,
        'N' as Debit_Create_Memo_Pad_Entry,
        cbs.facno(1,SINDB.SINDB_INTERNAL_ACNUM) as Debit_ADM_Account_No,
        --null as Debit_ADM_Account_No,
        null as Round_off_Type2,
        null as Round_off_Value2,
        'N' as Dr_Collect_Charges,
        null as Report_Code2,
        null as REFERENCE_NUMBER1,
        null as Dr_Tran_particular,
        null as Tran_remarks2,
        null as Dr_Intent_Code,
        null as SI_priority,
        null as si_freq_cal_base,
        null as cr_ceiling_amt,
        null as cr_cumulative_amt,
        null as dr_ceiling_amt,
        null as dr_cumulative_amt,
        null as SI_Freq_N_Days,
        null as Script_File_Name,
        null as Credit_Conversion_rate_Code,
        null as Debit_conversion_rate_code
        from valid_si vsi 
        inner join cbs.sindb SINDB
            on (vsi.sindb_entity_num=sindb.SINDB_ENTITY_NUM
                and vsi.sindb_brn_code=sindb.SINDB_BRN_CODE
                and vsi.sindb_sin_num=sindb.SINDB_SIN_NUM
                )
            inner join cbs.SINDBTRFDISP SINDBTRFDISP
             on (vsi.SINDB_ENTITY_NUM=SINDBTRFDISP.SINDBTRFDISP_ENTITY_NUM
                and vsi.SINDB_BRN_CODE=SINDBTRFDISP.SINDBTRFDISP_BRN_CODE
                and vsi.SINDB_SIN_NUM=SINDBTRFDISP.SINDBTRFDISP_SIN_NUM
                and SINDB.SINDB_AUTH_BY is not null
                --and SINDB.SINDB_END_DATE<=UTK_FN_GET_CURR_FIN_YR_END_DT)
                and SINDB.SINDB_END_DATE > UTK_FN_GET_EOD_DATE)
            inner join cbs.SINEXECSTAT siexec
                on (vsi.sindb_entity_num=siexec.SINEXECSTAT_ENTITY_NUM
                and vsi.sindb_brn_code=siexec.SINEXECSTAT_BRN_CODE
                and vsi.sindb_sin_num=siexec.SINEXECSTAT_SIN_NUM
                and siexec.SINEXECSTAT_DUE_DATE_OF_EXEC=(select max(trunc(SINEXECSTAT_DUE_DATE_OF_EXEC))
                                                from cbs.SINEXECSTAT where SINEXECSTAT_ENTITY_NUM=siexec.SINEXECSTAT_ENTITY_NUM
                                                                      and SINEXECSTAT_BRN_CODE=siexec.SINEXECSTAT_BRN_CODE
                                                                      and SINEXECSTAT_SIN_NUM=siexec.SINEXECSTAT_SIN_NUM
                                                )
                    )
    where SINDB.SINDB_BRN_CODE=CurSolId;
        */
        
        BEGIN
        --{
            V_AUTO_PSTD_FLG := 'Y';
            V_CARRY_FOR_ALWD_FLG := 'Y';
            V_VALIDATE_CURRENCY_HOLIDAY_FLAG := 'N';
            v_DEL_TRAN_IF_NOT_PSTD := 'Y';
            V_CARRY_FORWARD_LIMIT := 0;
            V_SI_CLASS := 'C';
            V_AMOUNT_INDICATOR := 'F';
            V_CREATE_MEMO_PAD_ENTRY := 'N';
            V_CURRENCY_CODE := 'INR';
            V_PART_TRAN_TYPE := 'D';
            V_BALANCE_INDICATOR2 := 'C';
            V_EXCESS_SHORT_INDICATOR := 'S';
            V_COLLECT_CHARGES := 'N';
            V_DR_AMOUNT_INDICATOR := 'C';
            V_DEBIT_CREATE_MEMO_PAD_ENTRY := 'N';
            v_DR_COLLECT_CHARGES := 'N';

            for i in c1(InpSolId)
            loop
            --{
                V_SOL_ID                := LPAD(I.SINDB_BRN_CODE,4,'0');
                V_SI_FREQ_TYPE          := I.SINDB_EXE_FREQ;
                v_SI_FREQ_HLDY_STAT     := I.SI_FREQ_HLDY_STAT;
                V_SI_EXEC_CODE          := I.SI_EXEC_CODE;
                V_SI_END_DATE           := I.SINDB_END_DATE;
                V_CIF_ID                := I.SINDB_CLIENT_NUM;
                V_REMARKS               := I.SINDB_REM_NOTES1;
                V_FIXED_AMOUNT          := I.SINDB_FIXED_AMT;
                v_DEBIT_ADM_ACCOUNT_NO  := I.DEBIT_ADM_ACCOUNT_NO;

                IF(V_SI_FREQ_TYPE = 'W') THEN
                --{
                    v_SI_FREQ_START_DD := I.SINDB_WEEK_DAY;
                --}
                ELSIF(V_SI_FREQ_TYPE = 'M') THEN
                --{
                    v_SI_FREQ_START_DD := I.SINDB_MONTHLY_DAY;
                --}
                ELSIF(V_SI_FREQ_TYPE = 'Y') THEN
                --{
                    v_SI_FREQ_START_DD := I.SINDB_QHY_FREQ_DAY;
                --}
                ELSE
                --{
                    v_SI_FREQ_START_DD := '';
                --}
                END IF;

                BEGIN
                    SELECT 
                        cbs.facno(1,SINDBTRFDISP.SINDBTRFDISP_ACNT_NUM)
                    INTO
                        V_CREDIT_ADM_ACCOUNT_NO
                    FROM
                        CBS.SINDBTRFDISP
                    WHERE 
                        SINDBTRFDISP_ENTITY_NUM = I.SINDB_ENTITY_NUM
                    AND SINDBTRFDISP_BRN_CODE = I.SINDB_BRN_CODE
                    AND SINDBTRFDISP_SIN_NUM = I.SINDB_SIN_NUM;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_CREDIT_ADM_ACCOUNT_NO := NULL;
                END;

                BEGIN
                    SELECT 
                        SINEXECSTAT_DUE_DATE_OF_EXEC
                    INTO
                        V_NEXT_EXEC_DATE
                    FROM
                        CBS.SINEXECSTAT SIEXEC
                    WHERE 
                        SINEXECSTAT_ENTITY_NUM = I.SINDB_ENTITY_NUM
                    AND SINEXECSTAT_BRN_CODE = I.SINDB_BRN_CODE
                    AND SINEXECSTAT_SIN_NUM = I.SINDB_SIN_NUM
                    AND siexec.SINEXECSTAT_DUE_DATE_OF_EXEC=(select max(trunc(SINEXECSTAT_DUE_DATE_OF_EXEC))
                                                from cbs.SINEXECSTAT where SINEXECSTAT_ENTITY_NUM=siexec.SINEXECSTAT_ENTITY_NUM
                                                                      and SINEXECSTAT_BRN_CODE=siexec.SINEXECSTAT_BRN_CODE
                                                                      and SINEXECSTAT_SIN_NUM=siexec.SINEXECSTAT_SIN_NUM
                                                );
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_NEXT_EXEC_DATE := NULL;
                END;

                INSERT INTO CS014 VALUES
                (
                    v_SOL_ID,
                    v_SI_FREQ_TYPE,
                    v_SI_FREQ_WEEK_NUM,
                    v_SI_FREQ_WEEK_DAY,
                    v_SI_FREQ_START_DD,
                    v_SI_FREQ_HLDY_STAT,
                    v_SI_EXEC_CODE,
                    v_SI_END_DATE,
                    v_NEXT_EXEC_DATE,
                    v_TARGET_ACCOUNT,
                    v_BALANCE_INDICATOR,
                    v_EXCESS_SHORT_IND,
                    v_TGT_BALANCE,
                    v_AUTO_PSTD_FLG,
                    v_CARRY_FOR_ALWD_FLG,
                    v_VALIDATE_CURRENCY_HOLIDAY_FLAG,
                    v_DEL_TRAN_IF_NOT_PSTD,
                    v_CARRY_FORWARD_LIMIT,
                    v_SI_CLASS,
                    v_CIF_ID,
                    v_REMARKS,
                    v_CLOSURE_REMARKS,
                    v_EXECUTION_CHARGE_CODE,
                    v_FAILURE_CHARGE_CODE,
                    v_CHARGE_RATE_CODE,
                    v_CHARGE_DEBIT_ACCOUNT_NUMBER,
                    v_AMOUNT_INDICATOR,
                    v_CREATE_MEMO_PAD_ENTRY,
                    v_CURRENCY_CODE,
                    v_FIXED_AMOUNT,
                    v_PART_TRAN_TYPE,
                    v_BALANCE_INDICATOR2,
                    v_EXCESS_SHORT_INDICATOR,
                    v_CREDIT_ACCOUNT_NO,
                    v_ACCOUNT_BALANCE,
                    v_CREDIT_PERCENTAGE,
                    v_CREDIT_AMOUNT_MULTIPLE,
                    v_CREDIT_ADM_ACCOUNT_NO,
                    v_ROUND_OFF_TYPE,
                    v_ROUND_OFF_VALUE,
                    v_COLLECT_CHARGES,
                    v_REPORT_CODE,
                    v_REFERENCE_NUMBER,
                    v_TRAN_PARTICULAR,
                    v_TRAN_REMARKS,
                    v_INTENT_CODE,
                    v_DD_PAYABLE_BANK_CODE,
                    v_DD_PAYABLE_BRANCH_CODE,
                    v_PAYEE_NAME,
                    v_PURCHASE_ACCOUNT_NUMBER,
                    v_PURCHASE_NAME,
                    v_CR_ADV_PYMNT_FLG,
                    v_DR_AMOUNT_INDICATOR,
                    v_DEBIT_CREATE_MEMO_PAD_ENTRY,
                    v_DEBIT_ADM_ACCOUNT_NO,
                    v_ROUND_OFF_TYPE2,
                    v_ROUND_OFF_VALUE2,
                    v_DR_COLLECT_CHARGES,
                    v_REPORT_CODE2,
                    v_REFERENCE_NUMBER1,
                    v_DR_TRAN_PARTICULAR,
                    v_TRAN_REMARKS2,
                    v_DR_INTENT_CODE,
                    v_SI_PRIORITY,
                    v_SI_FREQ_CAL_BASE,
                    v_CR_CEILING_AMT,
                    v_CR_CUMULATIVE_AMT,
                    v_DR_CEILING_AMT,
                    v_DR_CUMULATIVE_AMT,
                    v_SI_FREQ_N_DAYS,
                    v_SCRIPT_FILE_NAME,
                    v_CREDIT_CONVERSION_RATE_CODE,
                    v_DEBIT_CONVERSION_RATE_CODE
                );
            --}
            END LOOP;
        --}
        END CS014;
    --} Procudre CS014 End

    PROCEDURE CS015 (InpSolId IN VARCHAR2) IS
    --{
        V_ACCOUNT_NO                              NVARCHAR2(16) := '';
        V_APPLICABLE_DATE                         DATE := '';
        V_CURRENCY_CODE                           NVARCHAR2(3) := '';
        V_SANCTION_LIMIT_AMOUNT                   NUMERIC(14,2) := '';
        V_LIMIT_SANCTION_DATE                     DATE := '';
        V_LIMIT_EXPIRY_DATE                       DATE := '';
        V_LIMIT_PENALTY_MONTH                     NUMERIC(4,0) := '';
        V_LIMIT_PENALTY_DAY                       NUMERIC(4,0) := '';
        V_LOAN_PAPER_DATE                         DATE := '';
        V_LIMIT_REVIEW_DATE                       DATE := '';
        V_SANCTION_LEVEL_CODE                     NVARCHAR2(5) := '';
        V_SANCTION_AUTHORITY_CODE                 NVARCHAR2(5) := '';
        V_SANCTION_REF_NUMBER                     NVARCHAR2(25) := '';
        V_LIMIT_LEVEL_INTEREST_FLAG               NVARCHAR2(1) := '';
        V_LIMIT_NORMAL_INTEREST_RATE              NUMERIC(10,0) := '';
        V_LIMIT_PENAL_INTEREST_RATE               NUMERIC(10,0) := '';
        V_SECURITY_DESCRIPTION                    NVARCHAR2(240) := '';
        V_REMARKS                                 NVARCHAR2(240) := '';
        V_LIMIT_MARGIN_INTEREST_RATE              NUMERIC(10,0) := '';
        V_MAX_SANCTION_LIMIT                      NUMERIC(14,2) := '';

        cursor c1(CurSolId VARCHAR2) is
        select
        cl006mb.FACILITY_CODE as Account_no,
        cl006mb.START_DT as Applicable_Date,
        'INR' as Currency_Code,cl006mb.LCY_ALLOWED_LMT as Sanction_Limit_Amount,
        cl006mb.START_DT as Limit_Sanction_Date,
        cl006mb.MATURITY_DT as Limit_Expiry_Date,
        '9999' as Limit_Penalty_Month,
        0 as Limit_Penalty_Day,
        cl006mb.START_DT as Loan_paper_date,
        cl006mb.MATURITY_DT-1 as Limit_review_date,
        'MIGRA' as Sanction_level_code,
        'Migra' as Sanction_authority_code,
        cl006mb.FACILITY_CODE as Sanction_ref_number,
        'N' as Limit_level_Interest_Flag,
        null as Limit_Normal_Interest_Rate,
        null as Limit_Penal_Interest_Rate,
        null as Security_Description,
        null as Remarks,
        null as Limit_Margin_Interest_Rate,
        null as Max_Sanction_Limit
        from clms.cl006mb cl006mb
            inner join VALID_CASA VCA
                on (cl006mb.FACILITY_CODE=VCA.ACTUAL_ACNUM
                    AND GROUP_CODE='11')
        where  VCA.SOL_ID=CurSolId
        ;

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                V_ACCOUNT_NO								 := i.ACCOUNT_NO;
                V_APPLICABLE_DATE							 := i.APPLICABLE_DATE;
                V_CURRENCY_CODE								 := i.CURRENCY_CODE;
                V_SANCTION_LIMIT_AMOUNT						 := i.SANCTION_LIMIT_AMOUNT;
                V_LIMIT_SANCTION_DATE						 := i.LIMIT_SANCTION_DATE;
                V_LIMIT_EXPIRY_DATE							 := i.LIMIT_EXPIRY_DATE;
                V_LIMIT_PENALTY_MONTH						 := i.LIMIT_PENALTY_MONTH;
                V_LIMIT_PENALTY_DAY							 := i.LIMIT_PENALTY_DAY;
                V_LOAN_PAPER_DATE							 := i.LOAN_PAPER_DATE;
                V_LIMIT_REVIEW_DATE							 := i.LIMIT_REVIEW_DATE;
                V_SANCTION_LEVEL_CODE						 := i.SANCTION_LEVEL_CODE;
                V_SANCTION_AUTHORITY_CODE					 := i.SANCTION_AUTHORITY_CODE;
                V_SANCTION_REF_NUMBER						 := i.SANCTION_REF_NUMBER;
                V_LIMIT_LEVEL_INTEREST_FLAG					 := i.LIMIT_LEVEL_INTEREST_FLAG;
                V_LIMIT_NORMAL_INTEREST_RATE				 := i.LIMIT_NORMAL_INTEREST_RATE;
                V_LIMIT_PENAL_INTEREST_RATE					 := i.LIMIT_PENAL_INTEREST_RATE;
                V_SECURITY_DESCRIPTION						 := i.SECURITY_DESCRIPTION;
                V_REMARKS									 := i.REMARKS;
                V_LIMIT_MARGIN_INTEREST_RATE				 := i.LIMIT_MARGIN_INTEREST_RATE;
                V_MAX_SANCTION_LIMIT						 := i.MAX_SANCTION_LIMIT;

                if (v_Sanction_ref_number is null) then
                --{Account_Status_Date
                    v_Sanction_ref_number:='MIG';
                --}
                end if;

                INSERT INTO cs015 VALUES
                (
                    V_ACCOUNT_NO,
                    V_APPLICABLE_DATE,
                    V_CURRENCY_CODE,
                    V_SANCTION_LIMIT_AMOUNT,
                    V_LIMIT_SANCTION_DATE,
                    V_LIMIT_EXPIRY_DATE,
                    V_LIMIT_PENALTY_MONTH,
                    V_LIMIT_PENALTY_DAY,
                    V_LOAN_PAPER_DATE,
                    V_LIMIT_REVIEW_DATE,
                    V_SANCTION_LEVEL_CODE,
                    V_SANCTION_AUTHORITY_CODE,
                    V_SANCTION_REF_NUMBER,
                    V_LIMIT_LEVEL_INTEREST_FLAG,
                    V_LIMIT_NORMAL_INTEREST_RATE,
                    V_LIMIT_PENAL_INTEREST_RATE,
                    V_SECURITY_DESCRIPTION,
                    V_REMARKS,
                    V_LIMIT_MARGIN_INTEREST_RATE,
                    V_MAX_SANCTION_LIMIT,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END CS015;
    --} Procudre CS015 End

    PROCEDURE CS016 (InpSolId IN VARCHAR2) IS
    --{
        V_ACCOUNT_NO                              NVARCHAR2(16) := '';
        V_APPLICABLE_DATE                         DATE := '';
        V_CURRENCY_CODE                           NVARCHAR2(3) := '';
        V_DRAWING_POWER_INDICATOR                 NVARCHAR2(1) := '';
        V_DRAWING_POWER                           NUMERIC(17,0) := '';
        V_DACC_LIMIT_PERCENTAGE                   NUMERIC(10,0) := '';
        V_DACC_LIMIT_ABSOLUTE_VALUE               NUMERIC(17,0) := '';
        V_DAFA_LIMIT_PERCENTAGE                   NVARCHAR2(10) := '';
        V_DAFA_LIMIT_ABSOLUTE_VALUE               NVARCHAR2(17) := '';
        V_REMARKS                                 NVARCHAR2(240) := '';
        V_RECALL_FLAG                             NVARCHAR2(1) := '';

        cursor c1(CurSolId VARCHAR2) is
        select
        cl006mb.FACILITY_CODE as Account_no,
        cl006mb.START_DT as Applicable_Date,
        'INR' as Currency_Code,
        'M' as Drawing_Power_Indicator,
        cl006mb.LCY_ALLOWED_LMT as Drawing_Power,
        null as DACC_Limit_Percentage,
        null as DACC_Limit_Absolute_Value,
        null as DAFA_Limit_Percentage,
        null as DAFA_Limit_Absolute_Value,
        null as Remarks,
        'N' as Recall_flag
        from clms.cl006mb cl006mb
            inner join VALID_CASA VCA
                on (cl006mb.FACILITY_CODE=VCA.ACTUAL_ACNUM
                    AND GROUP_CODE='11')
        where  VCA.SOL_ID=CurSolId
        ;

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                V_ACCOUNT_NO							 := i.ACCOUNT_NO;
                V_APPLICABLE_DATE						 := i.APPLICABLE_DATE;
                V_CURRENCY_CODE							 := i.CURRENCY_CODE;
                V_DRAWING_POWER_INDICATOR				 := i.DRAWING_POWER_INDICATOR;
                V_DRAWING_POWER							 := i.DRAWING_POWER;
                V_DACC_LIMIT_PERCENTAGE					 := i.DACC_LIMIT_PERCENTAGE;
                V_DACC_LIMIT_ABSOLUTE_VALUE				 := i.DACC_LIMIT_ABSOLUTE_VALUE;
                V_DAFA_LIMIT_PERCENTAGE					 := i.DAFA_LIMIT_PERCENTAGE;
                V_DAFA_LIMIT_ABSOLUTE_VALUE				 := i.DAFA_LIMIT_ABSOLUTE_VALUE;
                V_REMARKS								 := i.REMARKS;
                V_RECALL_FLAG							 := i.RECALL_FLAG;

                INSERT INTO cs016 VALUES
                (
                    V_ACCOUNT_NO,
                    V_APPLICABLE_DATE,
                    V_CURRENCY_CODE,
                    V_DRAWING_POWER_INDICATOR,
                    V_DRAWING_POWER,
                    V_DACC_LIMIT_PERCENTAGE,
                    V_DACC_LIMIT_ABSOLUTE_VALUE,
                    V_DAFA_LIMIT_PERCENTAGE,
                    V_DAFA_LIMIT_ABSOLUTE_VALUE,
                    V_REMARKS,
                    V_RECALL_FLAG,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END CS016;
    --} Procudre CS016 End

    PROCEDURE CS019 (InpSolId IN VARCHAR2) IS
    --{
        V_DD_ISSUED_BRANCH_CODE	NVARCHAR2(6) := '';
        V_DD_NUMBER				NUMERIC(16,0) := '';
        V_DD_ISSUE_DATE			DATE := '';
        V_DD_ISSUED_BANK_CODE	NVARCHAR2(6) := '';
        V_DD_CURRENCY			NVARCHAR2(3) := '';
        V_SCHEME_CODE			NVARCHAR2(5) := '';
        V_ISSUE_EXTN_CNTR_CODE	NVARCHAR2(2) := '';
        V_STATUS				NVARCHAR2(1) := '';
        V_STATUS_UPDATE_DATE	DATE := '';
        V_DD_AMOUNT				NUMERIC(14,2) := '';
        V_PAYEE_BRANCH_CODE		NVARCHAR2(6) := '';
        V_PAYEE_BANK_CODE		NVARCHAR2(6) := '';
        V_INSTRUMENT_NO			NUMERIC(16,0) := '';
        V_DD_REVALIDATION_DATE	DATE := '';
        V_PRINT_ADVICE_FLAG		NVARCHAR2(1) := '';
        V_PRINT_REMARKS			NVARCHAR2(50) := '';
        V_PAYING_BRANCH_CODE	NVARCHAR2(6) := '';
        V_PAYING_BANK_CODE		NVARCHAR2(6) := '';
        V_ROUTING_BRANCH_CODE	NVARCHAR2(6) := '';
        V_ROUTING_BANK_CODE		NVARCHAR2(6) := '';
        V_INSTRUMENT_TYPE		NVARCHAR2(6) := '';
        V_INSTRUMENT_ALPHA		NVARCHAR2(6) := '';
        V_PURCHASERS_NAME		NVARCHAR2(80) := '';
        V_PAYEES_NAME			NVARCHAR2(80) := '';
        V_PRINT_OPTION			NVARCHAR2(1) := '';
        V_PRINT_FLAG			NVARCHAR2(1) := '';
        V_PRINT_COUNT			NUMERIC(3,0) := '';
        V_DUPLICATE_ISSUE_COUNT NUMERIC(3,0) := '';
        V_DUPLICATE_ISSUE_DATE	DATE := '';
        V_RECTIFIED_COUNT		NUMERIC(3,0) := '';
        V_CAUTIONED_STATUS		NVARCHAR2(1) := '';
        V_REASON_FOR_CAUTION	NVARCHAR2(50) := '';
        V_PAID_EX_ADVICE		NVARCHAR2(1) := '';
        V_INVENTORY_SERIAL_NO	NUMERIC(16,0) := '';
        V_PAID_ADVICE_FLAG		NVARCHAR2(1) := '';
        V_ADVICE_RECEIVED_DATE  DATE := '';

        cursor c1(CurSolId VARCHAR2) is
        select
        lpad(DDPOPAYDB_ISSUED_BRN,4,'0') as DD_Issued_Branch_Code,
        DDPOPAYDB_LEAF_NUM as dd_number,
        DDPOPAYDB_INST_DATE as DD_Issue_Date,
        --DDPOPAYDB_ISSUED_BANK as DD_Issued_Bank_Code,
        '762' as DD_Issued_Bank_Code,
        'INR' as DD_Currency,
        'DDGEN' as Scheme_Code,
        '00' as Issue_Extn_Cntr_Code,
        'U' as Status,
        DDPOPAYDB_INST_DATE as Status_Update_Date,
        DDPOPAYDB_INST_AMT as DD_Amount,
        lpad(DDPOPAYDB_ISSUED_ON_BRN,4,'0') as Payee_Branch_Code,
        --DDPOPAYDB_ISSUED_ON_BNK as Payee_Bank_Code,
        '762' as Payee_Bank_Code,
        DDPOPAYDB_LEAF_NUM as Instrument_No,
        DDPOPAYDB_REVALID_DATE as DD_Revalidation_Date,
        'N' as Print_Advice_Flag,
        null as Print_Remarks,
        lpad(DDPOPAYDB_ISSUED_ON_BRN,4,'0') as Paying_Branch_Code,
        --DDPOPAYDB_ISSUED_ON_BNK as Paying_Bank_Code,
        '762' as Paying_Bank_Code,
        null as Routing_Branch_Code,
        null as Routing_Bank_Code,
        'DDS' as Instrument_Type,
        DDPOPAYDB_INST_PFX as INSTRUMENT_ALPHA,
        DDPOPAYDB_APPLICANT_NAME as Purchasers_Name,
        DDPOPAYDB_BENEF_NAME1 as Payees_Name,
        'L' as Print_Option,
        'N' as Print_Flag,
        1 as Print_Count,
        case DDPOPAYDB_STATUS
            when 'D' then 1
            else null
        end Duplicate_Issue_Count,
        case DDPOPAYDB_STATUS
            when 'D' then DDPOPAYDB_PAY_CAN_DUP_DATE
            else null
        end Duplicate_Issue_Date,
        null as Rectified_Count,
        null as Cautioned_Status,
        null as Reason_for_Caution,
        'N' as Paid_Ex_Advice,
        case DDPOPAYDB_STATUS
            when 'D' then DDPOPAYDB_LEAF_NUM
            else DDPOPAYDB_LEAF_NUM
        end Inventory_Serial_No,
        'N' as Paid_Advice_Flag,
        null as Advice_Received_Date
        from cbs.DDPOPAYDB
        where DDPOPAYDB_ISSUED_BRN=CurSolId
        and (replace(DDPOPAYDB_STATUS,' ','') is null or DDPOPAYDB_STATUS='D');

        BEGIN
        --{
            for i in c1(InpSolId)
            loop
            --{
                V_DD_ISSUED_BRANCH_CODE	:=i.DD_ISSUED_BRANCH_CODE;
                V_DD_NUMBER				:=i.DD_NUMBER;
                V_DD_ISSUE_DATE			:=i.DD_ISSUE_DATE;
                V_DD_ISSUED_BANK_CODE	:=i.DD_ISSUED_BANK_CODE;
                V_DD_CURRENCY			:=i.DD_CURRENCY;
                V_SCHEME_CODE			:=i.SCHEME_CODE;
                V_ISSUE_EXTN_CNTR_CODE	:=i.ISSUE_EXTN_CNTR_CODE;
                V_STATUS				:=i.STATUS;
                V_STATUS_UPDATE_DATE	:=i.STATUS_UPDATE_DATE;
                V_DD_AMOUNT				:=i.DD_AMOUNT;
                V_PAYEE_BRANCH_CODE		:=i.PAYEE_BRANCH_CODE;
                V_PAYEE_BANK_CODE		:=i.PAYEE_BANK_CODE;
                V_INSTRUMENT_NO			:=i.INSTRUMENT_NO;
                V_DD_REVALIDATION_DATE	:=i.DD_REVALIDATION_DATE;
                V_PRINT_ADVICE_FLAG		:=i.PRINT_ADVICE_FLAG;
                V_PRINT_REMARKS			:=i.PRINT_REMARKS;
                V_PAYING_BRANCH_CODE	:=i.PAYING_BRANCH_CODE;
                V_PAYING_BANK_CODE		:=i.PAYING_BANK_CODE;
                V_ROUTING_BRANCH_CODE	:=i.ROUTING_BRANCH_CODE;
                V_ROUTING_BANK_CODE		:=i.ROUTING_BANK_CODE;
                V_INSTRUMENT_TYPE		:=i.INSTRUMENT_TYPE;
                V_INSTRUMENT_ALPHA		:=i.INSTRUMENT_ALPHA;
                V_PURCHASERS_NAME		:=i.PURCHASERS_NAME;
                V_PAYEES_NAME			:=i.PAYEES_NAME;
                V_PRINT_OPTION			:=i.PRINT_OPTION;
                V_PRINT_FLAG			:=i.PRINT_FLAG;
                V_PRINT_COUNT			:=i.PRINT_COUNT;
                V_DUPLICATE_ISSUE_COUNT :=i.DUPLICATE_ISSUE_COUNT;
                V_DUPLICATE_ISSUE_DATE	:=i.DUPLICATE_ISSUE_DATE;
                V_RECTIFIED_COUNT		:=i.RECTIFIED_COUNT;
                V_CAUTIONED_STATUS		:=i.CAUTIONED_STATUS;
                V_REASON_FOR_CAUTION	:=i.REASON_FOR_CAUTION;
                V_PAID_EX_ADVICE		:=i.PAID_EX_ADVICE;
                V_INVENTORY_SERIAL_NO	:=i.INVENTORY_SERIAL_NO;
                V_PAID_ADVICE_FLAG		:=i.PAID_ADVICE_FLAG;
                V_ADVICE_RECEIVED_DATE	:=i.ADVICE_RECEIVED_DATE;

                INSERT INTO cs019 VALUES
                (
                    V_DD_ISSUED_BRANCH_CODE,
                    V_DD_NUMBER,
                    V_DD_ISSUE_DATE,
                    V_DD_ISSUED_BANK_CODE,
                    V_DD_CURRENCY,
                    V_SCHEME_CODE,
                    V_ISSUE_EXTN_CNTR_CODE,
                    V_STATUS,
                    V_STATUS_UPDATE_DATE,
                    V_DD_AMOUNT,
                    V_PAYEE_BRANCH_CODE,
                    V_PAYEE_BANK_CODE,
                    V_INSTRUMENT_NO,
                    V_DD_REVALIDATION_DATE,
                    V_PRINT_ADVICE_FLAG,
                    V_PRINT_REMARKS,
                    V_PAYING_BRANCH_CODE,
                    V_PAYING_BANK_CODE,
                    V_ROUTING_BRANCH_CODE,
                    V_ROUTING_BANK_CODE,
                    V_INSTRUMENT_TYPE,
                    V_INSTRUMENT_ALPHA,
                    V_PURCHASERS_NAME,
                    V_PAYEES_NAME,
                    V_PRINT_OPTION,
                    V_PRINT_FLAG,
                    V_PRINT_COUNT,
                    V_DUPLICATE_ISSUE_COUNT,
                    V_DUPLICATE_ISSUE_DATE,
                    V_RECTIFIED_COUNT,
                    V_CAUTIONED_STATUS,
                    V_REASON_FOR_CAUTION,
                    V_PAID_EX_ADVICE,
                    V_INVENTORY_SERIAL_NO,
                    V_PAID_ADVICE_FLAG,
                    V_ADVICE_RECEIVED_DATE,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END CS019;
    --} Procudre CS019 End
--}
END CasaPack;
/

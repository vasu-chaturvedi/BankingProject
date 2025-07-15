CREATE OR REPLACE PACKAGE CorpCifPack AS
--{
    PROCEDURE CC001 (InpSolId IN VARCHAR2);
    PROCEDURE CC002 (InpSolId IN VARCHAR2);
    PROCEDURE CC005 (InpSolId IN VARCHAR2);
    PROCEDURE CC007 (InpSolId IN VARCHAR2);
    PROCEDURE CC008 (InpSolId IN VARCHAR2);
--}
END CorpCifPack;
/

CREATE OR REPLACE PACKAGE BODY CorpCifPack AS
--{
    PROCEDURE CC001 (InpSolId IN VARCHAR2) IS
    --{
        V_CORP_KEY						Nvarchar2(32) := '';
        V_ENTITY_TYPE                   Nvarchar2(32) := '';
        V_CORPORATENAME_NATIVE          Nvarchar2(80) := '';
        V_RELATIONSHIP_STARTDATE        DATE := '';
        V_STATUS                        Nvarchar2(5) := '';
        V_LEGALENTITY_TYPE              Nvarchar2(30) := '';
        V_SEGMENT                       Nvarchar2(150) := '';
        V_SUBSEGMENT                    Nvarchar2(150) := '';
        V_WEBSITE_ADDRESS               Nvarchar2(100) := '';
        V_KEYCONTACT_PERSONNAME         Nvarchar2(30) := '';
        V_PHONECITYCODE                 Nvarchar2(15) := '';
        V_PHONELOCALCODE                Nvarchar2(15) := '';
        V_PHONECOUNTRYCODE              Nvarchar2(15) := '';
        V_NOTES                         Nvarchar2(255) := '';
        V_PRINCIPLE_PLACEOPERATION	    Nvarchar2(30) := '';
        V_BUSINESS_GROUP                Nvarchar2(30) := '';
        V_PRIMARYRM_ID                  Nvarchar2(15) := '';
        V_DATE_OF_INCORPORATION         DATE := '';
        V_DATE_OF_COMMENCEMENT          DATE := '';
        V_PRIMARY_SERVICE_CENTER        Nvarchar2(30) := '';
        V_RELATIONSHIP_CREATEDBY        Nvarchar2(30) := '';
        V_SECTOR                        Nvarchar2(5) := '';
        V_SUBSECTOR                     Nvarchar2(5) := '';
        V_TAXID                         Nvarchar2(50) := '';
        V_ENTITYCLASS                   Nvarchar2(30) := '';
        V_AVERAGE_ANNUALINCOME          Number(20,4) := '';
        V_SOURCE_OF_FUNDS               Nvarchar2(50) := '';
        V_GROUP_ID                      Nvarchar2(50) := '';
        V_GROUP_ID_CODE                 Nvarchar2(50) := '';
        V_PARENT_CIF                    Nvarchar2(38) := '';
        V_CUSTOMER_RATING               Nvarchar2(5) := '';
        V_HEALTH_CODE                   Nvarchar2(5) := '';
        V_RECORD_STATUS                 Nvarchar2(150) := '';
        V_EFFECTIVE_DATE                DATE := '';
        V_LINE_OF_ACTIVITY_DESC         Nvarchar2(50) := '';
        V_CUST_MGR_OPIN                 Nvarchar2(240) := '';
        V_CUST_TYPE_DESC                Nvarchar2(50) := '';
        V_CUST_STAT_CHG_DATE            DATE := '';
        V_TDS_TBL_DESC                  Nvarchar2(50) := '';
        V_CUST_SWIFT_CODE               Nvarchar2(12) := '';
        V_IS_SWIFT_CODE_OF_BANK         Nvarchar2(1) := '';
        V_CUSTDEPOSITSINOTHERBANKS      Number(20,4) := '';
        V_TOTALFUNDBASE                 Number(25,4) := '';
        V_TOTALNONFUNDBASE              Number(25,4) := '';
        V_ADVANCEASONDATE               DATE := '';
        V_CUST_CONST                    Nvarchar2(5) := '';
        V_DOCUMENT_RECEIVED_FLAG        Nvarchar2(1) := '';
        V_CRNCY_CODE_CORPORATE          Nvarchar2(5) := '';
        V_TRADE_SERVICES_AVAILED        Nvarchar2(1) := '';
        V_PRIMARYSOLID                  Nvarchar2(8) := '';
        V_CHRG_DR_FORACID               Nvarchar2(16) := '';
        V_CHRG_DR_SOL_ID                Nvarchar2(8) := '';
        V_CUST_CHRG_HISTORY_FLG         Nvarchar2(1) := '';
        V_TOT_TOD_ALWD_TIMES            NUMBER(5) := '';
        V_SMALL_STR1                    Nvarchar2(50) := '';
        V_SMALL_STR2                    Nvarchar2(50) := '';
        V_SMALL_STR3                    Nvarchar2(50) := '';
        V_SMALL_STR4                    Nvarchar2(50) := '';
        V_SMALL_STR5                    Nvarchar2(50) := '';
        V_SMALL_STR6                    Nvarchar2(50) := '';
        V_SMALL_STR7                    Nvarchar2(50) := '';
        V_SMALL_STR8                    Nvarchar2(50) := '';
        V_SMALL_STR9                    Nvarchar2(50) := '';
        V_SMALL_STR10                   Nvarchar2(50) := '';
        V_MED_STR1                      Nvarchar2(100) := '';
        V_MED_STR2                      Nvarchar2(100) := '';
        V_MED_STR3                      Nvarchar2(100) := '';
        V_MED_STR4                      Nvarchar2(100) := '';
        V_MED_STR5                      Nvarchar2(100) := '';
        V_MED_STR6                      Nvarchar2(100) := '';
        V_MED_STR7                      Nvarchar2(100) := '';
        V_MED_STR8                      Nvarchar2(100) := '';
        V_MED_STR9                      Nvarchar2(100) := '';
        V_MED_STR10                     Nvarchar2(100) := '';
        V_LARGE_STR1                    Nvarchar2(250) := '';
        V_LARGE_STR2                    Nvarchar2(250) := '';
        V_LARGE_STR3                    Nvarchar2(250) := '';
        V_LARGE_STR4                    Nvarchar2(250) := '';
        V_LARGE_STR5                    Nvarchar2(250) := '';
        V_Date1                         Date := '';
        V_Date2                         Date := '';
        V_DATE3                         DATE := '';
        V_DATE4                         DATE := '';
        V_DATE5                         DATE := '';
        V_DATE6_1                       DATE := '';
        V_DATE7                         DATE := '';
        V_DATE8                         DATE := '';
        V_DATE9                         DATE := '';
        V_DATE10                        DATE := '';
        V_NUMBER1                       NUMBER(38) := '';
        V_NUMBER2                       NUMBER(38) := '';
        V_NUMBER3                       NUMBER(38) := '';
        V_NUMBER4                       NUMBER(38) := '';
        V_NUMBER5                       NUMBER(38) := '';
        V_NUMBER6                       NUMBER(38) := '';
        V_NUMBER7                       NUMBER(38) := '';
        V_NUMBER8                       NUMBER(38) := '';
        V_NUMBER9                       NUMBER(38) := '';
        V_NUMBER10                      NUMBER(38) := '';
        V_DECIMAL1                      NUMBER(25,6) := '';
        V_DECIMAL2                      NUMBER(25,6) := '';
        V_DECIMAL3                      NUMBER(25,6) := '';
        V_DECIMAL4                      NUMBER(25,6) := '';
        V_DECIMAL5                      NUMBER(25,6) := '';
        V_DECIMAL6                      NUMBER(25,6) := '';
        V_DECIMAL7                      NUMBER(25,6) := '';
        V_DECIMAL9                      NUMBER(25,6) := '';
        V_DECIMAL10                     NUMBER(25,6) := '';
        V_DECIMAL8                      NUMBER(25,6) := '';
        V_CORE_CUST_ID                  Nvarchar2(9) := '';
        V_CIFID                         Nvarchar2(32) := '';
        V_CREATEDBYSYSTEMID             Nvarchar2(50) := '';
        V_CORPORATENAME_NATIVE1         Nvarchar2(80) := '';
        V_SHORT_NAME_NATIVE1            Nvarchar2(10) := '';
        V_OWNERAGENT                    NUMBER(38) := '';
        V_PRIMARYRMLOGIN_ID             Nvarchar2(50) := '';
        V_SecondRMLogin_ID              NVARCHAR2(50) := '';
        V_TERTIARYRMLOGIN_ID            Nvarchar2(50) := '';
        V_ACCESSOWNERGROUP              NUMBER(38) := '';
        V_ACCESSOWNERSEGMENT            Nvarchar2(50) := '';
        V_ACCESSOWNERBC                 NUMBER(38) := '';
        V_ACCESSOWNERAGENT              NUMBER(38) := '';
        V_ACCESSASSIGNEEAGENT           NUMBER(38) := '';
        V_PRIMARYPARENTCOMPANY          Nvarchar2(80) := '';
        V_COUNTRYOFPRINCIPALOPERATION   Nvarchar2(100) := '';
        V_PARENTCIF_ID                  Nvarchar2(50) := '';
        V_CHARGELEVELCODE               Nvarchar2(50) := '';
        V_COUNTRYOFORIGIN               Nvarchar2(50) := '';
        V_COUNTRYOFINCORPORATION        Nvarchar2(50) := '';
        V_IntUserField1                 NUMBER(38) := '';
        V_INTUSERFIELD2                 NUMBER(38) := '';
        V_INTUSERFIELD3                 NUMBER(38) := '';
        V_INTUSERFIELD4                 NUMBER(38) := '';
        V_INTUSERFIELD5                 NUMBER(38) := '';
        V_StrUserField1                 NVARCHAR2(100) := '';
        V_strUserField2                 NVARCHAR2(100) := '';
        V_StrUserField3                 NVARCHAR2(100) := '';
        V_STRUSERFIELD4                 Nvarchar2(100) := '';
        V_strUserField5                 NVARCHAR2(100) := '';
        V_strUserField6                 NVARCHAR2(100) := '';
        V_STRUSERFIELD7                 Nvarchar2(100) := '';
        V_strUserField8                 NVARCHAR2(100) := '';
        V_strUserField9                 NVARCHAR2(100) := '';
        V_strUserField10                NVARCHAR2(100) := '';
        V_strUserField11                NVARCHAR2(100) := '';
        V_strUserField12                NVARCHAR2(100) := '';
        V_strUserField13                NVARCHAR2(100) := '';
        V_strUserField14                NVARCHAR2(100) := '';
        V_strUserField15                NVARCHAR2(100) := '';
        V_strUserField16                NVARCHAR2(100) := '';
        V_strUserField17                NVARCHAR2(100) := '';
        V_strUserField18                NVARCHAR2(100) := '';
        V_STRUSERFIELD19                Nvarchar2(100) := '';
        V_strUserField20                NVARCHAR2(100) := '';
        V_strUserField21                NVARCHAR2(100) := '';
        V_strUserField22                NVARCHAR2(100) := '';
        V_strUserField23                NVARCHAR2(100) := '';
        V_STRUSERFIELD24                Nvarchar2(100) := '';
        V_STRUSERFIELD25                Nvarchar2(100) := '';
        V_STRUSERFIELD26                Nvarchar2(100) := '';
        V_STRUSERFIELD27                Nvarchar2(100) := '';
        V_STRUSERFIELD28                Nvarchar2(100) := '';
        V_STRUSERFIELD29                Nvarchar2(100) := '';
        V_STRUSERFIELD30                Nvarchar2(100) := '';
        V_DateUserField1                Date := '';
        V_DateUserField2                Date := '';
        V_DATEUSERFIELD3                Date := '';
        V_DateUserField4                Date := '';
        V_DATEUSERFIELD5                DATE := '';
        V_NATIVELANGCODE                Nvarchar2(10) := '';
        V_CUST_HLTH                     Nvarchar2(200) := '';
        V_LASTSUBMITTEDDATE             DATE := '';
        V_RISK_PROFILE_SCORE            NUMBER(38) := '';
        V_RISK_PROFILE_EXPIRY_DATE      DATE := '';
        V_OUTSTANDING_MORTAGE           NUMBER(20,4) := '';
        V_CORPORATE_NAME                Nvarchar2(100) := '';
        V_SHORT_NAME                    Nvarchar2(10) := '';
        V_SHORT_NAME_NATIVE             Nvarchar2(10) := '';
        --V_REGISTRATION_NUMBER           NUMBER(38) := '';
        V_REGISTRATION_NUMBER           VARCHAR2(38) := '';
        V_CHANNELSACCESSED              Nvarchar2(500) := '';
        V_ZIP                           Nvarchar2(100) := '';
        V_BACKENDID                     Nvarchar2(50) := '';
        V_DELINQUENCYFLAG               Nvarchar2(3) := '';
        V_SUSPEND_FLAG                  Nvarchar2(1) := '';
        V_SUSPEND_NOTES                 Nvarchar2(2000) := '';
        V_SUSPEND_REASON                Nvarchar2(2000) := '';
        V_BLACKLIST_FLAG                Nvarchar2(1) := '';
        V_BLACKLIST_NOTES               Nvarchar2(2000) := '';
        V_BLACKLIST_REASON              Nvarchar2(2000) := '';
        V_NEGATIVE_FLAG                 Nvarchar2(1) := '';
        V_NEGATIVE_NOTES                Nvarchar2(2000) := '';
        V_NEGATIVE_REASON               Nvarchar2(2000) := '';
        V_DSAID                         Nvarchar2(50) := '';
        V_CUSTASSET_CLASSIFICATION      Nvarchar2(5) := '';
        V_CLASSIFIED_ON                 DATE := '';
        V_CUST_CREATION_MODE            Nvarchar2(1) := '';
        V_INCREMENTALDATEUPDATE         DATE := '';
        V_LANG_CODE                     Nvarchar2(50) := '';
        V_TDS_CUST_ID                   Nvarchar2(9) := '';
        V_OTHERLIMITS                   NUMBER(20,4) := '';
        V_CORE_INTROD_CUST_ID           Nvarchar2(9) := '';
        V_INTROD_NAME                   Nvarchar2(40) := '';
        V_INTROD_STAT_CODE              Nvarchar2(5) := '';
        V_ENTITY_STAGE                  Nvarchar2(200) := '';
        V_ENTITY_STEP_STATUS            Nvarchar2(50) := '';
        V_EMAIL2                        Nvarchar2(50) := '';
        V_CUST_GRP                      Nvarchar2(50) := '';
        V_CUST_CONST_CODE               Nvarchar2(5) := '';
        V_CUSTASSET_CLSFTION_CODE       Nvarchar2(5) := '';
        V_LEGALENTITY_TYPE_CODE         Nvarchar2(5) := '';
        V_REGION_CODE                   Nvarchar2(5) := '';
        V_PRIORITY_CODE                 Nvarchar2(8) := '';
        V_BUSINESS_TYPE_CODE            Nvarchar2(5) := '';
        V_RELATIONSHIP_TYPE_CODE        Nvarchar2(5) := '';
        V_CRNCY_CODE                    Nvarchar2(5) := '';
        V_STR1                          Nvarchar2(1) := '';
        V_STR2                          Date := '';
        V_STR3                          Nvarchar2(1) := '';
        V_STR4                          Nvarchar2(1) := '';
        V_STR5                          Date := '';
        V_str6                          Nvarchar2(100) := '';
        V_str7                          NVARCHAR2(100) := '';
        V_str8                          NVARCHAR2(100) := '';
        V_str9                          NVARCHAR2(100) := '';
        V_str10                         NVARCHAR2(100) := '';
        V_STR11                         Nvarchar2(200) := '';
        V_STR12                         Nvarchar2(200) := '';
        V_STR13                         Nvarchar2(200) := '';
        V_STR14                         Nvarchar2(200) := '';
        V_STR15                         Nvarchar2(200) := '';
        V_AMOUNT1                       NUMBER(20,4) := '';
        V_AMOUNT2                       NUMBER(20,4) := '';
        V_AMOUNT3                       NUMBER(20,4) := '';
        V_AMOUNT4                       NUMBER(20,4) := '';
        V_AMOUNT5                       NUMBER(20,4) := '';
        V_INT1                          NUMBER(38) := '';
        V_INT2                          NUMBER(38) := '';
        V_INT3                          NUMBER(38) := '';
        V_INT4                          NUMBER(38) := '';
        V_INT5                          NUMBER(38) := '';
        V_Flag1                         NVARCHAR2(10) := '';
        V_Flag2                         NVARCHAR2(10) := '';
        V_FLAG3                         Nvarchar2(10) := '';
        V_FLAG4                         Nvarchar2(10) := '';
        V_FLAG5                         Nvarchar2(10) := '';
        V_MLUSERFIELD1                  Nvarchar2(80) := '';
        V_MLUSERFIELD2                  Nvarchar2(80) := '';
        V_MLUSERFIELD3                  Nvarchar2(80) := '';
        V_MLUSERFIELD4                  Nvarchar2(80) := '';
        V_MLUSERFIELD5                  Nvarchar2(80) := '';
        V_MLUSERFIELD6                  Nvarchar2(80) := '';
        V_MLUSERFIELD7                  Nvarchar2(80) := '';
        V_MLUSERFIELD8                  Nvarchar2(80) := '';
        V_MLUSERFIELD9                  Nvarchar2(80) := '';
        V_MLUSERFIELD10                 NVARCHAR2(100) := '';
        V_UNIQUEGROUPFLAG               Nvarchar2(1) := '';
        V_BANK_ID                       Nvarchar2(8) := '';
        V_ZAKAT_DEDUCTION               Nvarchar2(1) := '';
        V_ASSET_CLASSIFICATION          Nvarchar2(1) := '';
        V_CUSTOMER_LEVEL_PROVISIONING   Nvarchar2(1) := '';
        V_ISLAMIC_BANKING_CUSTOMER      Nvarchar2(1) := '';
        V_PREFERREDCALENDAR             Nvarchar2(50) := '';
        V_IDTYPEC1                      Nvarchar2(50) := '';
        V_IDTYPEC2                      Nvarchar2(50) := '';
        V_IDTYPEC3                      Nvarchar2(50) := '';
        V_IDTYPEC4                      Nvarchar2(50) := '';
        V_IDTYPEC5                      Nvarchar2(50) := '';
        V_IDTYPEC6                      Nvarchar2(50) := '';
        V_IDTYPEC7                      Nvarchar2(50) := '';
        V_IDTYPEC8                      Nvarchar2(50) := '';
        V_IDTYPEC9                      Nvarchar2(50) := '';
        V_IDTYPEC10                     Nvarchar2(50) := '';
        V_CORPORATE_NAME_ALT1           Nvarchar2(80) := '';
        V_short_Name_alt1               Nvarchar2(10) := '';
        V_KEYCONTACT_PERSONNAME_ALT1    Nvarchar2(30) := '';
        V_PARENT_CIF_ALT1               Nvarchar2(38) := '';
        V_BOCREATEDDBYLOGINID           Nvarchar2(50) := '';
        V_SUBMITFORKYC                  NVARCHAR2(1) := '';
        V_KYC_REVIEWDATE                DATE := '';
        V_KYC_DATE                      DATE := '';
        V_RISKRATING                    NVARCHAR2(30) := '';
        V_ForeignAccTaxReportingReq     NVARCHAR2(1) := '';
        V_ForeignTaxReportingCountry    NVARCHAR2(50) := '';
        V_ForeignTaxReportingStatus     NVARCHAR2 (50) := '';
        V_LastForeignTaxReviewDate      DATE := '';
        V_NextForeignTaxReviewDate      DATE := '';
        V_FatcaRemarks                  NVARCHAR2 (100) := '';
        V_mlUserField11                 NVARCHAR2(80) := '';
        V_mlUserField12                 NVARCHAR2(80) := '';
        V_mlUserField13                 NVARCHAR2(80) := '';
        V_mlUserField14                 NVARCHAR2(80) := '';
        V_mlUserField15                 NVARCHAR2(80) := '';
        V_mlUserField16                 NVARCHAR2(80) := '';
        V_mlUserField17                 NVARCHAR2(80) := '';
        V_mlUserField18                 NVARCHAR2(80) := '';
        V_mlUserField19                 NVARCHAR2(80) := '';
        V_int6                          Number(38) := '';
        V_int7                          Number(38) := '';
        V_DATE6                         Date := '';
        V_DATE7_1                       Date := '';
        V_DATE8_1                       Date := '';
        V_DATE9_1                       Date := '';
        V_DATE10_1                      Date := '';

        CURSOR C1(CurInpSol VARCHAR2) IS
        SELECT CIF_ID FROM VALID_CIF WHERE SOL_ID = CurInpSol AND CIF_TYPE = 'C';

        BEGIN
        --{
            V_BANK_ID := '01';
            V_ENTITY_TYPE := 'CUSTOMER';
            V_STATUS := 'ACTVE';
            V_CRNCY_CODE := 'INR';
            V_SEGMENT := 'Corporate';
            V_SUBSEGMENT := 'MIG';
            V_ENTITYCLASS := 'MIG';
            V_SOURCE_OF_FUNDS := 'MIG';
            V_IS_SWIFT_CODE_OF_BANK := 'N';
            V_DOCUMENT_RECEIVED_FLAG := 'Y';
            V_CRNCY_CODE_CORPORATE := 'INR';
            V_CUST_HLTH := 'MIG';
            V_CUSTASSET_CLASSIFICATION := 'U';
            V_REGION_CODE := 'MIG';
            V_RELATIONSHIP_TYPE_CODE := 'MIG';
            V_LANG_CODE := 'INFENG';
            V_PRIORITY_CODE := 'MIG';
            V_NOTES := 'MIG';
            V_ZAKAT_DEDUCTION := 'N';
            V_ForeignAccTaxReportingReq := 'N';
            V_PHONECITYCODE := '.';
            V_SUBSECTOR := 'MIG';

            FOR I IN C1(InpSolId)
            LOOP
            --{
                V_CORP_KEY := I.CIF_ID;
                V_CORE_CUST_ID := V_CORP_KEY;
                V_CIFID := V_CORP_KEY;
                V_IDTYPEC1 := V_CORP_KEY;

                BEGIN
                    SELECT
                        CORPCL_CLIENT_CODE
                        ,SUBSTR(CORPCL_CLIENT_NAME,0,80)
                        ,SUBSTR(CORPCL_CLIENT_NAME,0,30) AS CORPCL_CLIENT_NAME
                        ,CORPCL_INCORP_CNTRY
                        ,CORPCL_INCORP_DATE
                        ,CORPCL_BC_GROSS_TURNOVER
                        ,CORPCL_INCORP_CNTRY
                        ,CORPCL_INCORP_CNTRY
                        ,SUBSTR(CORPCL_CLIENT_NAME,0,80)
                        ,CORPCL_REG_NUM
                        ,DECODE(CORPCL_TF_CLIENT,0,'N','Y')
                        ,CORPCL_COM_BUS_IDENTIFIER
                        ,CORPCL_BUS_ENTITY_IDENTIFIER
                        ,DECODE(CORPCL_SCHEDULED_BANK,0,'N','Y')
                        ,CORPCL_TYPE_OF_BANK
                        ,DECODE(CORPCL_SOVEREIGN_FLG,0,'N','Y')
                        ,CORPCL_TYPE_OF_SOVEREIGN
                        ,CORPCL_CNTRY_CODE
                        ,CORPCL_CENTRAL_STATE_FLG
                        ,DECODE(CORPCL_PUBLIC_SECTOR_FLG,0,'N','Y')
                        ,DECODE(CORPCL_PRIMARY_DLR_FLG,0,'N','Y')
                        ,DECODE(CORPCL_MULTILATERAL_BANK,0,'N','Y')
                    INTO
                        V_CORP_KEY
                        ,V_CORPORATENAME_NATIVE
                        ,V_KEYCONTACT_PERSONNAME
                        ,V_PRINCIPLE_PLACEOPERATION
                        ,V_DATE_OF_INCORPORATION
                        ,V_AVERAGE_ANNUALINCOME
                        ,V_COUNTRYOFORIGIN
                        ,V_COUNTRYOFINCORPORATION
                        ,V_CORPORATE_NAME
                        ,V_REGISTRATION_NUMBER
                        ,V_TRADE_SERVICES_AVAILED
                        ,V_strUserField2
                        ,V_StrUserField3
                        ,V_strUserField14
                        ,V_strUserField15
                        ,V_strUserField16
                        ,V_strUserField17
                        ,V_strUserField18
                        ,V_STRUSERFIELD19
                        ,V_strUserField20
                        ,V_strUserField21
                        ,V_strUserField22
                    FROM
                        CBS.CORPCLIENTS
                    WHERE
                        CORPCL_CLIENT_CODE = V_CORP_KEY;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        V_CORP_KEY := null;
                        V_CORPORATENAME_NATIVE := null;
                        V_KEYCONTACT_PERSONNAME := null;
                        V_PRINCIPLE_PLACEOPERATION := null;
                        V_DATE_OF_INCORPORATION := null;
                        V_AVERAGE_ANNUALINCOME := null;
                        V_COUNTRYOFORIGIN := null;
                        V_COUNTRYOFINCORPORATION := null;
                        V_CORPORATE_NAME := null;
                        V_TRADE_SERVICES_AVAILED := 'N';
                        V_strUserField2 := null;
                        V_StrUserField3 := null;
                        V_strUserField14 := null;
                        V_strUserField15 := null;
                        V_strUserField16 := null;
                        V_strUserField17 := null;
                        V_strUserField18 := null;
                        V_STRUSERFIELD19 := null;
                        V_strUserField20 := null;
                        V_strUserField21 := null;
                        V_strUserField22 := null;
                END;

                V_CORPORATE_NAME := CommonExtractionPack.RemoveSpecialChars(V_CORPORATE_NAME);
                V_CORPORATENAME_NATIVE := CommonExtractionPack.RemoveSpecialChars(V_CORPORATENAME_NATIVE);
                V_KEYCONTACT_PERSONNAME := CommonExtractionPack.RemoveSpecialChars(V_KEYCONTACT_PERSONNAME);

                V_SHORT_NAME := SUBSTR(V_CORPORATE_NAME,0,10);

                V_REGISTRATION_NUMBER := NVL(TRIM(V_REGISTRATION_NUMBER),'MIG');

                BEGIN
                    SELECT
                        CLIENTS_OPENING_DATE
                        ,CLIENTS_CUST_CATG
                        ,SUBSTR(CLIENTS_SEGMENT_CODE,0,5)
                        ,CLIENTS_GROUP_CODE
                        ,CLIENTS_ARM_CODE
                        ,CLIENTS_ENTD_BY
                        ,CLIENTS_HOME_BRN_CODE
                        ,CLIENTS_ARM_CODE
                        ,CLIENTS_CONST_CODE
                        ,CLIENTS_RISK_CATEGORIZATION
                        ,CLIENTS_PAN_GIR_NUM
                    INTO
                        V_RELATIONSHIP_STARTDATE
                        ,V_LEGALENTITY_TYPE
                        ,V_SECTOR
                        ,V_BUSINESS_GROUP
                        ,V_PRIMARYRM_ID
                        ,V_RELATIONSHIP_CREATEDBY
                        ,V_PRIMARYSOLID
                        ,V_PRIMARYRMLOGIN_ID
                        ,V_CUST_CONST_CODE
                        ,V_RISKRATING
                        ,V_TAXID
                    FROM
                        CBS.CLIENTS
                    WHERE
                        CLIENTS_CODE = V_CORP_KEY;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        V_RELATIONSHIP_STARTDATE := null;
                        V_LEGALENTITY_TYPE := null;
                        --V_SEGMENT := null;
                        V_BUSINESS_GROUP := null;
                        V_PRIMARYRM_ID := null;
                        V_RELATIONSHIP_CREATEDBY := null;
                        V_SECTOR := null;
                        V_PRIMARYSOLID := null;
                        V_PRIMARYRMLOGIN_ID := null;
                        V_CUST_CONST_CODE := null;
                        V_RISKRATING := null;
                        V_TAXID := null;
                END;

                V_PRIMARY_SERVICE_CENTER := V_PRIMARYSOLID;

                IF(TRIM(V_PRIMARYRMLOGIN_ID) is null) THEN
                --{
                    V_PRIMARYRMLOGIN_ID := 'UBSADMIN';
                --}
                END IF;

                V_BUSINESS_GROUP := 'BG1';

                --V_DSAID := V_PRIMARYRMLOGIN_ID;

                --- CKYC NUMBER ---
                BEGIN
                    SELECT 	TSSCR_CKYC_NUMBER
                    INTO 	v_StrUserField1
                    FROM	CBS.TSSCKCYCBSRESPONSE A
                    WHERE 	TSSCR_CLIENT_ID = V_CORP_KEY
                    --AND TSSCR_PROCESSED_ON = (SELECT MAX(TSSCR_PROCESSED_ON) FROM CBS.tssckcycbsresponse B WHERE A.TSSCR_CLIENT_ID = B.TSSCR_CLIENT_ID);
                    AND (TSSCR_PROCESSED_ON,TSSCR_REC_SL) = (SELECT MAX(TSSCR_PROCESSED_ON),MAX(TSSCR_REC_SL) FROM CBS.tssckcycbsresponse B WHERE A.TSSCR_CLIENT_ID = B.TSSCR_CLIENT_ID);
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        BEGIN
                            SELECT 	CKYCHDTL_CKYC_NUM
                            INTO	v_StrUserField1
                            FROM	CBS.CKYCHEADERDTL A
                            WHERE	CKYCHDTL_CLIENT_CD = V_CORP_KEY
                            AND     CKYCHDTL_ENTITY = '1'
                            AND     CKYCHDTL_BRAN_CODE = InpSolId
                            AND CKYCHDTL_PROC_DATE = (SELECT MAX(CKYCHDTL_PROC_DATE) FROM CBS.CKYCHEADERDTL B
                                                    WHERE A.CKYCHDTL_CLIENT_CD = B.CKYCHDTL_CLIENT_CD
                                                    AND A.CKYCHDTL_BRAN_CODE = B.CKYCHDTL_BRAN_CODE
                                                    AND A.CKYCHDTL_ENTITY = B.CKYCHDTL_ENTITY);
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                            v_struserfield1 := '';
                        END;
                END;

                BEGIN
                    SELECT
                        CORPCLACT_ACTIVITY_CODE
                    INTO
                        V_BUSINESS_TYPE_CODE
                    FROM
                        cbs.corpclineact a
                    WHERE
                        a.CORPCLACT_CLIENT_CODE = V_CORP_KEY
                    AND CORPCLACT_ACTIVITY_SL = (select max(CORPCLACT_ACTIVITY_SL) FROM cbs.corpclineact b
                                                WHERE a.CORPCLACT_CLIENT_CODE = b.CORPCLACT_CLIENT_CODE);
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_BUSINESS_TYPE_CODE := 'MIG';
                END;

                BEGIN
                    SELECT SMSBREG_CALL_CODE, SMSBREG_MOBILE_NUMBER
                    INTO V_PHONECOUNTRYCODE,V_PHONELOCALCODE
                    FROM CBS.SMSBREG A
                    WHERE SMSBREG_ACTIVE = 1
                    AND SMSBREG_REG_SL = (SELECT MAX(SMSBREG_REG_SL) FROM CBS.SMSBREG B WHERE A.SMSBREG_MOBILE_OWNER = B.SMSBREG_MOBILE_OWNER AND B.SMSBREG_ACTIVE = 1)
                    AND SMSBREG_REG_DATE = (SELECT MAX(SMSBREG_REG_DATE) FROM CBS.SMSBREG B WHERE A.SMSBREG_MOBILE_OWNER = B.SMSBREG_MOBILE_OWNER and B.SMSBREG_ACTIVE = 1)
                    AND SMSBREG_MOBILE_OWNER = I.CIF_ID;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_PHONECOUNTRYCODE := '.';
                    V_PHONELOCALCODE := '.';
                END;

                --V_SEGMENT := COMMONEXTRACTIONPACK.MAPPER_FUNC('MASTERCODE','SEGMENTATION_CLASS',V_SEGMENT,'CBS');
                V_LEGALENTITY_TYPE := NVL(COMMONEXTRACTIONPACK.MAPPER_FUNC('MASTERCODE','ACCOUNT_TYPE',V_LEGALENTITY_TYPE,'CBS'),'MIG');
                V_SECTOR := NVL(TRIM(V_SECTOR),'MIG');

                INSERT INTO CC001 VALUES
                (
                    V_CORP_KEY,
                    V_ENTITY_TYPE,
                    V_CORPORATENAME_NATIVE,
                    V_RELATIONSHIP_STARTDATE,
                    V_STATUS,
                    V_LEGALENTITY_TYPE,
                    V_SEGMENT,
                    V_SUBSEGMENT,
                    V_WEBSITE_ADDRESS,
                    V_KEYCONTACT_PERSONNAME,
                    V_PHONECITYCODE,
                    V_PHONELOCALCODE,
                    V_PHONECOUNTRYCODE,
                    V_NOTES,
                    V_PRINCIPLE_PLACEOPERATION,
                    V_BUSINESS_GROUP,
                    V_PRIMARYRM_ID,
                    V_DATE_OF_INCORPORATION,
                    V_DATE_OF_COMMENCEMENT,
                    V_PRIMARY_SERVICE_CENTER,
                    V_RELATIONSHIP_CREATEDBY,
                    V_SECTOR,
                    V_SUBSECTOR,
                    V_TAXID,
                    V_ENTITYCLASS,
                    V_AVERAGE_ANNUALINCOME,
                    V_SOURCE_OF_FUNDS,
                    V_GROUP_ID,
                    V_GROUP_ID_CODE,
                    V_PARENT_CIF,
                    V_CUSTOMER_RATING,
                    V_HEALTH_CODE,
                    V_RECORD_STATUS,
                    V_EFFECTIVE_DATE,
                    V_LINE_OF_ACTIVITY_DESC,
                    V_CUST_MGR_OPIN,
                    V_CUST_TYPE_DESC,
                    V_CUST_STAT_CHG_DATE,
                    V_TDS_TBL_DESC,
                    V_CUST_SWIFT_CODE,
                    V_IS_SWIFT_CODE_OF_BANK,
                    V_CUSTDEPOSITSINOTHERBANKS,
                    V_TOTALFUNDBASE,
                    V_TOTALNONFUNDBASE,
                    V_ADVANCEASONDATE,
                    V_CUST_CONST,
                    V_DOCUMENT_RECEIVED_FLAG,
                    V_CRNCY_CODE_CORPORATE,
                    V_TRADE_SERVICES_AVAILED,
                    V_PRIMARYSOLID,
                    V_CHRG_DR_FORACID,
                    V_CHRG_DR_SOL_ID,
                    V_CUST_CHRG_HISTORY_FLG,
                    V_TOT_TOD_ALWD_TIMES,
                    V_SMALL_STR1,
                    V_SMALL_STR2,
                    V_SMALL_STR3,
                    V_SMALL_STR4,
                    V_SMALL_STR5,
                    V_SMALL_STR6,
                    V_SMALL_STR7,
                    V_SMALL_STR8,
                    V_SMALL_STR9,
                    V_SMALL_STR10,
                    V_MED_STR1,
                    V_MED_STR2,
                    V_MED_STR3,
                    V_MED_STR4,
                    V_MED_STR5,
                    V_MED_STR6,
                    V_MED_STR7,
                    V_MED_STR8,
                    V_MED_STR9,
                    V_MED_STR10,
                    V_LARGE_STR1,
                    V_LARGE_STR2,
                    V_LARGE_STR3,
                    V_LARGE_STR4,
                    V_LARGE_STR5,
                    V_Date1,
                    V_Date2,
                    V_DATE3,
                    V_DATE4,
                    V_DATE5,
                    V_DATE6_1,
                    V_DATE7,
                    V_DATE8,
                    V_DATE9,
                    V_DATE10,
                    V_NUMBER1,
                    V_NUMBER2,
                    V_NUMBER3,
                    V_NUMBER4,
                    V_NUMBER5,
                    V_NUMBER6,
                    V_NUMBER7,
                    V_NUMBER8,
                    V_NUMBER9,
                    V_NUMBER10,
                    V_DECIMAL1,
                    V_DECIMAL2,
                    V_DECIMAL3,
                    V_DECIMAL4,
                    V_DECIMAL5,
                    V_DECIMAL6,
                    V_DECIMAL7,
                    V_DECIMAL9,
                    V_DECIMAL10,
                    V_DECIMAL8,
                    V_CORE_CUST_ID,
                    V_CIFID,
                    V_CREATEDBYSYSTEMID,
                    V_CORPORATENAME_NATIVE1,
                    V_SHORT_NAME_NATIVE1,
                    V_OWNERAGENT,
                    V_PRIMARYRMLOGIN_ID,
                    V_SecondRMLogin_ID,
                    V_TERTIARYRMLOGIN_ID,
                    V_ACCESSOWNERGROUP,
                    V_ACCESSOWNERSEGMENT,
                    V_ACCESSOWNERBC,
                    V_ACCESSOWNERAGENT,
                    V_ACCESSASSIGNEEAGENT,
                    V_PRIMARYPARENTCOMPANY,
                    V_COUNTRYOFPRINCIPALOPERATION,
                    V_PARENTCIF_ID,
                    V_CHARGELEVELCODE,
                    V_COUNTRYOFORIGIN,
                    V_COUNTRYOFINCORPORATION,
                    V_IntUserField1,
                    V_INTUSERFIELD2,
                    V_INTUSERFIELD3,
                    V_INTUSERFIELD4,
                    V_INTUSERFIELD5,
                    V_StrUserField1,
                    V_strUserField2,
                    V_StrUserField3,
                    V_STRUSERFIELD4,
                    V_strUserField5,
                    V_strUserField6,
                    V_STRUSERFIELD7,
                    V_strUserField8,
                    V_strUserField9,
                    V_strUserField10,
                    V_strUserField11,
                    V_strUserField12,
                    V_strUserField13,
                    V_strUserField14,
                    V_strUserField15,
                    V_strUserField16,
                    V_strUserField17,
                    V_strUserField18,
                    V_STRUSERFIELD19,
                    V_strUserField20,
                    V_strUserField21,
                    V_strUserField22,
                    V_strUserField23,
                    V_STRUSERFIELD24,
                    V_STRUSERFIELD25,
                    V_STRUSERFIELD26,
                    V_STRUSERFIELD27,
                    V_STRUSERFIELD28,
                    V_STRUSERFIELD29,
                    V_STRUSERFIELD30,
                    V_DateUserField1,
                    V_DateUserField2,
                    V_DATEUSERFIELD3,
                    V_DateUserField4,
                    V_DATEUSERFIELD5,
                    V_NATIVELANGCODE,
                    V_CUST_HLTH,
                    V_LASTSUBMITTEDDATE,
                    V_RISK_PROFILE_SCORE,
                    V_RISK_PROFILE_EXPIRY_DATE,
                    V_OUTSTANDING_MORTAGE,
                    V_CORPORATE_NAME,
                    V_SHORT_NAME,
                    V_SHORT_NAME_NATIVE,
                    V_REGISTRATION_NUMBER,
                    V_CHANNELSACCESSED,
                    V_ZIP,
                    V_BACKENDID,
                    V_DELINQUENCYFLAG,
                    V_SUSPEND_FLAG,
                    V_SUSPEND_NOTES,
                    V_SUSPEND_REASON,
                    V_BLACKLIST_FLAG,
                    V_BLACKLIST_NOTES,
                    V_BLACKLIST_REASON,
                    V_NEGATIVE_FLAG,
                    V_NEGATIVE_NOTES,
                    V_NEGATIVE_REASON,
                    V_DSAID,
                    V_CUSTASSET_CLASSIFICATION,
                    V_CLASSIFIED_ON,
                    V_CUST_CREATION_MODE,
                    V_INCREMENTALDATEUPDATE,
                    V_LANG_CODE,
                    V_TDS_CUST_ID,
                    V_OTHERLIMITS,
                    V_CORE_INTROD_CUST_ID,
                    V_INTROD_NAME,
                    V_INTROD_STAT_CODE,
                    V_ENTITY_STAGE,
                    V_ENTITY_STEP_STATUS,
                    V_EMAIL2,
                    V_CUST_GRP,
                    V_CUST_CONST_CODE,
                    V_CUSTASSET_CLSFTION_CODE,
                    V_LEGALENTITY_TYPE_CODE,
                    V_REGION_CODE,
                    V_PRIORITY_CODE,
                    V_BUSINESS_TYPE_CODE,
                    V_RELATIONSHIP_TYPE_CODE,
                    V_CRNCY_CODE,
                    V_STR1,
                    V_STR2,
                    V_STR3,
                    V_STR4,
                    V_STR5,
                    V_str6,
                    V_str7,
                    V_str8,
                    V_str9,
                    V_str10,
                    V_STR11,
                    V_STR12,
                    V_STR13,
                    V_STR14,
                    V_STR15,
                    V_AMOUNT1,
                    V_AMOUNT2,
                    V_AMOUNT3,
                    V_AMOUNT4,
                    V_AMOUNT5,
                    V_INT1,
                    V_INT2,
                    V_INT3,
                    V_INT4,
                    V_INT5,
                    V_Flag1,
                    V_Flag2,
                    V_FLAG3,
                    V_FLAG4,
                    V_FLAG5,
                    V_MLUSERFIELD1,
                    V_MLUSERFIELD2,
                    V_MLUSERFIELD3,
                    V_MLUSERFIELD4,
                    V_MLUSERFIELD5,
                    V_MLUSERFIELD6,
                    V_MLUSERFIELD7,
                    V_MLUSERFIELD8,
                    V_MLUSERFIELD9,
                    V_MLUSERFIELD10,
                    V_UNIQUEGROUPFLAG,
                    V_BANK_ID,
                    V_ZAKAT_DEDUCTION,
                    V_ASSET_CLASSIFICATION,
                    V_CUSTOMER_LEVEL_PROVISIONING,
                    V_ISLAMIC_BANKING_CUSTOMER,
                    V_PREFERREDCALENDAR,
                    V_IDTYPEC1,
                    V_IDTYPEC2,
                    V_IDTYPEC3,
                    V_IDTYPEC4,
                    V_IDTYPEC5,
                    V_IDTYPEC6,
                    V_IDTYPEC7,
                    V_IDTYPEC8,
                    V_IDTYPEC9,
                    V_IDTYPEC10,
                    V_CORPORATE_NAME_ALT1,
                    V_short_Name_alt1,
                    V_KEYCONTACT_PERSONNAME_ALT1,
                    V_PARENT_CIF_ALT1,
                    V_BOCREATEDDBYLOGINID,
                    V_SUBMITFORKYC,
                    V_KYC_REVIEWDATE,
                    V_KYC_DATE,
                    V_RISKRATING,
                    V_ForeignAccTaxReportingReq,
                    V_ForeignTaxReportingCountry,
                    V_ForeignTaxReportingStatus,
                    V_LastForeignTaxReviewDate,
                    V_NextForeignTaxReviewDate,
                    V_FatcaRemarks,
                    V_mlUserField11,
                    V_mlUserField12,
                    V_mlUserField13,
                    V_mlUserField14,
                    V_mlUserField15,
                    V_mlUserField16,
                    V_mlUserField17,
                    V_mlUserField18,
                    V_mlUserField19,
                    V_int6,
                    V_int7,
                    V_DATE6,
                    V_DATE7_1,
                    V_DATE8_1,
                    V_DATE9_1,
                    V_DATE10_1,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END CC001;
    --} Procudre CC001 End

    PROCEDURE CC002 (InpSolId IN VARCHAR2) IS
    --{
        V_CORP_KEY				NVARCHAR2(32) := '';
        V_CIF_ID                NVARCHAR2(32) := '';
        V_CORP_REP_KEY          NVARCHAR2(38) := '';
        V_ADDRESSCATEGORY       NVARCHAR2(100) := '';
        V_START_DATE            DATE := '';
        V_PhoneNo1LocalCode     NVARCHAR2(20) := '';
        V_PhoneNo1CityCode      NVARCHAR2(20) := '';
        V_PhoneNo1CountryCode	NVARCHAR2(20) := '';
        V_PhoneNo2LocalCode     NVARCHAR2(20) := '';
        V_PhoneNo2CityCode      NVARCHAR2(20) := '';
        V_PhoneNo2CountryCode   NVARCHAR2(20) := '';
        V_FaxNoLocalCode        NVARCHAR2(20) := '';
        V_FaxNoCityCode         NVARCHAR2(20) := '';
        V_FaxNoCountryCode      NVARCHAR2(20) := '';
        V_Email                 NVARCHAR2(50) := '';
        V_PagerNoLocalCode      NVARCHAR2(20) := '';
        V_PagerNoCityCode       NVARCHAR2(20) := '';
        V_PagerNoCountryCode    NVARCHAR2(20) := '';
        V_TelexLocalCode        NVARCHAR2(20) := '';
        V_TelexCityCode         NVARCHAR2(20) := '';
        V_TelexCountryCode      NVARCHAR2(20) := '';
        V_HOUSE_NO              NVARCHAR2(10) := '';
        V_PREMISE_NAME          NVARCHAR2(50) := '';
        V_BUILDING_LEVEL        NVARCHAR2(10) := '';
        V_STREET_NO             NVARCHAR2(50) := '';
        V_STREET_NAME           NVARCHAR2(50) := '';
        V_SUBURB                NVARCHAR2(50) := '';
        V_LOCALITY_NAME         NVARCHAR2(50) := '';
        V_TOWN                  NVARCHAR2(50) := '';
        V_DOMICILE              NVARCHAR2(50) := '';
        V_CITY_CODE             NVARCHAR2(100) := '';
        V_STATE_CODE            NVARCHAR2(100) := '';
        V_ZIP                   NVARCHAR2(100) := '';
        V_COUNTRY_CODE          NVARCHAR2(100) := '';
        V_SMALL_STR1            NVARCHAR2(50) := '';
        V_SMALL_STR2            NVARCHAR2(50) := '';
        V_SMALL_STR3            NVARCHAR2(50) := '';
        V_SMALL_STR4            NVARCHAR2(50) := '';
        V_SMALL_STR5            NVARCHAR2(50) := '';
        V_SMALL_STR6            NVARCHAR2(50) := '';
        V_SMALL_STR7            NVARCHAR2(50) := '';
        V_SMALL_STR8            NVARCHAR2(50) := '';
        V_SMALL_STR9            NVARCHAR2(50) := '';
        V_SMALL_STR10           NVARCHAR2(50) := '';
        V_MED_STR1              NVARCHAR2(100) := '';
        V_MED_STR2              NVARCHAR2(100) := '';
        V_MED_STR3              NVARCHAR2(100) := '';
        V_MED_STR4              NVARCHAR2(100) := '';
        V_MED_STR5              NVARCHAR2(100) := '';
        V_MED_STR6              NVARCHAR2(100) := '';
        V_MED_STR7              NVARCHAR2(100) := '';
        V_MED_STR8              NVARCHAR2(100) := '';
        V_MED_STR9              NVARCHAR2(100) := '';
        V_MED_STR10             NVARCHAR2(100) := '';
        V_LARGE_STR1            NVARCHAR2(250) := '';
        V_LARGE_STR2            NVARCHAR2(250) := '';
        V_LARGE_STR3            NVARCHAR2(250) := '';
        V_LARGE_STR4            NVARCHAR2(250) := '';
        V_LARGE_STR5            NVARCHAR2(250) := '';
        V_DATE1                 DATE := '';
        V_DATE2                 DATE := '';
        V_DATE3                 DATE := '';
        V_DATE4                 DATE := '';
        V_DATE5                 DATE := '';
        V_DATE6                 DATE := '';
        V_DATE7                 DATE := '';
        V_DATE8                 DATE := '';
        V_DATE9                 DATE := '';
        V_DATE10                DATE := '';
        V_NUMBER1               NUMBER(38) := '';
        V_NUMBER2               NUMBER(38) := '';
        V_NUMBER3               NUMBER(38) := '';
        V_NUMBER4               NUMBER(38) := '';
        V_NUMBER5               NUMBER(38) := '';
        V_NUMBER6               NUMBER(38) := '';
        V_NUMBER7               NUMBER(38) := '';
        V_NUMBER8               NUMBER(38) := '';
        V_NUMBER9               NUMBER(38) := '';
        V_NUMBER10              NUMBER(38) := '';
        V_DECIMAL1              NUMBER := '';
        V_DECIMAL2              NUMBER := '';
        V_DECIMAL3              NUMBER := '';
        V_DECIMAL4              NUMBER := '';
        V_DECIMAL5              NUMBER := '';
        V_DECIMAL6              NUMBER := '';
        V_DECIMAL7              NUMBER := '';
        V_DECIMAL8              NUMBER := '';
        V_DECIMAL9              NUMBER := '';
        V_DECIMAL10             NUMBER := '';
        V_PREFERREDADDRESS      NVARCHAR2(50) := '';
        V_HOLDMAILINITIATEDBY   NVARCHAR2(20) := '';
        V_HOLDMAILFLAG          NVARCHAR2(50) := '';
        V_BUSINESSCENTER        NVARCHAR2(50) := '';
        V_HOLDMAILREASON        NVARCHAR2(200) := '';
        V_PREFERREDFORMAT       NVARCHAR2(50) := '';
        V_FREETEXTADDRESS       NVARCHAR2(2000) := '';
        V_FREETEXTLABEL         NVARCHAR2(200) := '';
        V_IS_ADDRESS_PROOF_RCVD	NVARCHAR2(1) := '';
        V_LAST_UPDATE_DATE      Date := '';
        V_ADDRESS_LINE1         NVARCHAR2(100) := '';
        V_ADDRESS_LINE2         NVARCHAR2(100) := '';
        V_ADDRESS_LINE3         NVARCHAR2(100) := '';
        V_BANK_ID               NVARCHAR2(8) := '';
        V_IsAddressVerified     NVARCHAR2(1) := '';
        V_ADDRESS				NVARCHAR2(350) := '';

        CURSOR C2(CurSolId varchar2) IS
        SELECT CIF_ID FROM VALID_CIF WHERE SOL_ID = CurSolId AND CIF_TYPE = 'C';

        CURSOR C1 (InpCif number) is
        select CLIENTS_CODE
        ,NVL(ADDRDTLS_PIN_ZIP_CODE,'MIG') ZIP_CODE
        ,NVL(NVL(ADDRDTLS_EFF_FROM_DATE,CORPCL_INCORP_DATE),CLIENTS_ENTD_ON) ADDRDTLS_EFF_FROM_DATE
        ,ADDRDTLS_ADDR1
        ,ADDRDTLS_ADDR2
        ,ADDRDTLS_ADDR3
        ,ADDRDTLS_ADDR4
        ,ADDRDTLS_ADDR5
        ,ADDRDTLS_LOCN_CODE
        ,ADDRDTLS_ADDR_TYPE
        ,CASE WHEN ROW_NUMBER()
        OVER (PARTITION BY ADDRDTLS_INV_NUM ORDER BY CASE ADDRDTLS_ADDR_TYPE WHEN '03' THEN 1 WHEN '02' THEN 2 WHEN '01' THEN 3 WHEN '04' THEN 4 END) = 1
        THEN 'Y' ELSE 'N' END AS preferredaddrflag
        from cbs.addrdtls,cbs.clients,cbs.corpclients
        where clients.CLIENTS_ADDR_INV_NUM = addrdtls.addrdtls_inv_num
        AND CORPCLIENTS.CORPCL_CLIENT_CODE = CLIENTS.CLIENTS_CODE
        AND CLIENTS_CODE = InpCif
        AND (TRIM(ADDRDTLS_ADDR1) IS NOT NULL
            OR TRIM(ADDRDTLS_ADDR2) IS NOT NULL
            OR TRIM(ADDRDTLS_ADDR3) IS NOT NULL
            OR TRIM(ADDRDTLS_ADDR4) IS NOT NULL
            OR TRIM(ADDRDTLS_ADDR5) IS NOT NULL);

        BEGIN
        --{
            V_BANK_ID := '01';

            FOR J IN C2(InpSolId)
            LOOP
            --{
                FOR I IN C1(J.CIF_ID)
                LOOP
                --{
                    V_ADDRESS :=  '';

                    V_ZIP := NVL(REPLACE(TRIM(I.ZIP_CODE),'.',''),'MIG');

                    V_CORP_KEY := I.CLIENTS_CODE;
                    V_CIF_ID := V_CORP_KEY;

                    V_START_DATE := I.ADDRDTLS_EFF_FROM_DATE;

                    V_preferredAddress := i.preferredaddrflag;

                    IF(TRIM(I.ADDRDTLS_ADDR1) IS NOT NULL) THEN
                    --{
                        V_ADDRESS :=  I.ADDRDTLS_ADDR1;
                    --}
                    END IF;

                    IF(TRIM(I.ADDRDTLS_ADDR2) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| I.ADDRDTLS_ADDR2;
                    --}
                    END IF;

                    IF(TRIM(I.ADDRDTLS_ADDR3) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| I.ADDRDTLS_ADDR3;
                    --}
                    END IF;

                    IF(TRIM(I.ADDRDTLS_ADDR4) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| I.ADDRDTLS_ADDR4;
                    --}
                    END IF;

                    IF(TRIM(I.ADDRDTLS_ADDR5) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| I.ADDRDTLS_ADDR5;
                    --}
                    END IF;

                    V_ADDRESS := CommonExtractionPack.RemoveSpecialChars(V_ADDRESS);

                    V_ADDRESS_LINE1 := NULL;
                    V_ADDRESS_LINE2 := NULL;
                    V_ADDRESS_LINE3 := NULL;

                    V_HOUSE_NO			:= NULL;
                    V_PREMISE_NAME		:= NULL;
                    V_BUILDING_LEVEL	:= NULL;
                    V_STREET_NO			:= NULL;
                    V_STREET_NAME		:= NULL;
                    V_SUBURB			:= NULL;
                    V_LOCALITY_NAME		:= NULL;
                    V_TOWN				:= NULL;
                    V_DOMICILE			:= NULL;

                    IF(length(V_ADDRESS) > 135) THEN
                    --{
                        V_PreferredFormat := 'STRUCTURED_FORMAT';

                        V_HOUSE_NO			:= SUBSTR(V_ADDRESS,0,10);
                        V_PREMISE_NAME		:= SUBSTR(V_ADDRESS,11,50);
                        V_BUILDING_LEVEL	:= SUBSTR(V_ADDRESS,61,10);
                        V_STREET_NO			:= SUBSTR(V_ADDRESS,71,50);
                        V_STREET_NAME		:= SUBSTR(V_ADDRESS,121,50);
                        V_SUBURB			:= SUBSTR(V_ADDRESS,171,50);
                        V_LOCALITY_NAME		:= SUBSTR(V_ADDRESS,221,50);
                        V_TOWN				:= SUBSTR(V_ADDRESS,271,50);
                        V_DOMICILE			:= SUBSTR(V_ADDRESS,321,50);
                    --}
                    ELSE
                    --{
                        V_PreferredFormat := 'FREE_TEXT_FORMAT';
                        V_FreeTextAddress := V_ADDRESS;
                        V_FreeTextLabel	:= V_ADDRESS;

                        V_ADDRESS_LINE1 := SUBSTR(V_ADDRESS,0,45);
                        V_ADDRESS_LINE2 := SUBSTR(V_ADDRESS,46,45);
                        V_ADDRESS_LINE3 := SUBSTR(V_ADDRESS,91,45);
                    --}
                    END IF;

                    V_CITY_CODE := I.ADDRDTLS_LOCN_CODE;

                    BEGIN
                        SELECT LOCN_STATE_CODE,LOCN_CNTRY_CODE
                        INTO V_STATE_CODE,V_COUNTRY_CODE
                        FROM CBS.LOCATION
                        WHERE LOCN_CODE = V_CITY_CODE;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                        V_STATE_CODE	:= NULL;
                        V_COUNTRY_CODE	:= NULL;
                    END;

                    V_COUNTRY_CODE := NVL(V_COUNTRY_CODE,'MIG');
                    V_ADDRESSCATEGORY := CommonExtractionPack.MAPPER_FUNC('MASTERCODE','CORPADDRTYPE',I.ADDRDTLS_ADDR_TYPE,'CBS');

                    V_CITY_CODE := NVL(CommonExtractionPack.location('CITY',V_CITY_CODE),'MIG');
                    V_STATE_CODE := NVL(CommonExtractionPack.location('STATE',V_STATE_CODE),'MIG');

                    IF(V_preferredAddress = 'Y') THEN
                    --{
                        V_ADDRESSCATEGORY := 'Registered';
                    --}
                    END IF;

                    INSERT INTO CC002 VALUES
                    (
                        V_CORP_KEY
                        ,V_CIF_ID
                        ,V_CORP_REP_KEY
                        ,V_ADDRESSCATEGORY
                        ,V_START_DATE
                        ,V_PhoneNo1LocalCode
                        ,V_PhoneNo1CityCode
                        ,V_PhoneNo1CountryCode
                        ,V_PhoneNo2LocalCode
                        ,V_PhoneNo2CityCode
                        ,V_PhoneNo2CountryCode
                        ,V_FaxNoLocalCode
                        ,V_FaxNoCityCode
                        ,V_FaxNoCountryCode
                        ,V_Email
                        ,V_PagerNoLocalCode
                        ,V_PagerNoCityCode
                        ,V_PagerNoCountryCode
                        ,V_TelexLocalCode
                        ,V_TelexCityCode
                        ,V_TelexCountryCode
                        ,V_HOUSE_NO
                        ,V_PREMISE_NAME
                        ,V_BUILDING_LEVEL
                        ,V_STREET_NO
                        ,V_STREET_NAME
                        ,V_SUBURB
                        ,V_LOCALITY_NAME
                        ,V_TOWN
                        ,V_DOMICILE
                        ,V_CITY_CODE
                        ,V_STATE_CODE
                        ,V_ZIP
                        ,V_COUNTRY_CODE
                        ,V_SMALL_STR1
                        ,V_SMALL_STR2
                        ,V_SMALL_STR3
                        ,V_SMALL_STR4
                        ,V_SMALL_STR5
                        ,V_SMALL_STR6
                        ,V_SMALL_STR7
                        ,V_SMALL_STR8
                        ,V_SMALL_STR9
                        ,V_SMALL_STR10
                        ,V_MED_STR1
                        ,V_MED_STR2
                        ,V_MED_STR3
                        ,V_MED_STR4
                        ,V_MED_STR5
                        ,V_MED_STR6
                        ,V_MED_STR7
                        ,V_MED_STR8
                        ,V_MED_STR9
                        ,V_MED_STR10
                        ,V_LARGE_STR1
                        ,V_LARGE_STR2
                        ,V_LARGE_STR3
                        ,V_LARGE_STR4
                        ,V_LARGE_STR5
                        ,V_DATE1
                        ,V_DATE2
                        ,V_DATE3
                        ,V_DATE4
                        ,V_DATE5
                        ,V_DATE6
                        ,V_DATE7
                        ,V_DATE8
                        ,V_DATE9
                        ,V_DATE10
                        ,V_NUMBER1
                        ,V_NUMBER2
                        ,V_NUMBER3
                        ,V_NUMBER4
                        ,V_NUMBER5
                        ,V_NUMBER6
                        ,V_NUMBER7
                        ,V_NUMBER8
                        ,V_NUMBER9
                        ,V_NUMBER10
                        ,V_DECIMAL1
                        ,V_DECIMAL2
                        ,V_DECIMAL3
                        ,V_DECIMAL4
                        ,V_DECIMAL5
                        ,V_DECIMAL6
                        ,V_DECIMAL7
                        ,V_DECIMAL8
                        ,V_DECIMAL9
                        ,V_DECIMAL10
                        ,V_PREFERREDADDRESS
                        ,V_HOLDMAILINITIATEDBY
                        ,V_HOLDMAILFLAG
                        ,V_BUSINESSCENTER
                        ,V_HOLDMAILREASON
                        ,V_PREFERREDFORMAT
                        ,V_FREETEXTADDRESS
                        ,V_FREETEXTLABEL
                        ,V_IS_ADDRESS_PROOF_RCVD
                        ,V_LAST_UPDATE_DATE
                        ,V_ADDRESS_LINE1
                        ,V_ADDRESS_LINE2
                        ,V_ADDRESS_LINE3
                        ,V_BANK_ID
                        ,V_IsAddressVerified
                        ,InpSolId
                    );
                --}
                END LOOP;
            --}
            END LOOP;
        --}
        END CC002;
    --} Procudre CC002 End

    PROCEDURE CC005 (InpSolId IN VARCHAR2) IS
    --{
        V_CORP_KEY          NVARCHAR2(32) := '';
        V_CIF_ID            NVARCHAR2(32) := '';
        V_CORP_REP_KEY      NVARCHAR2(38) := '';
        V_TYPE              NVARCHAR2(50) := '';
        V_STR1              NVARCHAR2(255) := '';
        V_STR2              NVARCHAR2(255) := '';
        V_STR3              NVARCHAR2(255) := '';
        V_STR4              NVARCHAR2(255) := '';
        V_STR5              NVARCHAR2(255) := '';
        V_STR6              NVARCHAR2(255) := '';
        V_STR7              NVARCHAR2(255) := '';
        V_STR8              NVARCHAR2(255) := '';
        V_STR9              NVARCHAR2(255) := '';
        V_STR10             NVARCHAR2(255) := '';
        V_STR11             NVARCHAR2(50) := '';
        V_DATE1             DATE := '';
        V_STR12             NVARCHAR2(50) := '';
        V_DATE2             DATE := '';
        V_AMOUNT1           NUMBER(20,4) := '';
        V_AMOUNT2           NUMBER(20,4) := '';
        V_AMOUNT3           NUMBER(20,4) := '';
        V_AMOUNT4           NUMBER(20,4) := '';
        V_SMALL_STR1        NVARCHAR2(50) := '';
        V_SMALL_STR2        NVARCHAR2(50) := '';
        V_SMALL_STR3        NVARCHAR2(50) := '';
        V_SMALL_STR4        NVARCHAR2(50) := '';
        V_SMALL_STR5        NVARCHAR2(50) := '';
        V_SMALL_STR6        NVARCHAR2(50) := '';
        V_SMALL_STR7        NVARCHAR2(50) := '';
        V_SMALL_STR8        NVARCHAR2(50) := '';
        V_SMALL_STR9        NVARCHAR2(50) := '';
        V_SMALL_STR10       NVARCHAR2(50) := '';
        V_MED_STR1          NVARCHAR2(100) := '';
        V_MED_STR2          NVARCHAR2(100) := '';
        V_MED_STR3          NVARCHAR2(100) := '';
        V_MED_STR4          NVARCHAR2(100) := '';
        V_MED_STR5          NVARCHAR2(100) := '';
        V_MED_STR6          NVARCHAR2(100) := '';
        V_MED_STR7          NVARCHAR2(100) := '';
        V_MED_STR8          NVARCHAR2(100) := '';
        V_MED_STR9          NVARCHAR2(100) := '';
        V_MED_STR10         NVARCHAR2(100) := '';
        V_LARGE_STR1        NVARCHAR2(250) := '';
        V_LARGE_STR2        NVARCHAR2(250) := '';
        V_LARGE_STR3        NVARCHAR2(250) := '';
        V_LARGE_STR4        NVARCHAR2(250) := '';
        V_LARGE_STR5        NVARCHAR2(250) := '';
        V_DATE3             DATE := '';
        V_DATE4             DATE := '';
        V_DATE5             DATE := '';
        V_DATE6             DATE := '';
        V_DATE7             DATE := '';
        V_DATE8             DATE := '';
        V_DATE9             DATE := '';
        V_DATE10            DATE := '';
        V_NUMBER1           NUMBER(38) := '';
        V_NUMBER2           NUMBER(38) := '';
        V_NUMBER3           NUMBER(38) := '';
        V_NUMBER4           NUMBER(38) := '';
        V_NUMBER5           NUMBER(38) := '';
        V_NUMBER6           NUMBER(38) := '';
        V_NUMBER7           NUMBER(38) := '';
        V_NUMBER8           NUMBER(38) := '';
        V_NUMBER9           NUMBER(38) := '';
        V_NUMBER10          NUMBER(38) := '';
        V_DECIMAL1          NUMBER(25,6) := '';
        V_DECIMAL2          NUMBER(25,6) := '';
        V_DECIMAL3          NUMBER(25,6) := '';
        V_DECIMAL4          NUMBER(25,6) := '';
        V_DECIMAL5          NUMBER(25,6) := '';
        V_DECIMAL6          NUMBER(25,6) := '';
        V_DECIMAL7          NUMBER(25,6) := '';
        V_DECIMAL8          NUMBER(25,6) := '';
        V_DECIMAL9          NUMBER(25,6) := '';
        V_DECIMAL10         NUMBER(25,6) := '';
        V_ENTITYTYPE        NVARCHAR2(50) := '';
        V_STR43             NVARCHAR2(50) := '';
        V_STR44             NVARCHAR2(50) := '';
        V_STR45             NVARCHAR2(50) := '';
        V_STR46             NVARCHAR2(50) := '';
        V_STR47             NVARCHAR2(50) := '';
        V_STR48             NVARCHAR2(50) := '';
        V_STR49             NVARCHAR2(50) := '';
        V_STR50             NVARCHAR2(50) := '';
        V_ORGKEY            NVARCHAR2(32) := '';
        V_STR21             NVARCHAR2(50) := '';
        V_STR22             NVARCHAR2(50) := '';
        V_STR23             NVARCHAR2(50) := '';
        V_STR24             NVARCHAR2(50) := '';
        V_STR25             NVARCHAR2(50) := '';
        V_STR26             NVARCHAR2(50) := '';
        V_STR27             NVARCHAR2(50) := '';
        V_STR28             NVARCHAR2(1) := '';
        V_STR29             NVARCHAR2(1) := '';
        V_STR30             NVARCHAR2(1) := '';
        V_STR31             NVARCHAR2(1) := '';
        V_STR32             NVARCHAR2(1) := '';
        V_STR38             NVARCHAR2(200) := '';
        V_STR39             NVARCHAR2(200) := '';
        V_STR40             NVARCHAR2(200) := '';
        V_STR41             NVARCHAR2(200) := '';
        V_STR42             NVARCHAR2(200) := '';
        V_DBFLOAT1          FLOAT(126) := '';
        V_DBFLOAT2          FLOAT(126) := '';
        V_DBFLOAT3          FLOAT(126) := '';
        V_DBFLOAT4          FLOAT(126) := '';
        V_DBFLOAT5          FLOAT(126) := '';
        V_AMOUNT5           NUMBER(25,6 ) := '';
        V_FLAG1             NVARCHAR2(10) := '';
        V_FLAG2             NVARCHAR2(10) := '';
        V_FLAG3             NVARCHAR2(10) := '';
        V_FLAG4             NVARCHAR2(10) := '';
        V_FLAG5             NVARCHAR2(10) := '';
        V_INT1              NUMBER(38) := '';
        V_INT2              NUMBER(38) := '';
        V_INT3              NUMBER(38) := '';
        V_INT4              NUMBER(38) := '';
        V_INT5              NUMBER(38) := '';
        V_INT6              NUMBER(38) := '';
        V_INT7              NUMBER(38) := '';
        V_INT8              NUMBER(38) := '';
        V_INT9              NUMBER(38) := '';
        V_INT10             NUMBER(38) := '';
        V_INT11             NUMBER(38) := '';
        V_INT12             NUMBER(38) := '';
        V_INT13             NUMBER(38) := '';
        V_INT14             NUMBER(38) := '';
        V_INT15             NUMBER(38) := '';
        V_MLUSERFIELD1      NVARCHAR2(80) := '';
        V_MLUSERFIELD2      NVARCHAR2(80) := '';
        V_MLUSERFIELD3      NVARCHAR2(80) := '';
        V_MLUSERFIELD4      NVARCHAR2(80) := '';
        V_MLUSERFIELD5      NVARCHAR2(80) := '';
        V_STR1_CODE         NVARCHAR2(5) := '';
        V_STR2_CODE         NVARCHAR2(5) := '';
        V_STR3_CODE         NVARCHAR2(5) := '';
        V_STR4_CODE         NVARCHAR2(5) := '';
        V_STR5_CODE         NVARCHAR2(5) := '';
        V_CORECUSTID        NVARCHAR2(9) := '';
        V_CORECHILDCUSTID   NVARCHAR2(9) := '';
        V_PERCENTAGE1       NUMBER(9,6  ) := '';
        V_PERCENTAGE2       NUMBER(9,6  ) := '';
        V_PERCENTAGE3       NUMBER(9,6  ) := '';
        V_PERCENTAGE4       NUMBER(9,6  ) := '';
        V_PERCENTAGE5       NUMBER(9,6  ) := '';
        V_BANK_ID           NVARCHAR2(8) := '';
        V_STR4_ALT1         NVARCHAR2(99) := '';
        V_STR5_ALT1         NVARCHAR2(99) := '';
        V_STR1_ALT1         NVARCHAR2(99) := '';

        cursor c1(CurSolId varchar2) is
        SELECT CIF_ID FROM VALID_CIF WHERE SOL_ID = CurSolId AND CIF_TYPE = 'C';

        BEGIN
        --{

            V_TYPE := 'CURRENCY';
            V_BANK_ID := '01';
            V_STR1 := 'INR';
            V_DATE1 := TO_DATE('31-12-2099','DD-MM-YYYY');
            V_ENTITYTYPE := 'CUSTOMER';
            V_AMOUNT1 := 0;
            V_PERCENTAGE1 := 0;
            V_PERCENTAGE2 := 0;
            V_PERCENTAGE3 := 0;

            FOR I IN C1(InpSolId)
            LOOP
            --{
                V_CORP_KEY := I.CIF_ID;
                V_CIF_ID := I.CIF_ID;

                INSERT INTO CC005 VALUES
                (
                    V_CORP_KEY
                    ,V_CIF_ID
                    ,V_CORP_REP_KEY
                    ,V_TYPE
                    ,V_STR1
                    ,V_STR2
                    ,V_STR3
                    ,V_STR4
                    ,V_STR5
                    ,V_STR6
                    ,V_STR7
                    ,V_STR8
                    ,V_STR9
                    ,V_STR10
                    ,V_STR11
                    ,V_DATE1
                    ,V_STR12
                    ,V_DATE2
                    ,V_AMOUNT1
                    ,V_AMOUNT2
                    ,V_AMOUNT3
                    ,V_AMOUNT4
                    ,V_SMALL_STR1
                    ,V_SMALL_STR2
                    ,V_SMALL_STR3
                    ,V_SMALL_STR4
                    ,V_SMALL_STR5
                    ,V_SMALL_STR6
                    ,V_SMALL_STR7
                    ,V_SMALL_STR8
                    ,V_SMALL_STR9
                    ,V_SMALL_STR10
                    ,V_MED_STR1
                    ,V_MED_STR2
                    ,V_MED_STR3
                    ,V_MED_STR4
                    ,V_MED_STR5
                    ,V_MED_STR6
                    ,V_MED_STR7
                    ,V_MED_STR8
                    ,V_MED_STR9
                    ,V_MED_STR10
                    ,V_LARGE_STR1
                    ,V_LARGE_STR2
                    ,V_LARGE_STR3
                    ,V_LARGE_STR4
                    ,V_LARGE_STR5
                    ,V_DATE3
                    ,V_DATE4
                    ,V_DATE5
                    ,V_DATE6
                    ,V_DATE7
                    ,V_DATE8
                    ,V_DATE9
                    ,V_DATE10
                    ,V_NUMBER1
                    ,V_NUMBER2
                    ,V_NUMBER3
                    ,V_NUMBER4
                    ,V_NUMBER5
                    ,V_NUMBER6
                    ,V_NUMBER7
                    ,V_NUMBER8
                    ,V_NUMBER9
                    ,V_NUMBER10
                    ,V_DECIMAL1
                    ,V_DECIMAL2
                    ,V_DECIMAL3
                    ,V_DECIMAL4
                    ,V_DECIMAL5
                    ,V_DECIMAL6
                    ,V_DECIMAL7
                    ,V_DECIMAL8
                    ,V_DECIMAL9
                    ,V_DECIMAL10
                    ,V_ENTITYTYPE
                    ,V_STR43
                    ,V_STR44
                    ,V_STR45
                    ,V_STR46
                    ,V_STR47
                    ,V_STR48
                    ,V_STR49
                    ,V_STR50
                    ,V_ORGKEY
                    ,V_STR21
                    ,V_STR22
                    ,V_STR23
                    ,V_STR24
                    ,V_STR25
                    ,V_STR26
                    ,V_STR27
                    ,V_STR28
                    ,V_STR29
                    ,V_STR30
                    ,V_STR31
                    ,V_STR32
                    ,V_STR38
                    ,V_STR39
                    ,V_STR40
                    ,V_STR41
                    ,V_STR42
                    ,V_DBFLOAT1
                    ,V_DBFLOAT2
                    ,V_DBFLOAT3
                    ,V_DBFLOAT4
                    ,V_DBFLOAT5
                    ,V_AMOUNT5
                    ,V_FLAG1
                    ,V_FLAG2
                    ,V_FLAG3
                    ,V_FLAG4
                    ,V_FLAG5
                    ,V_INT1
                    ,V_INT2
                    ,V_INT3
                    ,V_INT4
                    ,V_INT5
                    ,V_INT6
                    ,V_INT7
                    ,V_INT8
                    ,V_INT9
                    ,V_INT10
                    ,V_INT11
                    ,V_INT12
                    ,V_INT13
                    ,V_INT14
                    ,V_INT15
                    ,V_MLUSERFIELD1
                    ,V_MLUSERFIELD2
                    ,V_MLUSERFIELD3
                    ,V_MLUSERFIELD4
                    ,V_MLUSERFIELD5
                    ,V_STR1_CODE
                    ,V_STR2_CODE
                    ,V_STR3_CODE
                    ,V_STR4_CODE
                    ,V_STR5_CODE
                    ,V_CORECUSTID
                    ,V_CORECHILDCUSTID
                    ,V_PERCENTAGE1
                    ,V_PERCENTAGE2
                    ,V_PERCENTAGE3
                    ,V_PERCENTAGE4
                    ,V_PERCENTAGE5
                    ,V_BANK_ID
                    ,V_STR4_ALT1
                    ,V_STR5_ALT1
                    ,V_STR1_ALT1
                    ,InpSolId
                );
            --}
            END LOOP;
        --}
        END CC005;
    --} Procudre CC005 End

    PROCEDURE CC007 (InpSolId IN VARCHAR2) IS
    --{
        V_CORP_KEY              NVARCHAR2(32) := '';
        V_CORP_REP_KEY          NVARCHAR2(50) := '';
        V_BENEFICIALOWNERKEY    NVARCHAR2(50) := '';
        V_DOCDUEDATE            DATE := '';
        V_DOCRECEIVEDDATE       DATE := '';
        V_DOCEXPIRYDATE         DATE := '';
        V_DOCDELFLG             NVARCHAR2(1) := '';
        V_DOCREMARKS            NVARCHAR2(255) := '';
        V_SCANNED               NVARCHAR2(1) := '';
        V_DOCCODE               NVARCHAR2(20) := '';
        V_DOCDESCR              NVARCHAR2(255) := '';
        V_REFERENCENUMBER       NVARCHAR2(100) := '';
        V_ISMANDATORY           NVARCHAR2(1) := '';
        V_SCANREQUIRED          NVARCHAR2(10) := '';
        V_ROLE                  NVARCHAR2(50) := '';
        V_DOCTYPECODE           NVARCHAR2(50) := '';
        V_DOCTYPEDESCR          NVARCHAR2(2000) := '';
        V_MINDOCSREQD           NUMBER(38) := '';
        V_WAIVEDORDEFEREDDATE   DATE := '';
        V_COUNTRYOFISSUE        NVARCHAR2(50) := '';
        V_PLACEOFISSUE          NVARCHAR2(200) := '';
        V_DOCISSUEDATE          DATE := '';
        V_IDENTIFICATIONTYPE    NVARCHAR2(50) := '';
        V_CORE_CUST_ID          NVARCHAR2(9) := '';
        V_IS_DOCUMENT_VERIFIED	NVARCHAR2(1) := '';
        V_BANK_ID               NVARCHAR2(8) := '';

        cursor c1(CurSolId varchar2) is
        SELECT  cif_id
                ,CLIENTS_PAN_GIR_NUM
                ,NVL(CLIENTS_OPENING_DATE,CLIENTS_ENTD_ON) CLIENTS_OPENING_DATE
        FROM cbs.clients,valid_cif
        WHERE cif_id = CLIENTS_CODE
        AND sol_id = CurSolId
        AND cif_type = 'C';

        BEGIN
        --{
            V_BANK_ID := '01';
            V_COUNTRYOFISSUE := 'IN';
            V_DOCCODE := 'PUBPN';
            V_DOCTYPECODE := 'PUB';
            V_PLACEOFISSUE := 'MIG';

            FOR I IN C1(InpSolId)
            LOOP
            --{
                V_CORP_KEY := I.CIF_ID;
                V_DOCISSUEDATE := I.CLIENTS_OPENING_DATE;
                V_REFERENCENUMBER := I.CLIENTS_PAN_GIR_NUM;

                INSERT INTO CC007 VALUES
                (
                    V_CORP_KEY
                    ,V_CORP_REP_KEY
                    ,V_BENEFICIALOWNERKEY
                    ,V_DOCDUEDATE
                    ,V_DOCRECEIVEDDATE
                    ,V_DOCEXPIRYDATE
                    ,V_DOCDELFLG
                    ,V_DOCREMARKS
                    ,V_SCANNED
                    ,V_DOCCODE
                    ,V_DOCDESCR
                    ,V_REFERENCENUMBER
                    ,V_ISMANDATORY
                    ,V_SCANREQUIRED
                    ,V_ROLE
                    ,V_DOCTYPECODE
                    ,V_DOCTYPEDESCR
                    ,V_MINDOCSREQD
                    ,V_WAIVEDORDEFEREDDATE
                    ,V_COUNTRYOFISSUE
                    ,V_PLACEOFISSUE
                    ,V_DOCISSUEDATE
                    ,V_IDENTIFICATIONTYPE
                    ,V_CORE_CUST_ID
                    ,V_IS_DOCUMENT_VERIFIED
                    ,V_BANK_ID
                    ,InpSolId
                );
            --}
            END LOOP;
        --}
        END CC007;
    --} Procudre CC007 End

    PROCEDURE CC008 (InpSolId IN VARCHAR2) IS
    --{
        V_CORP_KEY              NVARCHAR2(32) := '';
        V_PHONEEMAILTYPE        NVARCHAR2(200) := '';
        V_PHONEOREMAIL          NVARCHAR2(50) := '';
        V_PHONE_NO              NVARCHAR2(25) := '';
        V_PHONENOLOCALCODE      NVARCHAR2(20) := '';
        V_PHONENOCITYCODE       NVARCHAR2(20) := '';
        V_PHONENOCOUNTRYCODE	NVARCHAR2(20) := '';
        V_WORKEXTENSION	        NVARCHAR2(30) := '';
        V_EMAIL	                NVARCHAR2(50) := '';
        V_EMAILPALM	            NVARCHAR2(50) := '';
        V_URL	                NVARCHAR2(150) := '';
        V_PREFERREDFLAG	        NVARCHAR2(50) := '';
        V_Start_Date	        DATE := '';
        V_End_Date	            DATE := '';
        V_USERFIELD1            NVARCHAR2(200) := '';
        V_USERFIELD2            NVARCHAR2(200) := '';
        V_USERFIELD3            NVARCHAR2(200) := '';
        V_DATE1                 DATE := '';
        V_DATE2                 DATE := '';
        V_DATE3                 DATE := '';
        V_BANK_ID	            NVARCHAR2(8) := '';

        V_PHONE_RES_TYPE        NVARCHAR2(200) := '';
        V_PHONE_RES_TYPE1       NVARCHAR2(200) := '';
        V_PHONE_CELLPH_TYPE     NVARCHAR2(200) := '';
        V_PHONE_CELLPH_TYPE1    NVARCHAR2(200) := '';
        V_PHONE_WORK_TYPE       NVARCHAR2(200) := '';
        V_PHONE_WORK_TYPE1      NVARCHAR2(200) := '';
        V_EMAIL_TYPE            NVARCHAR2(200) := '';
        V_EMAIL_TYPE1           NVARCHAR2(200) := '';
        V_CELLPH_CNTRY_CODE     NVARCHAR2(5) := '';
        V_CELLPH_NUMBER         NVARCHAR2(10) := '';
        V_PHONE_FAX_TYPE        NVARCHAR2(200) := '';
        V_PREFERRED_ALLOCATED   CHAR(1) := 'N';
        V_PHONE_PREFERREDFLAG   CHAR(1) := '';
        V_EMAIL_PREFERREDFLAG   CHAR(1) := '';

        CURSOR C1(CurSolId varchar2) IS
        SELECT CIF_ID FROM VALID_CIF WHERE SOL_ID = CurSolId AND CIF_TYPE = 'C';

        BEGIN
        --{
            V_BANK_ID := '01';

            V_PHONE_RES_TYPE := 'HOMEPH1';
            V_PHONE_RES_TYPE1 := 'HOMEPH2';
            V_PHONE_CELLPH_TYPE := 'Mobile1';
            V_PHONE_CELLPH_TYPE1 := 'Mobile2';
            V_PHONE_WORK_TYPE := 'WORKPH1';
            V_PHONE_WORK_TYPE1 := 'WORKPH2';

            V_EMAIL_TYPE := 'COMMEML';
            V_EMAIL_TYPE1 := 'HOMEEML';

            V_PHONE_FAX_TYPE := 'FAX1';

            FOR I IN C1(InpSolId)
            LOOP
            --{
                V_CORP_KEY := I.CIF_ID;

                V_PREFERRED_ALLOCATED := 'N';

                V_PHONE_PREFERREDFLAG := 'N';
                V_EMAIL_PREFERREDFLAG := 'N';

                BEGIN
                    SELECT SMSBREG_CALL_CODE, SMSBREG_MOBILE_NUMBER
                    INTO V_CELLPH_CNTRY_CODE, V_CELLPH_NUMBER
                    FROM CBS.SMSBREG A
                    WHERE SMSBREG_ACTIVE = 1
                    AND SMSBREG_REG_SL = (SELECT MAX(SMSBREG_REG_SL) FROM CBS.SMSBREG B WHERE A.SMSBREG_MOBILE_OWNER = B.SMSBREG_MOBILE_OWNER AND B.SMSBREG_ACTIVE = 1)
                    AND SMSBREG_REG_DATE = (SELECT MAX(SMSBREG_REG_DATE) FROM CBS.SMSBREG B WHERE A.SMSBREG_MOBILE_OWNER = B.SMSBREG_MOBILE_OWNER and B.SMSBREG_ACTIVE = 1)
                    AND SMSBREG_MOBILE_OWNER = I.CIF_ID;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_CELLPH_CNTRY_CODE := '';
                    V_CELLPH_NUMBER := '';
                END;

                IF(CommonExtractionPack.CheckNumber(V_CELLPH_NUMBER) != 'N') THEN
                --{
                    V_PHONE_PREFERREDFLAG := 'Y';
                    V_PREFERRED_ALLOCATED := 'Y';

                    V_PHONEOREMAIL := 'PHONE';

                    INSERT INTO CC008
                    (CORP_KEY ,PHONEEMAILTYPE ,PHONEOREMAIL ,PHONE_NO ,PHONENOLOCALCODE ,PHONENOCITYCODE ,PHONENOCOUNTRYCODE ,WORKEXTENSION ,PREFERRED_FLAG ,BANK_ID,SOL_ID)
                    VALUES (V_CORP_KEY,V_PHONE_CELLPH_TYPE,'PHONE',V_CELLPH_CNTRY_CODE||V_CELLPH_NUMBER,V_CELLPH_NUMBER,null,V_CELLPH_CNTRY_CODE,null,V_PHONE_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;
            --}
            END LOOP;
        --}
        END CC008;
    --} Procudre CC008 End

--}
END CorpCifPack;
/

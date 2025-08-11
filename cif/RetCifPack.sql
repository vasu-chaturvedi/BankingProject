 CREATE OR REPLACE PACKAGE RetailCifPack AS
--{
    PROCEDURE RC001 (InpSolId IN VARCHAR2);
    PROCEDURE RC002 (InpSolId IN VARCHAR2);
    PROCEDURE RC003 (InpSolId IN VARCHAR2);
    PROCEDURE RC004 (InpSolId IN VARCHAR2);
    PROCEDURE RC005 (InpSolId IN VARCHAR2);
    PROCEDURE RC006 (InpSolId IN VARCHAR2);
    PROCEDURE RC008 (InpSolId IN VARCHAR2);
    PROCEDURE RC009 (InpSolId IN VARCHAR2);

    PROCEDURE RC001_PGK (InpSolId IN VARCHAR2);
    PROCEDURE RC002_PGK (InpSolId IN VARCHAR2);
    PROCEDURE RC003_PGK (InpSolId IN VARCHAR2);
    PROCEDURE RC008_PGK (InpSolId IN VARCHAR2);
    PROCEDURE RC009_PGK (InpSolId IN VARCHAR2);
--}
END RetailCifPack;
/

CREATE OR REPLACE PACKAGE BODY RetailCifPack AS
--{
    PROCEDURE RC001 (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT
            A.*
            ,SUBSTR(CLIENT_NAME,0,50) PREFERREDNAME
            ,SUBSTR(CUST_FIRST_NAME,0,10) SHORT_NAME
            ,FLOOR(MONTHS_BETWEEN(SYSDATE,CUST_DOB)/12) AGE
            ,DECODE(TRIM(STAFFEMPLOYEEID),null,'N','Y') STAFFFLAG
        FROM
            RET_VALID_CIF A
        WHERE 
            SOL_ID = InpSolId;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC001%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE MapperType IS TABLE OF VARCHAR2(80) INDEX BY VARCHAR2(200);
        TYPE CatType IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);

        CurRec      CurType;
        TableRec    TableType;
        mapper      MapperType;
        pidmapper   MapperType;
        mappertds   MapperType;
        v_key       VARCHAR2(200);
        V_BatchSize CONSTANT PLS_INTEGER := 10000;

        BEGIN
        --{

            FOR rec IN (SELECT * FROM mapper_table) LOOP
                mapper(rec.field_type || '|' || rec.old_value || '|' || rec.source_system) := rec.new_value;
            END LOOP;

            FOR rec IN (SELECT * FROM mapper_tds_tbl_code) LOOP
                mappertds(rec.IT_STAT_CODE ||','||rec.IT_SUB_STAT_CODE||','||rec.TAX_REGIME) := rec.TDS_TBL_CODE;
            END LOOP;

            OPEN C1;
            loop
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;
            
                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).ENTITYTYPE := 'CUSTOMER';
                    TableRec(i).DOCUMENT_RECIEVED := 'Y';
                    TableRec(i).CRNCY_CODE_RETAIL := 'INR';
                    TableRec(i).CUST_CHRG_HISTORY_FLG := 'N';
                    TableRec(i).COMBINED_STMT_REQD := 'N';
                    TableRec(i).DESPATCH_MODE := 'N';
                    TableRec(i).BANK_ID := '01';
                    TableRec(i).ISEBANKINGENABLED := 'N';
                    TableRec(i).PURGEFLAG := 'N';
                    TableRec(i).REGION := 'MIG';
                    TableRec(i).Sector := 'MIG';
                    TableRec(i).SubSector := 'MIG';
                    TableRec(i).SEGMENTATION_CLASS := 'Retail';
                    TableRec(i).SUBSEGMENT := 'Retail';
                    TableRec(i).TFPARTYFLAG := 'N';
                    TableRec(i).ALLOW_SWEEPS := 'N';
                    TableRec(i).NativeLangCode := 'INFENG';
                    TableRec(i).CUST_LANGUAGE := 'INFENG';

                    TableRec(i).ORGKEY  := CurRec(i).ORGKEY;
                    TableRec(i).CIF_ID  := CurRec(i).ORGKEY;
                    TableRec(i).SOL_ID  := InpSolId;

                    TableRec(i).CUST_FIRST_NAME     := CommonExtractionPack.RemoveSpecialChars(CurRec(i).CUST_FIRST_NAME);
                    TableRec(i).SHORT_NAME          := CommonExtractionPack.RemoveSpecialChars(CurRec(i).SHORT_NAME);
                    TableRec(i).MAIDENNAMEOFMOTHER  := CommonExtractionPack.RemoveSpecialChars(CurRec(i).MAIDENNAMEOFMOTHER);
                    TableRec(i).PREFERREDNAME       := CommonExtractionPack.RemoveSpecialChars(CurRec(i).PREFERREDNAME);
                    TableRec(i).StrUserField1       := CommonExtractionPack.RemoveSpecialChars(CurRec(i).STRUSERFIELD1);
                    TableRec(i).PHYSICAL_STATE      := CommonExtractionPack.RemoveSpecialChars(CurRec(i).PHYSICAL_STATE);

                    IF(CurRec(i).CUST_MIDDLE_NAME IS NULL) THEN
                    --{
                        TableRec(i).CUST_MIDDLE_NAME    := CommonExtractionPack.RemoveSpecialChars(CurRec(i).CUST_LAST_NAME);
                        TableRec(i).CUST_LAST_NAME      := CommonExtractionPack.RemoveSpecialChars(CurRec(i).CUST_SUR_NAME);
                    --}
                    ELSE
                    --{
                        TableRec(i).CUST_MIDDLE_NAME    := CommonExtractionPack.RemoveSpecialChars(CurRec(i).CUST_MIDDLE_NAME);
                        TableRec(i).CUST_LAST_NAME      := CommonExtractionPack.RemoveSpecialChars(CurRec(i).CUST_LAST_NAME);
                    --}
                    END IF;

                    IF(TableRec(i).CUST_LAST_NAME IS NULL) THEN
                    --{
                        TableRec(i).CUST_LAST_NAME      := '.';
                    --}
                    END IF;

                    TableRec(i).CUST_DOB                := CurRec(i).CUST_DOB;
                    TableRec(i).GENDER                  := CurRec(i).GENDER;
                    TableRec(i).NATIONALITY_CODE        := CurRec(i).NATIONALITY_CODE;
                    TableRec(i).STAFFEMPLOYEEID         := CurRec(i).STAFFEMPLOYEEID;
                    TableRec(i).STAFFFLAG               := CurRec(i).STAFFFLAG;
                    TableRec(i).PlaceOfBirth            := CurRec(i).PlaceOfBirth;
                    TableRec(i).CUST_COMMUNITY          := CurRec(i).CUST_COMMUNITY;
                    TableRec(i).StrUserField2           := NVL(CurRec(i).TSSCR_CKYC_NUMBER,CurRec(i).CKYCHDTL_CKYC_NUM);
                    TableRec(i).CUSTOMERNREFLAG         := CurRec(i).CUSTOMERNREFLAG;
                    TableRec(i).CORE_CUST_ID            := CurRec(i).ORGKEY;
                    TableRec(i).PRIMARY_SERVICE_CENTRE  := CurRec(i).PRIMARY_SOL_ID;
                    TableRec(i).PRIMARY_SOL_ID          := CurRec(i).PRIMARY_SOL_ID;
                    TableRec(i).RELATIONSHIPOPENINGDATE := CurRec(i).RELATIONSHIPOPENINGDATE;
                    TableRec(i).MANAGER                 := NVL(CurRec(i).MANAGER,'UBSADMIN');
                    TableRec(i).RISKRATING              := CurRec(i).RISKRATING;
                    TableRec(i).CONSTITUTION_REF_CODE   := CurRec(i).CONSTITUTION_REF_CODE;

                    IF(CurRec(i).CUSTOMERNREFLAG = 'Y') THEN
                    --{
                        TableRec(i).DATEOFBECOMINGNRE := CurRec(i).RELATIONSHIPOPENINGDATE;
                    --}
                    ELSE
                    --{
                        TableRec(i).DATEOFBECOMINGNRE := NULL;
                    --}
                    END IF;

                    TableRec(i).FOREIGNACCtAXREPORTINGREQ := CurRec(i).FOREIGNACCtAXREPORTINGREQ;

                    IF(CurRec(i).FOREIGNACCtAXREPORTINGREQ = 'Y') THEN
                    --{
                        TableRec(i).ForeignTaxReportingCountry := 'IN';
                        TableRec(i).ForeignTaxReportingStatus := 'ACT';
                    --}
                    END IF;

                    IF CurRec(i).AGE < 18 THEN
                      TableRec(i).CUSTOMERMINOR := 'Y';
                      TableRec(i).SENIORCITIZEN := 'N';
                    ELSIF CurRec(i).AGE >= 60 THEN
                      TableRec(i).CUSTOMERMINOR := 'N';
                      TableRec(i).SENIORCITIZEN := 'Y';
                    ELSE
                      TableRec(i).CUSTOMERMINOR := 'N';
                      TableRec(i).SENIORCITIZEN := 'N';
                    END IF;

                    TableRec(i).STATUS_CODE     := mapper('CUSTOMER_STATUS|'||NVL(TRIM(CurRec(i).STATUS_CODE),'A')||'|CBS');
                    TableRec(i).CUST_LANGUAGE   := mapper('LANGUAGE|'||CurRec(i).CUST_LANGUAGE||'|CBS');
                    TableRec(i).CUST_TYPE_CODE  := mapper('ACCOUNT_TYPE|'||NVL(TRIM(CurRec(i).CUST_TYPE_CODE),'A')||'|CBS');
                    TableRec(i).SALUTATION_CODE := mapper('TITLE|'||CurRec(i).SALUTATION_CODE||'|CBS');

                    IF(CurRec(i).status_code = 'D') THEN
                    --{
                        TableRec(i).DateOfNotification := CurRec(i).status_date;
                    --}
                    END IF;

                    v_key := CurRec(i).IT_STAT_CODE||','||CurRec(i).IT_SUB_STAT_CODE||','||CurRec(i).TAXREGIME;

                    IF(mappertds.EXISTS(v_key)) THEN
                        TableRec(i).TDS_TBL_CODE := mappertds(v_key);
                    ELSE
                        TableRec(i).TDS_TBL_CODE := 'GEN10';
                    END IF;

                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC001 VALUES TableRec(i);

                commit;

                TableRec.delete;
                
            --}
            END LOOP;
            close c1;
        --}
        END RC001;
    --} Procuder RC001 End

    PROCEDURE RC002 (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT
            A.*
        FROM
            RET_ADDR_DTLS A
        WHERE 
            SOL_ID = InpSolId;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC002%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE MapperType IS TABLE OF VARCHAR2(80) INDEX BY VARCHAR2(200);
        TYPE CatType IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);

        CurRec      CurType;
        TableRec    TableType;
        mapper      MapperType;
        locmapper   MapperType;
        V_BatchSize CONSTANT PLS_INTEGER := 10000;
        comma_pos   PLS_INTEGER;

        V_ADDRESS       VARCHAR2(350);
        V_StateCntry    VARCHAR2(350);

        BEGIN
        --{
            FOR rec IN (SELECT * FROM mapper_table) LOOP
                mapper(rec.field_type || '|' || rec.old_value || '|' || rec.source_system) := rec.new_value;
            END LOOP;

            FOR rec IN (SELECT LOCN_STATE_CODE,LOCN_CNTRY_CODE,LOCN_CODE FROM CBS.LOCATION) LOOP
                locmapper(rec.LOCN_CODE) := rec.LOCN_STATE_CODE||','||rec.LOCN_CNTRY_CODE;
            END LOOP;

            OPEN C1;
            LOOP
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;

                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).BANK_ID     := '01';
                    TableRec(i).END_DATE    := TO_DATE('31-12-2099','DD-MM-YYYY');
                    TableRec(i).SOL_ID      := InpSolId;

                    TableRec(i).ZIP         := NVL(REPLACE(TRIM(CurRec(i).ZIP_CODE),'.',''),'999999');
                    TableRec(i).ORGKEY      := CurRec(i).ORGKEY;
                    TableRec(i).SOL_ID      := CurRec(i).SOL_ID;

                    IF(TRIM(CurRec(i).ADDRDTLS_ADDR1) IS NOT NULL) THEN
                    --{
                        V_ADDRESS :=  CurRec(i).ADDRDTLS_ADDR1;
                    --}
                    END IF;

                    IF(TRIM(CurRec(i).ADDRDTLS_ADDR2) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| CurRec(i).ADDRDTLS_ADDR2;
                    --}
                    END IF;

                    IF(TRIM(CurRec(i).ADDRDTLS_ADDR3) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| CurRec(i).ADDRDTLS_ADDR3;
                    --}
                    END IF;

                    IF(TRIM(CurRec(i).ADDRDTLS_ADDR4) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| CurRec(i).ADDRDTLS_ADDR4;
                    --}
                    END IF;

                    IF(TRIM(CurRec(i).ADDRDTLS_ADDR5) IS NOT NULL) THEN
                    --{
                        V_ADDRESS := V_ADDRESS ||' '|| CurRec(i).ADDRDTLS_ADDR5;
                    --}
                    END IF;

                    V_ADDRESS := CommonExtractionPack.RemoveSpecialChars(V_ADDRESS);

                    IF(length(V_ADDRESS) > 135) THEN
                    --{
                        TableRec(i).PreferredFormat := 'STRUCTURED_FORMAT';

                        TableRec(i).HOUSE_NO        := SUBSTR(V_ADDRESS,0,10);
                        TableRec(i).PREMISE_NAME    := SUBSTR(V_ADDRESS,11,50);
                        TableRec(i).BUILDING_LEVEL  := SUBSTR(V_ADDRESS,61,10);
                        TableRec(i).STREET_NO       := SUBSTR(V_ADDRESS,71,50);
                        TableRec(i).STREET_NAME     := SUBSTR(V_ADDRESS,121,50);
                        TableRec(i).SUBURB          := SUBSTR(V_ADDRESS,171,50);
                        TableRec(i).LOCALITY_NAME   := SUBSTR(V_ADDRESS,221,50);
                        TableRec(i).TOWN            := SUBSTR(V_ADDRESS,271,50);
                        TableRec(i).DOMICILE        := SUBSTR(V_ADDRESS,321,50);
                    --}
                    ELSE
                    --{
                        TableRec(i).FreeTextAddress := V_ADDRESS;
                        TableRec(i).FreeTextLabel	:= V_ADDRESS;
                        TableRec(i).PreferredFormat := 'FREE_TEXT_FORMAT';
                        TableRec(i).ADDRESS_LINE1   := SUBSTR(V_ADDRESS,0,45);
                        TableRec(i).ADDRESS_LINE2   := SUBSTR(V_ADDRESS,46,45);
                        TableRec(i).ADDRESS_LINE3   := SUBSTR(V_ADDRESS,91,45);
                    --}
                    END IF;

                    TableRec(i).CITY_CODE := NVL(TRIM(CurRec(i).ADDRDTLS_LOCN_CODE),'MIG');

                    IF(locmapper.EXISTS(CurRec(i).ADDRDTLS_LOCN_CODE)) THEN
                        V_StateCntry := locmapper(CurRec(i).ADDRDTLS_LOCN_CODE);
                    ELSE
                        V_StateCntry := 'MIG,MIG';
                    END IF;

                    comma_pos := INSTR(V_StateCntry,',');

                    TableRec(i).STATE_CODE      := substr(V_StateCntry,0,comma_pos-1);
                    TableRec(i).COUNTRY_CODE    := substr(V_StateCntry,comma_pos+1);

                    TableRec(i).ADDRESSCATEGORY := mapper('ADDRTYPE|'||CurRec(i).ADDRDTLS_ADDR_TYPE||'|CBS');
                    TableRec(i).PREFERREDADDRESS := CurRec(i).preferredaddrflag;

                    IF(CurRec(i).preferredaddrflag = 'Y') THEN 
                    --{
                        TableRec(i).ADDRESSCATEGORY := 'Mailing';
                    --}
                    END IF;
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC002 VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            CLOSE C1;
        --}
        END RC002;
    --} Procudre RC002 End

    PROCEDURE RC003 (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is
        --SELECT CIF_ID FROM VALID_CIF WHERE SOL_ID = CurSolId AND CIF_TYPE = 'R';
        SELECT ORGKEY,'INR' Currency FROM RET_VALID_CIF WHERE SOL_ID = InpSolId;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC003%ROWTYPE INDEX BY PLS_INTEGER;

        CurRec      CurType;
        TableRec    TableType;
        V_BatchSize CONSTANT PLS_INTEGER := 10000;

        BEGIN
        --{
            OPEN C1;
            LOOP
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;

                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).SOL_ID := InpSolId;
                    TableRec(i).ORGKEY := CurRec(i).ORGKEY;
                    TableRec(i).CIF_ID := CurRec(i).ORGKEY;
                    TableRec(i).BANK_ID := '01';
                    TableRec(i).TYPE := 'CURRENCY';
                    TableRec(i).CUSTOMERCURRENCY := CurRec(i).Currency;
                    TableRec(i).STRTEXT10 := CurRec(i).Currency;
                    TableRec(i).DBFLOAT1 := 0;
                    TableRec(i).DBFLOAT2 := 0;
                    TableRec(i).DBFLOAT3 := 0;
                    TableRec(i).DBFLOAT4 := 0;
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC003 VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            CLOSE C1;
        --}
        END RC003;
    --} Procudre RC003 End

    PROCEDURE RC004 (InpSolId IN VARCHAR2) IS
    --{
        V_ORGKEY				NVarchar2(50) := '';
        V_CHILDENTITY           NVarchar2(50) := '';
        V_CHILDENTITYID         NVarchar2(32) := '';
        V_Relationship          NVarchar2(50) := '';
        V_TITLE                 NVarchar2(5) := '';
        V_FIRSTNAME             NVarchar2(80) := '';
        V_MIDDLENAME            NVarchar2(80) := '';
        V_LASTNAME              NVarchar2(80) := '';
        V_DOB                   DATE := '';
        V_GENDER                NVarchar2(10) := '';
        V_ISDEPENDANT           NVarchar2(1) := '';
        V_GAURDIANTYPE          NVarchar2(1) := '';
        V_ISPRIMARY             NVarchar2(1) := '';
        V_HOUSE_NO              NVarchar2(10) := '';
        V_PREMISE_NAME          NVarchar2(50) := '';
        V_BUILDING_LEVEL        NVarchar2(10) := '';
        V_STREET_NO             NVarchar2(50) := '';
        V_STREET_NAME           NVarchar2(50) := '';
        V_SUBURB                NVarchar2(50) := '';
        V_locality_name         NVarchar2(50) := '';
        V_town                  NVarchar2(50) := '';
        V_DOMICILE              NVarchar2(50) := '';
        V_CITY_CODE             NVarchar2(5) := '';
        V_STATE_CODE            NVarchar2(5) := '';
        V_ZIP                   NVarchar2(100) := '';
        V_COUNTRY_CODE          NVarchar2(5) := '';
        V_STATUS_CODE           NVarchar2(5) := '';
        V_NEWCONTACTSKEY        NUMBER(32) := '';
        V_CIF_ID                NVarchar2(32) := '';
        V_START_DATE            DATE := '';
        V_PERCENTAGEBENEFITTED	NUMBER(6) := '';
        V_PHONENO1LOCALCODE     NVarchar2(20) := '';
        V_PHONENO1CITYCODE      NVarchar2(20) := '';
        V_PHONENO1COUNTRYCODE   NVarchar2(20) := '';
        V_WORKEXTENSION         NVarchar2(20) := '';
        V_PHONENO2LOCALCODE     NVarchar2(20) := '';
        V_PHONENO2CITYCODE      NVarchar2(20) := '';
        V_PHONENO2COUNTRYCODE   NVarchar2(20) := '';
        V_TELEXLOCALCODE        NVarchar2(20) := '';
        V_TELEXCITYCODE         NVarchar2(20) := '';
        V_TELEXCOUNTRYCODE      NVarchar2(20) := '';
        V_FAXNOLOCALCODE        NVarchar2(20) := '';
        V_FAXNOCITYCODE         NVarchar2(20) := '';
        V_FAXNOCOUNTRYCODE      NVarchar2(20) := '';
        V_PAGERNOLOCALCODE      NVarchar2(20) := '';
        V_PAGERNOCITYCODE       NVarchar2(20) := '';
        V_PAGERNOCOUNTRYCODDE   NVarchar2(20) := '';
        V_EMAIL                 NVarchar2(50) := '';
        V_CHILDENTITYTYPE       NVarchar2(50) := '';
        V_BEN_OWN_KEY           NVarchar2(50) := '';
        V_BANK_ID               NVarchar2(8) := '';
        V_RELATIONSHIP_ALT1     NVarchar2(50) := '';
        V_RELATIONSHIP_CATEGORY	NVarchar2(50) := '';

        CURSOR C1(CurSolId varchar2) is
        SELECT * FROM RC001 WHERE CUSTOMERMINOR = 'Y' AND PRIMARY_SOL_ID = CurSolId;

        BEGIN
        --{
            FOR I IN C1(InpSolId)
            LOOP
            --{
                INSERT INTO RC004 VALUES
                (
                    V_ORGKEY,
                    V_CHILDENTITY,
                    V_CHILDENTITYID,
                    V_Relationship,
                    V_TITLE,
                    V_FIRSTNAME,
                    V_MIDDLENAME,
                    V_LASTNAME,
                    V_DOB,
                    V_GENDER,
                    V_ISDEPENDANT,
                    V_GAURDIANTYPE,
                    V_ISPRIMARY,
                    V_HOUSE_NO,
                    V_PREMISE_NAME,
                    V_BUILDING_LEVEL,
                    V_STREET_NO,
                    V_STREET_NAME,
                    V_SUBURB,
                    V_locality_name,
                    V_town,
                    V_DOMICILE,
                    V_CITY_CODE,
                    V_STATE_CODE,
                    V_ZIP,
                    V_COUNTRY_CODE,
                    V_STATUS_CODE,
                    V_NEWCONTACTSKEY,
                    V_CIF_ID,
                    V_START_DATE,
                    V_PERCENTAGEBENEFITTED,
                    V_PHONENO1LOCALCODE,
                    V_PHONENO1CITYCODE,
                    V_PHONENO1COUNTRYCODE,
                    V_WORKEXTENSION,
                    V_PHONENO2LOCALCODE,
                    V_PHONENO2CITYCODE,
                    V_PHONENO2COUNTRYCODE,
                    V_TELEXLOCALCODE,
                    V_TELEXCITYCODE,
                    V_TELEXCOUNTRYCODE,
                    V_FAXNOLOCALCODE,
                    V_FAXNOCITYCODE,
                    V_FAXNOCOUNTRYCODE,
                    V_PAGERNOLOCALCODE,
                    V_PAGERNOCITYCODE,
                    V_PAGERNOCOUNTRYCODDE,
                    V_EMAIL,
                    V_CHILDENTITYTYPE,
                    V_BEN_OWN_KEY,
                    V_BANK_ID,
                    V_RELATIONSHIP_ALT1,
                    V_RELATIONSHIP_CATEGORY,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END RC004;
    --} Procudre RC004 End

    PROCEDURE RC005 (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT
            ORGKEY
            ,PIDDOCS_PID_TYPE
            ,CommonExtractionPack.RemoveSpecialChars(REFERENCENUMBER) REFERENCENUMBER
            ,PIDDOCS_ISSUE_DATE
            ,PIDDOCS_ISSUE_PLACE
            ,PIDDOCS_EXP_DATE
        FROM
            RET_PID_DTLS A
        WHERE 
            SOL_ID = InpSolId;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC005%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE MapperType IS TABLE OF VARCHAR2(80) INDEX BY VARCHAR2(200);
        TYPE CatType IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);

        CurRec          CurType;
        TableRec        TableType;
        pidmapper       MapperType;
        v_key           VARCHAR2(200);
        V_BatchSize     CONSTANT PLS_INTEGER := 10000;
        V_DOCCODETYPE   NVARCHAR2(50) := '';

        BEGIN
        --{
            FOR rec IN (SELECT * FROM pid_mapper_table) LOOP
                pidmapper(rec.OLD_VALUE) := rec.NEW_VALUE||','||rec.PID_TYPE;
            END LOOP;

            OPEN C1;
            loop
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;
            
                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).BANK_ID         := '01';
                    TableRec(i).COUNTRYOFISSUE  := 'IN';
                    TableRec(i).SOL_ID          := InpSolId;
                    TableRec(i).REFERENCENUMBER := CurRec(i).REFERENCENUMBER;
                    TableRec(i).ORGKEY          := CurRec(I).ORGKEY;
                    TableRec(i).DOCEXPIRYDATE   := CurRec(I).PIDDOCS_EXP_DATE;
                    TableRec(i).DOCISSUEDATE    := CurRec(I).PIDDOCS_ISSUE_DATE;
                    TableRec(i).PLACEOFISSUE    := CurRec(I).PIDDOCS_ISSUE_PLACE;

                    V_DOCCODETYPE               := pidmapper(CurRec(I).PIDDOCS_PID_TYPE);

                    TableRec(i).DOCCODE         := substr(V_DOCCODETYPE,0,instr(V_DOCCODETYPE,',')-1);
                    TableRec(i).DOCTYPECODE     := substr(V_DOCCODETYPE,instr(V_DOCCODETYPE,',')+1);
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC005 VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            close c1;
        --}
        END RC005;
    --} Procudre RC005 End

    PROCEDURE RC006 (InpSolId IN VARCHAR2) IS
    --{
        V_ORGKEY				NVarchar2(50) := '';
        V_PHONEEMAILTYPE        NVarchar2(200) := '';
        V_PHONEOREMAIL          NVarchar2(50) := '';
        V_PHONE_NO              NVarchar2(25) := '';
        V_PHONENOLOCALCODE      NVarchar2(20) := '';
        V_PHONENOCITYCODE       NVarchar2(20) := '';
        V_PHONENOCOUNTRYCODE    NVarchar2(20) := '';
        V_WORKEXTENSION         NVarchar2(30) := '';
        V_EMAIL                 NVarchar2(50) := '';
        V_EMAILPALM             NVarchar2(50) := '';
        V_URL                   NVarchar2(150) := '';
        V_PHONE_PREFERREDFLAG   CHAR(1) := '';
        V_EMAIL_PREFERREDFLAG   CHAR(1) := '';
        V_Start_Date            DATE := '';
        V_End_Date              DATE := '';
        V_USERFIELD1            NVarchar2(200) := '';
        V_USERFIELD2            NVarchar2(200) := '';
        V_USERFIELD3            NVarchar2(200) := '';
        V_DATE1                 DATE := '';
        V_DATE2                 DATE := '';
        V_DATE3                 DATE := '';
        V_BANK_ID               NVarchar2(8) := '';
        V_INDCLIENT_TEL_RES     NVARCHAR2(15) := '';
        V_INDCLIENT_TEL_OFF     NVARCHAR2(15) := '';
        V_INDCLIENT_TEL_OFF1    NVARCHAR2(15) := '';
        V_INDCLIENT_EXTN_NUM    NVARCHAR2(5) := '';
        V_INDCLIENT_TEL_FAX     NVARCHAR2(15) := '';
        V_INDCLIENT_TEL_GSM     NVARCHAR2(15) := '';
        V_INDCLIENT_EMAIL_ADDR1 NVARCHAR2(65) := '';
        V_INDCLIENT_EMAIL_ADDR2 NVARCHAR2(65) := '';
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

        CURSOR C1(CurSolId varchar2) IS
        SELECT CIF_ID FROM VALID_CIF WHERE SOL_ID = CurSolId AND CIF_TYPE = 'R';

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
                V_ORGKEY := I.CIF_ID;

                V_PREFERRED_ALLOCATED := 'N';

                V_PHONE_PREFERREDFLAG := 'N';
                V_EMAIL_PREFERREDFLAG := 'N';

                BEGIN
                    SELECT  TRIM(INDCLIENT_TEL_RES)
                            ,TRIM(INDCLIENT_TEL_OFF)
                            ,TRIM(INDCLIENT_TEL_OFF1)
                            ,TRIM(INDCLIENT_EXTN_NUM)
                            ,TRIM(INDCLIENT_TEL_FAX)
                            ,TRIM(INDCLIENT_TEL_GSM)
                            ,TRIM(INDCLIENT_EMAIL_ADDR1)
                            ,TRIM(INDCLIENT_EMAIL_ADDR2)
                    INTO    V_INDCLIENT_TEL_RES
                            ,V_INDCLIENT_TEL_OFF
                            ,V_INDCLIENT_TEL_OFF1
                            ,V_INDCLIENT_EXTN_NUM
                            ,V_INDCLIENT_TEL_FAX
                            ,V_INDCLIENT_TEL_GSM
                            ,V_INDCLIENT_EMAIL_ADDR1
                            ,V_INDCLIENT_EMAIL_ADDR2
                    FROM    CBS.INDCLIENTS
                    WHERE   INDCLIENT_CODE = I.CIF_ID;
                END;

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

                IF(V_INDCLIENT_EMAIL_ADDR1 IS NOT NULL) THEN
                --{
                    V_EMAIL_PREFERREDFLAG := 'Y';

                    INSERT INTO RC006
                    (ORGKEY,PHONEEMAILTYPE,PHONEOREMAIL,EMAIL,PREFERREDFLAG,BANK_ID,SOL_ID)
                    VALUES (V_ORGKEY,V_EMAIL_TYPE,'EMAIL',V_INDCLIENT_EMAIL_ADDR1,V_EMAIL_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;

                IF(V_INDCLIENT_EMAIL_ADDR2 IS NOT NULL) THEN
                --{
                    IF (V_EMAIL_PREFERREDFLAG = 'Y') THEN
                    --{
                        V_EMAIL_PREFERREDFLAG := 'N';
                    --}
                    ELSE
                    --{
                        V_EMAIL_PREFERREDFLAG := 'Y';
                    --}
                    END IF;
                    INSERT INTO RC006
                    (ORGKEY,PHONEEMAILTYPE,PHONEOREMAIL,EMAIL,PREFERREDFLAG,BANK_ID,SOL_ID)
                    VALUES (V_ORGKEY,V_EMAIL_TYPE,'EMAIL',V_INDCLIENT_EMAIL_ADDR1,V_EMAIL_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;

                IF(CommonExtractionPack.CheckNumber(V_CELLPH_NUMBER) != 'N') THEN
                --{
                    V_PHONE_PREFERREDFLAG := 'Y';
                    V_PREFERRED_ALLOCATED := 'Y';

                    INSERT INTO RC006
                    (ORGKEY ,PHONEEMAILTYPE ,PHONEOREMAIL ,PHONE_NO ,PHONENOLOCALCODE ,PHONENOCITYCODE ,PHONENOCOUNTRYCODE ,WORKEXTENSION ,PREFERREDFLAG ,BANK_ID,SOL_ID)
                    VALUES (V_ORGKEY,V_PHONE_CELLPH_TYPE,'PHONE',V_CELLPH_CNTRY_CODE||V_CELLPH_NUMBER,V_CELLPH_NUMBER,null,V_CELLPH_CNTRY_CODE,null,V_PHONE_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;

                IF(CommonExtractionPack.CheckNumber(V_INDCLIENT_TEL_GSM) != 'N') THEN
                --{
                    IF(NVL(V_CELLPH_NUMBER,'NN') != V_INDCLIENT_TEL_GSM) THEN
                    --{
                        IF(V_PREFERRED_ALLOCATED = 'N') THEN
                        --{
                            V_PHONE_PREFERREDFLAG := 'Y';
                            V_PREFERRED_ALLOCATED := 'Y';
                        --}
                        ELSE
                        --{
                            V_PHONE_PREFERREDFLAG := 'N';
                        --}
                        END IF;

                        V_CELLPH_CNTRY_CODE := '91';

                        INSERT INTO RC006
                        (ORGKEY ,PHONEEMAILTYPE ,PHONEOREMAIL ,PHONE_NO ,PHONENOLOCALCODE ,PHONENOCITYCODE ,PHONENOCOUNTRYCODE ,WORKEXTENSION ,PREFERREDFLAG ,BANK_ID,SOL_ID)
                        VALUES (V_ORGKEY,V_PHONE_CELLPH_TYPE1,'PHONE',V_CELLPH_CNTRY_CODE||V_INDCLIENT_TEL_GSM,V_INDCLIENT_TEL_GSM,null,V_CELLPH_CNTRY_CODE,null,V_PHONE_PREFERREDFLAG,V_BANK_ID,InpSolId);
                    --}
                    END IF;
                --}
                END IF;

                IF(CommonExtractionPack.CheckNumber(V_INDCLIENT_TEL_RES) != 'N') THEN
                --{
                    IF(V_PREFERRED_ALLOCATED = 'N') THEN
                    --{
                        V_PHONE_PREFERREDFLAG := 'Y';
                        V_PREFERRED_ALLOCATED := 'Y';
                    --}
                    ELSE
                    --{
                        V_PHONE_PREFERREDFLAG := 'N';
                    --}
                    END IF;

                    INSERT INTO RC006
                    (ORGKEY ,PHONEEMAILTYPE ,PHONEOREMAIL ,PHONE_NO ,PHONENOLOCALCODE ,PHONENOCITYCODE ,PHONENOCOUNTRYCODE ,WORKEXTENSION ,PREFERREDFLAG ,BANK_ID,SOL_ID)
                    VALUES (V_ORGKEY,V_PHONE_RES_TYPE,'PHONE',V_INDCLIENT_TEL_RES,V_INDCLIENT_TEL_RES,null,null,null,V_PHONE_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;

                IF(CommonExtractionPack.CheckNumber(V_INDCLIENT_TEL_OFF) != 'N') THEN
                --{
                    IF(V_PREFERRED_ALLOCATED = 'N') THEN
                    --{
                        V_PHONE_PREFERREDFLAG := 'Y';
                        V_PREFERRED_ALLOCATED := 'Y';
                    --}
                    ELSE
                    --{
                        V_PHONE_PREFERREDFLAG := 'N';
                    --}
                    END IF;

                    INSERT INTO RC006
                    (ORGKEY ,PHONEEMAILTYPE ,PHONEOREMAIL ,PHONE_NO ,PHONENOLOCALCODE ,PHONENOCITYCODE ,PHONENOCOUNTRYCODE ,WORKEXTENSION ,PREFERREDFLAG ,BANK_ID,SOL_ID)
                    VALUES (V_ORGKEY,V_PHONE_WORK_TYPE,'PHONE',V_INDCLIENT_TEL_OFF,V_INDCLIENT_TEL_OFF,null,null,V_INDCLIENT_EXTN_NUM,V_PHONE_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;

                IF(CommonExtractionPack.CheckNumber(V_INDCLIENT_TEL_OFF1) != 'N') THEN
                --{
                    IF(V_PREFERRED_ALLOCATED = 'N') THEN
                    --{
                        V_PHONE_PREFERREDFLAG := 'Y';
                        V_PREFERRED_ALLOCATED := 'Y';
                    --}
                    ELSE
                    --{
                        V_PHONE_PREFERREDFLAG := 'N';
                    --}
                    END IF;

                    INSERT INTO RC006
                    (ORGKEY ,PHONEEMAILTYPE ,PHONEOREMAIL ,PHONE_NO ,PHONENOLOCALCODE ,PHONENOCITYCODE ,PHONENOCOUNTRYCODE ,WORKEXTENSION ,PREFERREDFLAG ,BANK_ID,SOL_ID)
                    VALUES (V_ORGKEY,V_PHONE_WORK_TYPE1,'PHONE',V_INDCLIENT_TEL_OFF1,V_INDCLIENT_TEL_OFF1,null,null,V_INDCLIENT_EXTN_NUM,V_PHONE_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;

                IF(CommonExtractionPack.CheckNumber(V_INDCLIENT_TEL_FAX) != 'N') THEN
                --{
                    IF(V_PREFERRED_ALLOCATED = 'N') THEN
                    --{
                        V_PHONE_PREFERREDFLAG := 'Y';
                        V_PREFERRED_ALLOCATED := 'Y';
                    --}
                    ELSE
                    --{
                        V_PHONE_PREFERREDFLAG := 'N';
                    --}
                    END IF;

                    INSERT INTO RC006
                    (ORGKEY ,PHONEEMAILTYPE ,PHONEOREMAIL ,PHONE_NO ,PHONENOLOCALCODE ,PHONENOCITYCODE ,PHONENOCOUNTRYCODE ,WORKEXTENSION ,PREFERREDFLAG ,BANK_ID,SOL_ID)
                    VALUES (V_ORGKEY,V_PHONE_FAX_TYPE,'PHONE',V_INDCLIENT_TEL_FAX,V_INDCLIENT_TEL_FAX,null,null,null,V_PHONE_PREFERREDFLAG,V_BANK_ID,InpSolId);
                --}
                END IF;

            --}
            END LOOP;
        --}
        END RC006;
    --} Procudre RC006 End

    PROCEDURE RC008 (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT
            ORGKEY
            ,DECODE(MARITAL_STATUS_CODE,'N','M','U','M','P','D','O','D',MARITAL_STATUS_CODE) MARITAL_STATUS_CODE
            ,EMPLOYMENT_STATUS
            ,NATIONALITY_CODE
            ,CUSTCASTE
            ,ANNUAL_SALARY_INCOME
            ,CASE DECODE(MARITAL_STATUS_CODE,'N','M','U','M','P','D','O','D',MARITAL_STATUS_CODE)
                WHEN 'M' THEN 'Married'
                WHEN 'W' THEN 'Widow/Widower'
                WHEN 'O' THEN 'Others'
                WHEN 'N' THEN 'Unmarried'
                WHEN 'S' THEN 'Single'
                WHEN 'U' THEN 'Unmarried'
                WHEN 'D' THEN 'Divorsed'
            END MARITAL_STATUS
        FROM
            RET_VALID_CIF A
        WHERE 
            SOL_ID = InpSolId;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC008%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE MapperType IS TABLE OF VARCHAR2(80) INDEX BY VARCHAR2(200);
        TYPE CatType IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);

        CurRec          CurType;
        TableRec        TableType;
        mapper          MapperType;
        v_key           VARCHAR2(200);
        V_BatchSize     CONSTANT PLS_INTEGER := 10000;
        V_DOCCODETYPE   NVARCHAR2(50) := '';

        BEGIN
        --{
            FOR rec IN (SELECT * FROM mapper_table) LOOP
                mapper(rec.field_type || '|' || rec.old_value || '|' || rec.source_system) := rec.new_value;
            END LOOP;

            OPEN C1;
            loop
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;
            
                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).BANK_ID := '01';
                    TableRec(i).SOL_ID  := InpSolId;

                    v_key := 'EMPLOYMENT_STATUS|'||CurRec(i).EMPLOYMENT_STATUS||'|CBS';
                    IF(mapper.EXISTS(v_key)) THEN
                        TableRec(i).EMPLOYMENT_STATUS := mapper(v_key);
                    END IF;

                    v_key := 'CUSTCASTE|'||CurRec(i).CUSTCASTE||'|CBS';
                    IF(mapper.EXISTS(v_key)) THEN
                        TableRec(i).CUSTCASTE := mapper(v_key);
                    END IF;

                    TableRec(i).MARITAL_STATUS_CODE := CurRec(i).MARITAL_STATUS_CODE;
                    TableRec(i).NATIONALITY         := CurRec(i).NATIONALITY_CODE;
                    TableRec(i).MARITAL_STATUS      := CurRec(i).MARITAL_STATUS;
                    TableRec(i).ANNUAL_SALARY_INCOME := CurRec(i).ANNUAL_SALARY_INCOME;

                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC008 VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            close c1;
        --}
        END RC008;
    --} Procudre RC008 End

    PROCEDURE RC009 (InpSolId IN VARCHAR2) IS
    --{
        V_ORGKEY						NVarchar2(50) := '';
        V_COMMUNICATION_LANGUAGE        NVarchar2(50) := '';
        V_PREFERRED_ADDRESS_MODE        NVarchar2(50) := '';
        V_BEHAVIOURAL_SCORE             NVarchar2(100) := '';
        V_RISK_BEHAVIOUR                NVarchar2(100) := '';
        V_OTHER_BEHAVIOURAL_PROFILE     NVarchar2(100) := '';
        V_LIFE_CYCLE_STAGE              NVarchar2(100) := '';
        V_SERVICE_PERSONALISE           NVarchar2(200) := '';
        V_PSYCHOGRAPHICTYPE             NVarchar2(50) := '';
        V_PRIORITY_IDENTIFIER           NVarchar2(25) := '';
        V_HOUSEHOLD_NUMBER              NVarchar2(10) := '';
        V_PREFERRED_REP                 Numeric(38) := '';
        V_SEGMENTATION_CLASS            NVarchar2(100) := '';
        V_PREFERREDNAME                 NVarchar2(50) := '';
        V_NUMBEROFDEPENDANTS            Numeric(38) := '';
        V_NUMBEROFDEPENDANTCHILDREN     Numeric(38) := '';
        V_STMTDATEFORCOMBSTMT           Date := '';
        V_SUBSEGMENT                    NVarchar2(50) := '';
        V_HOBBYFIELD1                   NVarchar2(50) := '';
        V_HOBBYFIELD2                   NVarchar2(50) := '';
        V_HOBBYFIELD3                   NVarchar2(50) := '';
        V_HOBBYFIELD4                   NVarchar2(50) := '';
        V_HOBBYFIELD5                   NVarchar2(50) := '';
        V_HOBBYFIELD6                   NVarchar2(50) := '';
        V_PROFILE_FIELD1                NVarchar2(200) := '';
        V_PROFILE_FIELD2                NVarchar2(200) := '';
        V_PROFILE_FIELD3                NVarchar2(200) := '';
        V_PROFILE_FIELD4                NVarchar2(200) := '';
        V_ALERT1                        NVarchar2(100) := '';
        V_ALERT2                        NVarchar2(100) := '';
        V_ALERT3                        NVarchar2(100) := '';
        V_ALERT4                        NVarchar2(100) := '';
        V_ALERT5                        NVarchar2(100) := '';
        V_FLAG1                         NVarchar2(5) := '';
        V_FLAG2                         NVarchar2(5) := '';
        V_FLAG3                         NVarchar2(5) := '';
        V_FLAG4                         NVarchar2(5) := '';
        V_FLAG5                         NVarchar2(5) := '';
        V_BANK_DEFINED_PREFER_VAR1      NVarchar2(20) := '';
        V_BANK_DEFINED_PREFER_VAR2      NVarchar2(20) := '';
        V_BANK_DEFINED_PREFER_VAR3      NVarchar2(20) := '';
        V_BANK_DEFINED_PREFER_DATE1     Date := '';
        V_BANK_DEFINED_PREFER_DATE2     Date := '';
        V_BANK_DEFINED_PREFER_DATE3     Date := '';
        V_USERFIELD1                    NVarchar2(50) := '';
        V_USERFIELD2                    NVarchar2(50) := '';
        V_USERFIELD3                    NVarchar2(50) := '';
        V_USERFIELD4                    NVarchar2(50) := '';
        V_USERFIELD5                    NVarchar2(50) := '';
        V_USERFIELD6                    NVarchar2(50) := '';
        V_SPSERVICEREQUIRED1            NVarchar2(25) := '';
        V_SPSERVICEREQUIRED2            NVarchar2(25) := '';
        V_SPSERVICEREQUIRED3            NVarchar2(25) := '';
        V_SPSERVICEREQUIRED4            NVarchar2(25) := '';
        V_SPSERVICEREQUIRED5            NVarchar2(25) := '';
        V_USERFLAG1                     NVarchar2(1) := '';
        V_USERFLAG2                     NVarchar2(1) := '';
        V_PREFRELSHIPDISCOUNT1          Numeric(20) := '';
        V_PREFRELSHIPDISCOUNT2          Numeric(20) := '';
        V_PREFRELSHIPDISCOUNTPERCENT1   Numeric(9) := '';
        V_PREFRELSHIPDISCOUNTPERCENT2   Numeric(9) := '';
        V_USERFIELD7                    NVarchar2(50) := '';
        V_USERFIELD8                    NVarchar2(50) := '';
        V_USERFIELD9                    NVarchar2(50) := '';
        V_USERFIELD10                   NVarchar2(50) := '';
        V_USERFIELD11                   NVarchar2(50) := '';
        V_USERFIELD12                   NVarchar2(50) := '';
        V_USERFIELD13                   NVarchar2(50) := '';
        V_AMOUNT1                       Numeric(20) := '';
        V_AMOUNT2                       Numeric(20) := '';
        V_AMOUNT3                       Numeric(20) := '';
        V_AMOUNT4                       Numeric(20) := '';
        V_AMOUNT5                       Numeric(20) := '';
        V_AMOUNT6                       Numeric(20) := '';
        V_AMOUNT7                       Numeric(20) := '';
        V_INTFIELD1                     Numeric(38) := '';
        V_INTFIELD2                     Numeric(38) := '';
        V_INTFIELD3                     Numeric(38) := '';
        V_INTFIELD4                     Numeric(38) := '';
        V_INTFIELD5                     Numeric(38) := '';
        V_STATEMENTTYPE                 NVarchar2(5) := '';
        V_STATEMENTFREQUENCY            NVarchar2(5) := '';
        V_STMTDATEWEEKDAY               Numeric(1) := '';
        V_STMTMONTHLYSTARTDATE          Numeric(2) := '';
        V_ACTIONDURINGHOLIDAY           NVarchar2(10) := '';
        V_DESPATCHMODE                  NVarchar2(5) := '';
        V_CALENDERTYPE                  NVarchar2(5) := '';
        V_DISCOUNTAVAILED               NVarchar2(1) := '';
        V_DISCOUNTTYPE                  NVarchar2(5) := '';
        V_PREFEFFECTIVEDATE             Date := '';
        V_PREFEXPIRYDATE                Date := '';
        V_LASTCONTACTEDDATE             Date := '';
        V_LASTCONTACTEDCHANNEL          NVarchar2(20) := '';
        V_FAMILYTYPE                    NVarchar2(50) := '';
        V_NOOFEARNERS                   Numeric(2) := '';
        V_REMARKS                       NVarchar2(50) := '';
        V_COMMUNITY                     NVarchar2(50) := '';
        V_LTVINDICATOR                  NVarchar2(5) := '';
        V_ASSETCLASSIFICATION           NVarchar2(5) := '';
        V_ASSETCLASSIFICATIONDESC       NVarchar2(50) := '';
        V_ASSETCLASSIFIEDON             Date := '';
        V_CUSTHEALTHCODE                NVarchar2(5) := '';
        V_CREDITDISCOUNTPERCENT         Numeric(9) := '';
        V_DEBITDISCOUNTPERCENT          Numeric(9) := '';
        V_PREFERRENTIALEXPIRYDATE       Date := '';
        V_INTERESTDESCRIPTION           NVarchar2(20) := '';
        V_STMTWEEKOFMONTH               NVarchar2(1) := '';
        V_CUSTCHARGECODE                NVarchar2(5) := '';
        V_CUSTCHARGE                    NVarchar2(50) := '';
        V_CHARGEDEBITFORACID            NVarchar2(16) := '';
        V_CHARGEDEBITSOLID              NVarchar2(8) := '';
        V_CHARGEHISTORYFLAG             NVarchar2(1) := '';
        V_CUSTOMERCURRENCY              NVarchar2(3) := '';
        V_LOANSSTATEMENTTYPE            NVarchar2(1) := '';
        V_TDSSTATEMENTTYPE              NVarchar2(1) := '';
        V_COMBSTMTCHARGECODE            NVarchar2(5) := '';
        V_TDSCUSTFLOORLIMIT             Numeric(20) := '';
        V_COMMUNITY_CODE                NVarchar2(5) := '';
        V_CUST_HEALTH_REF_CODE          NVarchar2(5) := '';
        V_CUST_PREF_TILL_DATE           Date := '';
        V_CU_TDSCUSTFLOORLIMIT          NVarchar2(3) := '';
        V_CHECKSUM                      NVarchar2(100) := '';
        V_PREFERRED_LOCALE              NVarchar2(50) := '';
        V_BANK_ID                       NVarchar2(8) := '';
        V_EXT_SYS_PRICING               NVarchar2(50) := '';
        V_PRICING_EFFECTIVE_DATE        Date := '';
        V_PRICING_REVIEW_DATE           Date := '';
        V_RELATIONSHIP_PRICING_ID       NVarchar2(30) := '';
        V_NATURE_OF_ACT                 NVARCHAR2(50) := '';
        V_PSYCHOGRAPHICID               NUMERIC(38) := '';

        CURSOR C1(CurSolId varchar2) IS
        SELECT CIF_ID FROM VALID_CIF WHERE SOL_ID = CurSolId AND CIF_TYPE = 'R';

        BEGIN
        --{
            V_BANK_ID := '01';
            V_PREFERRED_LOCALE := 'en_US';

            FOR I IN C1(InpSolId)
            LOOP
            --{
                V_ORGKEY := I.CIF_ID;

                BEGIN
                    SELECT  SUBSTR(CLIENTS_NAME,0,50)
                    INTO    V_PREFERREDNAME
                    FROM    CBS.CLIENTS
                    WHERE   CLIENTS_CODE = I.CIF_ID;
                END;

                V_PREFERREDNAME := CommonExtractionPack.RemoveSpecialChars(V_PREFERREDNAME);

                INSERT INTO RC009 VALUES
                (
                    V_ORGKEY,
                    V_COMMUNICATION_LANGUAGE,
                    V_PREFERRED_ADDRESS_MODE,
                    V_BEHAVIOURAL_SCORE,
                    V_RISK_BEHAVIOUR,
                    V_OTHER_BEHAVIOURAL_PROFILE,
                    V_LIFE_CYCLE_STAGE,
                    V_SERVICE_PERSONALISE,
                    V_PSYCHOGRAPHICTYPE,
                    V_PRIORITY_IDENTIFIER,
                    V_HOUSEHOLD_NUMBER,
                    V_PREFERRED_REP,
                    V_SEGMENTATION_CLASS,
                    V_PREFERREDNAME,
                    V_NUMBEROFDEPENDANTS,
                    V_NUMBEROFDEPENDANTCHILDREN,
                    V_STMTDATEFORCOMBSTMT,
                    V_SUBSEGMENT,
                    V_HOBBYFIELD1,
                    V_HOBBYFIELD2,
                    V_HOBBYFIELD3,
                    V_HOBBYFIELD4,
                    V_HOBBYFIELD5,
                    V_HOBBYFIELD6,
                    V_PROFILE_FIELD1,
                    V_PROFILE_FIELD2,
                    V_PROFILE_FIELD3,
                    V_PROFILE_FIELD4,
                    V_ALERT1,
                    V_ALERT2,
                    V_ALERT3,
                    V_ALERT4,
                    V_ALERT5,
                    V_FLAG1,
                    V_FLAG2,
                    V_FLAG3,
                    V_FLAG4,
                    V_FLAG5,
                    V_BANK_DEFINED_PREFER_VAR1,
                    V_BANK_DEFINED_PREFER_VAR2,
                    V_BANK_DEFINED_PREFER_VAR3,
                    V_BANK_DEFINED_PREFER_DATE1,
                    V_BANK_DEFINED_PREFER_DATE2,
                    V_BANK_DEFINED_PREFER_DATE3,
                    V_USERFIELD1,
                    V_USERFIELD2,
                    V_USERFIELD3,
                    V_USERFIELD4,
                    V_USERFIELD5,
                    V_USERFIELD6,
                    V_SPSERVICEREQUIRED1,
                    V_SPSERVICEREQUIRED2,
                    V_SPSERVICEREQUIRED3,
                    V_SPSERVICEREQUIRED4,
                    V_SPSERVICEREQUIRED5,
                    V_USERFLAG1,
                    V_USERFLAG2,
                    V_PREFRELSHIPDISCOUNT1,
                    V_PREFRELSHIPDISCOUNT2,
                    V_PREFRELSHIPDISCOUNTPERCENT1,
                    V_PREFRELSHIPDISCOUNTPERCENT2,
                    V_USERFIELD7,
                    V_USERFIELD8,
                    V_USERFIELD9,
                    V_USERFIELD10,
                    V_USERFIELD11,
                    V_USERFIELD12,
                    V_USERFIELD13,
                    V_AMOUNT1,
                    V_AMOUNT2,
                    V_AMOUNT3,
                    V_AMOUNT4,
                    V_AMOUNT5,
                    V_AMOUNT6,
                    V_AMOUNT7,
                    V_INTFIELD1,
                    V_INTFIELD2,
                    V_INTFIELD3,
                    V_INTFIELD4,
                    V_INTFIELD5,
                    V_STATEMENTTYPE,
                    V_STATEMENTFREQUENCY,
                    V_STMTDATEWEEKDAY,
                    V_STMTMONTHLYSTARTDATE,
                    V_ACTIONDURINGHOLIDAY,
                    V_DESPATCHMODE,
                    V_CALENDERTYPE,
                    V_DISCOUNTAVAILED,
                    V_DISCOUNTTYPE,
                    V_PREFEFFECTIVEDATE,
                    V_PREFEXPIRYDATE,
                    V_LASTCONTACTEDDATE,
                    V_LASTCONTACTEDCHANNEL,
                    V_FAMILYTYPE,
                    V_NOOFEARNERS,
                    V_REMARKS,
                    V_COMMUNITY,
                    V_LTVINDICATOR,
                    V_ASSETCLASSIFICATION,
                    V_ASSETCLASSIFICATIONDESC,
                    V_ASSETCLASSIFIEDON,
                    V_CUSTHEALTHCODE,
                    V_CREDITDISCOUNTPERCENT,
                    V_DEBITDISCOUNTPERCENT,
                    V_PREFERRENTIALEXPIRYDATE,
                    V_INTERESTDESCRIPTION,
                    V_STMTWEEKOFMONTH,
                    V_CUSTCHARGECODE,
                    V_CUSTCHARGE,
                    V_CHARGEDEBITFORACID,
                    V_CHARGEDEBITSOLID,
                    V_CHARGEHISTORYFLAG,
                    V_CUSTOMERCURRENCY,
                    V_LOANSSTATEMENTTYPE,
                    V_TDSSTATEMENTTYPE,
                    V_COMBSTMTCHARGECODE,
                    V_TDSCUSTFLOORLIMIT,
                    V_COMMUNITY_CODE,
                    V_CUST_HEALTH_REF_CODE,
                    V_CUST_PREF_TILL_DATE,
                    V_CU_TDSCUSTFLOORLIMIT,
                    V_CHECKSUM,
                    V_PREFERRED_LOCALE,
                    V_BANK_ID,
                    V_EXT_SYS_PRICING,
                    V_PRICING_EFFECTIVE_DATE,
                    V_PRICING_REVIEW_DATE,
                    V_RELATIONSHIP_PRICING_ID,
                    V_NATURE_OF_ACT,
                    V_PSYCHOGRAPHICID,
                    InpSolId
                );
            --}
            END LOOP;
        --}
        END RC009;
    --} Procudre RC009 End

    PROCEDURE RC001_PGK (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT 
            PGK_CLIENT ORGKEY
        FROM 
            CBS.PGKSTATUS 
        WHERE 
            PGK_LINKED_TO_CUST_BY IS NULL 
        AND PGK_BRANCH = InpSolId
        AND PGK_ENTITY = 1;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC001%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE MapperType IS TABLE OF VARCHAR2(80) INDEX BY VARCHAR2(200);
        TYPE CatType IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);

        CurRec      CurType;
        TableRec    TableType;
        mapper      MapperType;
        pidmapper   MapperType;
        mappertds   MapperType;
        v_key       VARCHAR2(200);
        V_BatchSize CONSTANT PLS_INTEGER := 10000;

        BEGIN
        --{
            OPEN C1;
            loop
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;
            
                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).ENTITYTYPE := 'CUSTOMER';
                    --TableRec(i).DOCUMENT_RECIEVED := 'Y';
                    --TableRec(i).CRNCY_CODE_RETAIL := 'INR';
                    --TableRec(i).CUST_CHRG_HISTORY_FLG := 'N';
                    --TableRec(i).COMBINED_STMT_REQD := 'N';
                    --TableRec(i).DESPATCH_MODE := 'N';
                    TableRec(i).BANK_ID := '01';
                    --TableRec(i).ISEBANKINGENABLED := 'N';
                    TableRec(i).PURGEFLAG := 'N';
                    --TableRec(i).REGION := 'MIG';
                    --TableRec(i).Sector := 'MIG';
                    --TableRec(i).SubSector := 'MIG';
                    --TableRec(i).SEGMENTATION_CLASS := 'Retail';
                    --TableRec(i).SUBSEGMENT := 'Retail';
                    TableRec(i).TFPARTYFLAG := 'N';
                    --TableRec(i).ALLOW_SWEEPS := 'N';
                    --TableRec(i).NativeLangCode := 'INFENG';
                    --TableRec(i).CUST_LANGUAGE := 'INFENG';
                    TableRec(i).CUSTOMERMINOR := 'N';

                    TableRec(i).ORGKEY  := CurRec(i).ORGKEY;
                    TableRec(i).CIF_ID  := CurRec(i).ORGKEY;
                    TableRec(i).SOL_ID  := InpSolId;

                    --TableRec(i).CUST_FIRST_NAME := 'CUSTFIRSTNAME';
                    TableRec(i).CUST_LAST_NAME  := 'CUSTLASTNAME';
                    TableRec(i).PREFERREDNAME   := 'PREFERREDNAME';
                    TableRec(i).SHORT_NAME      := 'SHORTNAME';

                    TableRec(i).CUST_DOB                := TO_DATE('01-01-1950','DD-MM-YYYY');
                    TableRec(i).GENDER                  := 'M';
                    --TableRec(i).NATIONALITY_CODE        := 'IN';
                    TableRec(i).STAFFFLAG               := 'N';
                    TableRec(i).CUSTOMERNREFLAG         := 'N';
                    TableRec(i).CORE_CUST_ID            := CurRec(i).ORGKEY;
                    TableRec(i).SALUTATION_CODE         := 'MR.';
                    TableRec(i).PRIMARY_SERVICE_CENTRE  := InpSolId;
                    TableRec(i).PRIMARY_SOL_ID          := InpSolId;
                    TableRec(i).RELATIONSHIPOPENINGDATE := TO_DATE('01-01-1950','DD-MM-YYYY');
                    --TableRec(i).MANAGER                 := NVL(CurRec(i).MANAGER,'UBSADMIN');
                    --TableRec(i).FOREIGNACCtAXREPORTINGREQ := 'N';
                    --TableRec(i).TDS_TBL_CODE := 'GEN10';
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC001_PGK VALUES TableRec(i);

                commit;

                TableRec.delete;
                
            --}
            END LOOP;
            close c1;
        --}
        END RC001_PGK;
    --} Procuder RC001_PGK End

    PROCEDURE RC002_PGK (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT 
            PGK_CLIENT ORGKEY
            ,PGK_REQ_ON START_DATE
        FROM 
            CBS.PGKSTATUS 
        WHERE 
            PGK_LINKED_TO_CUST_BY IS NULL 
        AND PGK_BRANCH = InpSolId
        AND PGK_ENTITY = 1;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC002%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE MapperType IS TABLE OF VARCHAR2(80) INDEX BY VARCHAR2(200);
        TYPE CatType IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(100);

        CurRec      CurType;
        TableRec    TableType;
        mapper      MapperType;
        locmapper   MapperType;
        V_BatchSize CONSTANT PLS_INTEGER := 10000;
        comma_pos   PLS_INTEGER;

        V_ADDRESS       VARCHAR2(350);
        V_StateCntry    VARCHAR2(350);

        BEGIN
        --{
            OPEN C1;
            LOOP
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;

                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).BANK_ID     := '01';
                    TableRec(i).SOL_ID      := InpSolId;

                    TableRec(i).ORGKEY      := CurRec(i).ORGKEY;

                    TableRec(i).HOUSE_NO        := 'MIG';
                    TableRec(i).PREMISE_NAME    := 'MIG';
                    --TableRec(i).STREET_NO       := 'MIG';
                    TableRec(i).BUILDING_LEVEL  := 'MIG';
                    --TableRec(i).STREET_NAME     := 'MIG';
                    TableRec(i).PreferredFormat := 'STRUCTURED_FORMAT';
                    --TableRec(i).CITY_CODE       := 'MIG';
                    --TableRec(i).STATE_CODE      := 'MIG';
                    --TableRec(i).COUNTRY_CODE    := 'IN';
                    --TableRec(i).ZIP             := '999999';
                    TableRec(i).START_DATE      := CurRec(i).START_DATE;
                    TableRec(i).END_DATE        := TO_DATE('31-12-2099','DD-MM-YYYY');

                    TableRec(i).ADDRESSCATEGORY := 'Mailing';
                    TableRec(i).PREFERREDADDRESS := 'Y';
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC002_PGK VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            CLOSE C1;
        --}
        END RC002_PGK;
    --} Procudre RC002 End

    PROCEDURE RC003_PGK (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT 
            PGK_CLIENT ORGKEY
            ,PGK_REQ_ON Currency
        FROM 
            CBS.PGKSTATUS 
        WHERE 
            PGK_LINKED_TO_CUST_BY IS NULL 
        AND PGK_BRANCH = InpSolId
        AND PGK_ENTITY = 1;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC003%ROWTYPE INDEX BY PLS_INTEGER;

        CurRec      CurType;
        TableRec    TableType;
        V_BatchSize CONSTANT PLS_INTEGER := 10000;

        BEGIN
        --{
            OPEN C1;
            LOOP
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;

                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).SOL_ID := InpSolId;
                    TableRec(i).ORGKEY := CurRec(i).ORGKEY;
                    TableRec(i).BANK_ID := '01';
                    TableRec(i).TYPE := 'CURRENCY';
                    TableRec(i).CUSTOMERCURRENCY := CurRec(i).Currency;
                    TableRec(i).STRTEXT10 := CurRec(i).Currency;
                    TableRec(i).DBFLOAT1 := 0;
                    TableRec(i).DBFLOAT2 := 0;
                    TableRec(i).DBFLOAT3 := 0;
                    TableRec(i).DBFLOAT4 := 0;
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC003_PGK VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            CLOSE C1;
        --}
        END RC003_PGK;
    --} Procudre RC003_PGK End

    PROCEDURE RC008_PGK (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT 
            PGK_CLIENT ORGKEY
        FROM 
            CBS.PGKSTATUS 
        WHERE 
            PGK_LINKED_TO_CUST_BY IS NULL 
        AND PGK_BRANCH = InpSolId
        AND PGK_ENTITY = 1;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC008%ROWTYPE INDEX BY PLS_INTEGER;

        CurRec      CurType;
        TableRec    TableType;
        V_BatchSize CONSTANT PLS_INTEGER := 10000;

        BEGIN
        --{
            OPEN C1;
            LOOP
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;

                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).SOL_ID := InpSolId;
                    TableRec(i).ORGKEY := CurRec(i).ORGKEY;
                    TableRec(i).BANK_ID := '01';
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC008_PGK VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            CLOSE C1;
        --}
        END RC008_PGK;
    --} Procudre RC008_PGK End

    PROCEDURE RC009_PGK (InpSolId IN VARCHAR2) IS
    --{
        cursor c1 is 
        SELECT 
            PGK_CLIENT ORGKEY
        FROM 
            CBS.PGKSTATUS 
        WHERE 
            PGK_LINKED_TO_CUST_BY IS NULL 
        AND PGK_BRANCH = InpSolId
        AND PGK_ENTITY = 1;

        TYPE CurType IS TABLE OF C1%ROWTYPE INDEX BY PLS_INTEGER;
        TYPE TableType IS TABLE OF MOCKSTG.RC009%ROWTYPE INDEX BY PLS_INTEGER;

        CurRec      CurType;
        TableRec    TableType;
        V_BatchSize CONSTANT PLS_INTEGER := 10000;

        BEGIN
        --{
            OPEN C1;
            LOOP
            --{
                FETCH C1 BULK COLLECT INTO CurRec LIMIT V_BatchSize;
                EXIT WHEN CurRec.COUNT = 0;

                FOR I IN 1 .. CurRec.COUNT
                LOOP
                --{
                    TableRec(i).SOL_ID := InpSolId;
                    TableRec(i).ORGKEY := CurRec(i).ORGKEY;
                    TableRec(i).CUSTOMERCURRENCY := 'INR';
                    TableRec(i).BANK_ID := '01';
                --}
                END LOOP;

                FORALL i IN INDICES OF TableRec
                    INSERT /*+ APPEND */ INTO RC009_PGK VALUES TableRec(i);

                commit;

                TableRec.delete;
            --}
            END LOOP;
            CLOSE C1;
        --}
        END RC009_PGK;
    --} Procudre RC009_PGK End
--}
END RetailCifPack;
/

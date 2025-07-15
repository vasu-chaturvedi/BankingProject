CREATE OR REPLACE PACKAGE CommonExtractionPack AS
--{
    FUNCTION MAPPER_FUNC (InpMapperType in varchar2, InpFieldType in varchar2, InpOldValue in varchar2, InpSourceSystem in varchar2) return varchar2;
    FUNCTION ValidateCategory(InpStr in varchar2,CategoryType in varchar2) return char;
    FUNCTION location(InpLocType in varchar2,InpLocCode in varchar2) return VARCHAR2;
    FUNCTION CheckNumber(InpStr in varchar2) return char;
    FUNCTION RemoveSpecialChars(InpStr in varchar2) return varchar2;
    FUNCTION GetSchemeMapping (InpType VARCHAR2,InpProdCode VARCHAR2,InpPayFreq VARCHAR2,InpAcSubType VARCHAR2) RETURN scheme_rec;
    FUNCTION GetDepositPeriod(InpOpenDate Date, InpMatDate Date) RETURN tda_dep_period_rec;
--}
END CommonExtractionPack;
/

CREATE OR REPLACE PACKAGE BODY CommonExtractionPack AS
--{
    FUNCTION ValidateCategory(InpStr in varchar2,CategoryType in varchar2) return char IS
    --{
        v_ret_flg			char(1);
    BEGIN
        BEGIN
            SELECT DECODE(COUNT(1),0,'N','Y')
            INTO v_ret_flg
            FROM CATEGORIES
            WHERE TYPE = CategoryType
            AND CODE = InpStr;
        END;

        RETURN v_ret_flg;
    END;

    FUNCTION location(InpLocType in varchar2,InpLocCode in varchar2) return VARCHAR2 IS
    --{
        loc_code    VARCHAR2(10) := null;
    BEGIN
        IF(InpLocType = 'CITYDESC') THEN
        --{
            BEGIN
                SELECT DISTINCT CODE
                INTO loc_code
                FROM CATEGORIES
                WHERE TYPE = 'CITY'
                AND UPPER(CODE_DESC) = UPPER(InpLocCode);
                EXCEPTION WHEN NO_DATA_FOUND THEN
                loc_code := null;
            END;
        --}
        ELSE
        --{
            BEGIN
                SELECT DISTINCT CODE
                INTO loc_code
                FROM CATEGORIES
                WHERE TYPE = InpLocType
                AND CODE = InpLocCode;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                loc_code := null;
            END;
        --}
        END IF;

        RETURN loc_code;
    END;

    FUNCTION RemoveSpecialChars(InpStr in varchar2) return varchar2 is
    --{
        --v_special_chars	varchar2(100) := '[@#$%^&*()_+=]';
        v_special_chars 	VARCHAR2(100) := '[@$%|]';
        v_outStr			VARCHAR2(4000); -- Increased size for longer strings
    BEGIN
        -- Remove special characters using regex
        v_outStr := REGEXP_REPLACE(InpStr, v_special_chars, '');

        -- Remove newline characters explicitly
        v_outStr := REPLACE(v_outStr, CHR(10), ''); -- Line Feed (\n)
        v_outStr := REPLACE(v_outStr, CHR(13), ''); -- Carriage Return (\r)

        RETURN v_outStr;
    END;

    --FUNCTION GetSchemeMapping (InpProdCode VARCHAR2, InpPayFreq VARCHAR2, InpAcSubType VARCHAR2) RETURN tda_scheme_rec IS
    FUNCTION GetSchemeMapping (InpType VARCHAR2,InpProdCode VARCHAR2,InpPayFreq VARCHAR2,InpAcSubType VARCHAR2) return scheme_rec IS
    v_result scheme_rec;
    BEGIN
    --{
        IF (InpType = 'TD') THEN
        --{
            BEGIN
                SELECT scheme_rec(
                FIN_SCHEME_CODE
                ,INT_TBL_CODE
                ,GL_SUB_HEAD_CODE
                ,STAFF_FLG
                )
                INTO v_result
                FROM (
                SELECT FIN_SCHEME_CODE
                ,INT_TBL_CODE
                ,INT_TBL_CODE2
                ,GL_SUB_HEAD_CODE
                ,STAFF_FLG
                -- Match score: max 2
                ,CASE
                WHEN PBDCONT_INT_PAY_FREQ = InpPayFreq THEN 1
                WHEN PBDCONT_INT_PAY_FREQ IS NULL THEN 0
                ELSE -1
                               END +
                CASE
                WHEN ACNTS_AC_SUB_TYPE IS NOT NULL AND ',' || ACNTS_AC_SUB_TYPE || ',' LIKE '%,' || InpAcSubType || ',%' THEN 1
                WHEN ACNTS_AC_SUB_TYPE IS NULL THEN 0
                ELSE -1
                               END AS match_score
                FROM tda_scheme_mapping
                WHERE ACNTS_PROD_CODE = InpProdCode
                )
                WHERE match_score >= 0 -- ignore mismatched rows
                ORDER BY match_score DESC
                FETCH FIRST 1 ROWS ONLY;
                EXCEPTION WHEN no_data_found THEN
                v_result := NULL;
            END;
        --}
        END IF;

        IF (InpType = 'CASA') THEN
        --{
            BEGIN
                SELECT scheme_rec
                (
                    FINACLE_SCHM
                    ,INTEREST_TABLE_CODE
                    ,GL_SUBHEAD_CODE
                    ,STAFF_FLG
                )
                INTO V_RESULT
                FROM 
                (SELECT FINACLE_SCHM,INTEREST_TABLE_CODE,GL_SUBHEAD_CODE,STAFF_FLG
                FROM CASA_PROD_MAP
                WHERE INTELLECT_SCHM = InpProdCode);
                EXCEPTION WHEN NO_DATA_FOUND THEN
                V_RESULT := null;
            END;
        --}
        END IF;
        return v_result;
    --}
    END;

    FUNCTION GetDepositPeriod(InpOpenDate Date, InpMatDate Date) RETURN TDA_DEP_PERIOD_REC IS

    V_MONTHS    varchar2(5);
    V_DAYS      varchar2(3);
    v_temp_date date;

    BEGIN
    --{
        IF((InpMatDate - InpOpenDate) > 364) THEN
        --{
            V_MONTHS := TRUNC(MONTHS_BETWEEN(InpMatDate, InpOpenDate));

            v_temp_date := ADD_MONTHS(InpOpenDate, v_months);

            IF v_temp_date > InpMatDate THEN
                v_months := v_months - 1;
                v_temp_date := ADD_MONTHS(InpOpenDate, v_months);
            END IF;

            V_DAYS := InpMatDate - v_temp_date;
        --}
        ELSE
        --{
            V_MONTHS := 0;
            V_DAYS := (InpMatDate - InpOpenDate);
        --}
        END IF;

        return TDA_DEP_PERIOD_REC(V_MONTHS,V_DAYS);
    --}
    END;

    FUNCTION MAPPER_FUNC (InpMapperType in varchar2, InpFieldType in varchar2, InpOldValue in varchar2, InpSourceSystem in varchar2) return varchar2 is
    v_newvalue varchar2(80);

    BEGIN
    --{

        V_NEWVALUE := NULL;

        IF(InpMapperType = 'DOCCODE') THEN
        --{
            BEGIN
                SELECT 	NEW_VALUE ||','||PID_TYPE
                INTO	V_NEWVALUE
                FROM	PID_MAPPER_TABLE
                WHERE	OLD_VALUE = InpOldValue;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                V_NEWVALUE := NULL;
            END;
        --}
        END IF;

        IF(InpMapperType = 'MASTERCODE') THEN
        --{
            BEGIN
                SELECT 	NEW_VALUE
                INTO	V_NEWVALUE
                FROM	MAPPER_TABLE
                WHERE	FIELD_TYPE = InpFieldType
                AND 	OLD_VALUE = InpOldValue
                AND		SOURCE_SYSTEM = InpSourceSystem;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                V_NEWVALUE := NULL;
            END;
        --}
        END IF;

        RETURN V_NEWVALUE;
    --}
    END;

    FUNCTION CheckNumber(InpStr VARCHAR2) RETURN CHAR IS
    V_NUMBER NUMBER;
    BEGIN
    --{
        BEGIN
            V_NUMBER := TO_NUMBER(REPLACE(NVL(TRIM(InpStr),'N'),' ',''));
            RETURN 'Y';
            EXCEPTION WHEN VALUE_ERROR THEN
            RETURN 'N';
        END;
    --}
    END;
--}
END CommonExtractionPack;
/

DROP PROCEDURE IF EXISTS fm_GetFormExport;
DELIMITER $$
CREATE PROCEDURE fm_GetFormExport(
    $token        VARCHAR(100)
    , $DateFrom         DATETIME
    , $DateTo           DATETIME
    , $ffID       int
    , $tpID       int
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $sql            text;
  DECLARE $sqlWhere            text;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_GetFormExport');
  ELSE
    set @sql = NULL;
    SET group_concat_max_len = 10000;
    --
    select
      GROUP_CONCAT(CONCAT('MAX(if(i.qID = ', qID, ',CONCAT(i.qiAnswer, IFNULL(CONCAT('' ('', i.qiComment,'')''), '''')), NULL)) as ', QUOTE(qName)), CHAR(10))
      INTO @sql
    from fmQuestion
    where tpID = $tpID;
    --
    -- Select @sql;
    IF(@sql IS NOT NULL) THEN
      set $sql = CONCAT('SELECT
            i.dcID                                    `id`
            , cl.clName                               `Имя`
            , cl.`Comment`                            `Комментарий`
            , cc.ccName                               `Телефон дозвона`
            , e.emName                               `Оператор`
            , cc.Created                               `Дата звонка`
            , en.Name											`Статус звонка`
            , cc.duration                               `Продолжительность звонка`
            , count(cc.clID)                            `Кол-во попыток дозвона`
            , cc.billsec                         `Время разговора по контакту`
            , ', @sql,'
        FROM fmFormItem i
            left join fmForm f on f.dcID = i.dcID
            left JOIN dcDoc dc ON dc.dcID = i.dcID
            left JOIN ccContact cc ON cc.clID = dc.clID
            left join crmClient cl on cl.clID = dc.clID
            left join emEmploy e on e.emID = dc.emID
            left join usEnumValue en on (en.tvID = cc.ContactStatus AND en.Aid =cc.Aid)
        where cc.ccStatus = 7001 ');
      SET $sqlWhere = ' AND ';
      IF($tpID IS NOT NULL AND LENGTH(TRIM($tpID))>0)THEN
          set $sql = CONCAT($sql, $sqlWhere, 'f.tpID = ',$tpID, CHAR(10));
          SET $sqlWhere = ' AND ';
      END IF;
      IF($ffID IS NOT NULL AND LENGTH(TRIM($ffID))>0)THEN
          set $sql = CONCAT($sql, $sqlWhere, 'cc.ffID = ',$ffID, CHAR(10));
          SET $sqlWhere = ' AND ';
      END IF;
      IF($DateFrom IS NOT NULL AND LENGTH(TRIM($DateFrom))>0)THEN
          set $sql = CONCAT($sql, $sqlWhere, 'f.Created >= ', QUOTE($DateFrom), CHAR(10));
          SET $sqlWhere = ' AND ';
      END IF;
      IF($DateTo IS NOT NULL AND LENGTH(TRIM($DateTo))>0)THEN
          set $sql = CONCAT($sql, $sqlWhere, 'f.Created <= ', QUOTE($DateTo), CHAR(10));
          SET $sqlWhere = ' AND ';
      END IF;
      set $sql = CONCAT($sql, 'group by i.dcID;', CHAR(10));
      SET @sql = $sql;
    ELSE
        set @sql = 'SELECT "NO DATA"';
    END IF;
    --
     --   select @sql;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--

DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsTts;
CREATE PROCEDURE ast_InsTts(
    $token                VARCHAR(100)
    , $ttsID              INT(11)
    , $ttsName            VARCHAR(50)
    , $ttsText            TEXT
    , $settings           LONGTEXT
    , $engID              INT(11)
    , $ttsFields          VARCHAR(50)
    , $recIDBefore        VARCHAR(250)
    , $recIDAfter         VARCHAR(250)
    , $yandexApikey       VARCHAR(250)
    , $yandexEmotion      INT(11)
    , $yandexEmotions     VARCHAR(250)
    , $yandexFast         BIT
    , $yandexGenders      VARCHAR(250)
    , $yandexLang         VARCHAR(250)
    , $yandexSpeaker      VARCHAR(250)
    , $yandexSpeakers     VARCHAR(250)
    , $yandexSpeed        INT(11)
    , $isActive           BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsTts');
  ELSE
    IF $ttsID IS NULL THEN
      call RAISE(77074, $ttsID);
    END IF;
    --
    INSERT INTO ast_tts (
      ttsID
      , Aid
      , ttsName
      , ttsText
      , ttsFields
      , settings
      , isActive
      , HIID
      , engID
      , recIDBefore
      , recIDAfter
      , yandexApikey
      , yandexEmotion
      , yandexEmotions
      , yandexFast
      , yandexGenders
      , yandexLang
      , yandexSpeaker
      , yandexSpeakers
      , yandexSpeed
    )
    VALUES (
      $ttsID
      , $Aid
      , $ttsName
      , $ttsText
      , $ttsFields
      , $settings
      , $isActive
      , fn_GetStamp()
      , $engID
      , $recIDBefore
      , $recIDAfter
      , $yandexApikey
      , $yandexEmotion
      , $yandexEmotions
      , $yandexFast
      , $yandexGenders
      , $yandexLang
      , $yandexSpeaker
      , $yandexSpeakers
      , $yandexSpeed
    );
  END IF;
END $$
DELIMITER ;
--

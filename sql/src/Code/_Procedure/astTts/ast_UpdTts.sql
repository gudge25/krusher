DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdTts;
CREATE PROCEDURE ast_UpdTts(
    $HIID                 BIGINT
    , $token              VARCHAR(100)
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
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdTts');
  ELSE
    if not exists (
      select 1
      from ast_tts
      where HIID = $HIID
        and ttsID = $ttsID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_tts SET
      ttsName               = $ttsName
      , ttsText             = $ttsText
      , settings            = $settings
      , isActive            = $isActive
      , HIID                = fn_GetStamp()
      , engID               = $engID
      , recIDBefore         = $recIDBefore
      , recIDAfter          = $recIDAfter
      , yandexApikey        = $yandexApikey
      , yandexEmotion       = $yandexEmotion
      , yandexEmotions      = $yandexEmotions
      , yandexFast          = $yandexFast
      , yandexGenders       = $yandexGenders
      , yandexLang          = $yandexLang
      , yandexSpeaker       = $yandexSpeaker
      , yandexSpeakers      = $yandexSpeakers
      , yandexSpeed         = $yandexSpeed
      , ttsFields           = $ttsFields
    WHERE ttsID = $ttsID AND Aid = $Aid ;
  END IF;
END $$
DELIMITER ;
--

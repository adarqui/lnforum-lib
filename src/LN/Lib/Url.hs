{-# LANGUAGE OverloadedStrings #-}

module LN.Lib.Url (
  toPrettyUrl,
  toPrettyName
) where



import           Data.Char (isAlphaNum)
import           Data.Text (Text)
import qualified Data.Text as T



-- | This is used to generate Name's based on DisplayName's, ie a Forum, Board, Thread, or Resource name
--
-- >> toPrettyUrl  "1 2 3 -- hello world?!bingo-BOOM"
-- "1-2-3-hello-world-bingo-boom"
--
toPrettyUrl :: Text -> Text
toPrettyUrl = T.intercalate "-" . T.words . T.map (\c -> if not $ isAlphaNum c then ' ' else c) . T.toLower




-- | This is used to generate Name's based on DisplayName's, ie an Organization or User name
--
-- >> toPrettyName  "Some User Name 123-"
-- "someusername123"
--
toPrettyName :: Text -> Text
toPrettyName = T.concat . T.words . T.map (\c -> if not $ isAlphaNum c then ' ' else c) . T.toLower

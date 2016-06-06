{-# LANGUAGE OverloadedStrings #-}

module LN.Lib.Url (
  toPrettyUrl
) where



import           Data.Char (isAlphaNum)
import           Data.Text (Text)
import qualified Data.Text as T



-- | This is used to generate Name's based on DisplayName's
--
-- >> toPrettyUrl  "1 2 3 -- hello world?!bingo-BOOM"
-- "1-2-3-hello-world-bingo-boom"
--
toPrettyUrl :: Text -> Text
toPrettyUrl = T.intercalate "-" . T.words . T.map (\c -> if not $ isAlphaNum c then ' ' else c) . T.toLower

{-# LANGUAGE OverloadedStrings #-}

module LN.Lib.Url (
  prettyName
) where



import           Data.Char
import           Data.Text (Text)
import qualified Data.Text as T



-- | This is used to generate Name's based on DisplayName's
--
-- >> prettyName  "1 2 3 -- hello world?!bingo-BOOM"
-- "1-2-3-hello-world-bingo-boom"
--
prettyName :: Text -> Text
prettyName = T.intercalate "-" . T.words . T.map (\c -> if not $ isAlphaNum c then ' ' else c) . T.toLower

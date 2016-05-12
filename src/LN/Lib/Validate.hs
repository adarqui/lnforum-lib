{-# LANGUAGE OverloadedStrings #-}

module LN.Lib.Validate (
  isLowerAlphaNum,
  isValidNick,
  isValidDisplayName,
  isValidName,
  isValidEmail,
  isValidNonEmptyString
) where



import           Data.Char
import           Data.Text     (Text)
import qualified Data.Text     as T
import           LN.Lib.Either



isLowerAlphaNum :: Char -> Bool
isLowerAlphaNum c = isLower c && isAlphaNum c



isValidNick :: Text -> Either Text Text
isValidNick nick = boolToEither "nick can only contain lower case alpha-numeric characters" nick $ T.all isLowerAlphaNum nick



isValidDisplayName :: Text -> Either Text Text
isValidDisplayName name = boolToEither "displayName can not contain control characters" name $ T.all (not . isControl) name



isValidName :: Text -> Either Text Text
isValidName name = boolToEither "name can only contain alpha-numeric characters" name $ T.all (not . isControl) name



isValidEmail :: Text -> Either Text Text
isValidEmail email = do
  _ <- boolToEither "email cannot contain spaces" email $ T.all (not . isSpace) email
  _ <- boolToEither "not a valid email" email $ (T.length $ T.filter (=='@') email) == 1
  _ <- boolToEither "not a valid email" email $ name /= "" && domain /= "" && tld /= "."
  Right email
  where
  (name, rest) = T.breakOn "@" email
  (domain, tld) = T.breakOn "." rest



isValidNonEmptyString :: Text -> Either Text Text
isValidNonEmptyString s = boolToEither "string cannot be empty" s $ s /= ""

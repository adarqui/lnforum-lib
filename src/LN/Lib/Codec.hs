module LN.Lib.Codec (
  toJSONText,
  strictToLazy,
  lazyToStrict,
  encodeStrict,
  encodeText,
  encodeTextMaybe,
  decodeText,
  decodeEitherText,
  lbsToText,
  sbsToText,
  textToLbs,
  textToSbs,
  stringToBS,
  textToSbsConcat,
  textToLbsConcat,
  sbsToTextConcat,
  lbsToTextConcat,
  textToInt64,
  tread,
  bread,
  md5Text
) where



import           Data.Aeson
import           Data.ByteString            (ByteString)
import qualified Data.ByteString            as BS
import qualified Data.ByteString.Char8      as BSC
import qualified Data.ByteString.Lazy       as LBS
import qualified Data.ByteString.Lazy.Char8 as BLC
import           Data.Digest.Pure.MD5
import           Data.Int                   (Int64)
import           Data.Text                  (Text)
import qualified Data.Text                  as T
import           Data.Text.Encoding         (decodeUtf8)
import qualified Data.Text.Encoding         as T
import           Prelude
import           Text.Blaze.Html            (Html, preEscapedToHtml)



lazyToStrictBS :: LBS.ByteString -> BS.ByteString
lazyToStrictBS x = BS.concat $ LBS.toChunks x



toJSONText :: Value -> Html
toJSONText v = preEscapedToHtml $ decodeUtf8 $ lazyToStrictBS $ encode $ v



strictToLazy :: BSC.ByteString -> BLC.ByteString
strictToLazy bs = BLC.fromChunks [bs]



lazyToStrict :: BLC.ByteString -> BSC.ByteString
lazyToStrict = BSC.concat . BLC.toChunks



encodeStrict :: ToJSON a => a -> ByteString
encodeStrict = BLC.toStrict . encode



encodeText :: ToJSON a => a -> Text
encodeText = lbsToText . encode



encodeTextMaybe :: ToJSON a => Maybe a -> Maybe Text
encodeTextMaybe Nothing = Nothing
encodeTextMaybe (Just a) = Just $ encodeText a



decodeText :: FromJSON a => Text -> Maybe a
decodeText = decode . textToLbs



-- decodeEitherText :: FromJSON a => Text -> Either Text a
-- decodeEitherText = first T.pack . eitherDecode . textToLbs
decodeEitherText :: FromJSON a => Text -> Either Text a
decodeEitherText t =
  case eitherDecode (textToLbs t)of
    Left e  -> Left $ T.pack e
    Right v -> Right v



stringToBS :: String -> BSC.ByteString
stringToBS = T.encodeUtf8 . T.pack



lbsToText :: BLC.ByteString -> Text
lbsToText = T.decodeUtf8 . lazyToStrict



sbsToText :: BSC.ByteString -> Text
sbsToText = T.decodeUtf8



textToLbs :: Text -> BLC.ByteString
textToLbs = strictToLazy . T.encodeUtf8



textToSbs :: Text -> BSC.ByteString
textToSbs = T.encodeUtf8



textToSbsConcat :: [Text] -> BSC.ByteString
textToSbsConcat = textToSbs . T.concat



textToLbsConcat :: [Text] -> BLC.ByteString
textToLbsConcat = textToLbs . T.concat



sbsToTextConcat :: [BSC.ByteString] -> Text
sbsToTextConcat = undefined



lbsToTextConcat :: [BLC.ByteString] -> Text
lbsToTextConcat = undefined



textToInt64 :: Text -> Int64
textToInt64 s = read (T.unpack s) :: Int64



tread :: Read a => Text -> a
tread = read . T.unpack



bread :: Read a => ByteString -> a
bread = read . BSC.unpack



md5Text :: Text -> Text
md5Text t = T.pack $ show $ md5 (textToLbs t)

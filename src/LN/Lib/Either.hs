module LN.Lib.Either (
  boolToEither,
  maybeToEither
) where



import Data.Either ()



boolToEither :: a -> b -> Bool -> Either a b
boolToEither a _ False = Left a
boolToEither _ b True  = Right b



maybeToEither :: a -> Maybe b -> Either a b
maybeToEither a Nothing  = Left a
maybeToEither _ (Just b) = Right b

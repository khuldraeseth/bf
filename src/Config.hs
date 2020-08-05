module Config
    ( IOMode(..)
    , Config(..)
    , defaultConfig
    ) where

data IOMode = Chars | Nums
    deriving (Eq, Show)

data Config = Config
    { inputMode :: IOMode
    , outputMode :: IOMode
    , isDebug :: Bool
    }

defaultConfig :: Config
defaultConfig = Config
    { inputMode = Chars
    , outputMode = Chars
    , isDebug = False
    }

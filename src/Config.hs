module Config
    ( IOMode(..)
    , Config(..)
    , defaultConfig
    ) where

import System.IO (FilePath)

data IOMode = Chars | Nums
    deriving (Eq, Show)

data Config = Config
    { inputMode :: IOMode
    , outputMode :: IOMode
    , isDebug :: Bool
    , source :: Maybe FilePath
    }

defaultConfig :: Config
defaultConfig = Config
    { inputMode = Chars
    , outputMode = Chars
    , isDebug = False
    , source = Nothing
    }

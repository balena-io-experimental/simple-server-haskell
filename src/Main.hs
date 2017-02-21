module Main where

import Network.HTTP.Server
import Network.HTTP.Server.Logger
import System.Environment

main :: IO ()
main = do
  (addr:_) <- getArgs
  serverWith defaultConfig { srvLog = stdLogger, srvHost = addr, srvPort = 8080 }
    $ \_ url request ->
      return $ sendText OK "Hello Haskell Resin!"

sendText :: StatusCode -> String -> Response String
sendText s v = insertHeader HdrContentLength (show (length v))
              $ insertHeader HdrContentEncoding "UTF-8"
              $ insertHeader HdrContentEncoding "text/plain"
              $ (respond s :: Response String) { rspBody = v }

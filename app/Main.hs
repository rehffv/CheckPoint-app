{-module Main where

import Network.Wai.Handler.Warp
import Server.Handler
import Database.PostgreSQL.Simple
import System.Environment (lookupEnv)
import Data.String (fromString)

main :: IO ()
main = do
  dbUrl <- lookupEnv "DATABASE_URL"
  conn <- case dbUrl of
    Just url -> connectPostgreSQL (fromString url)
    Nothing  -> connect defaultConnectInfo
      { connectHost     = "localhost"
      , connectDatabase = "taskdb"
      , connectUser     = "postgres"
      , connectPassword = "postgres"
      }
  putStrLn "Servidor rodando na porta 8080..."
  run 8080 (app conn)
-}

module Main where

import Network.Wai.Handler.Warp
import Server.Handler
import Database.PostgreSQL.Simple
import System.Environment (lookupEnv)
import Text.Read (readMaybe)
import Data.String (fromString)

main :: IO ()
main = do

  dbUrl <- lookupEnv "DATABASE_URL"

  portEnv <- lookupEnv "PORT"

  let port =
        case portEnv >>= readMaybe of
          Just p  -> p
          Nothing -> 8080

  conn <- case dbUrl of
    Just url -> connectPostgreSQL (fromString url)
    Nothing  -> connect defaultConnectInfo
      { connectHost     = "localhost"
      , connectDatabase = "taskdb"
      , connectUser     = "postgres"
      , connectPassword = "postgres"
      }

  putStrLn ("Servidor rodando na porta " ++ show port)

  run port (app conn)
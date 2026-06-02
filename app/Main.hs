module Main where

import Network.Wai.Handler.Warp
import Server.Handler
import Database.PostgreSQL.Simple
import System.Environment (lookupEnv)

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
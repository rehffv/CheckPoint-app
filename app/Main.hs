module Main where

import Network.Wai.Handler.Warp
import Server.Handler
import Database.PostgreSQL.Simple

main :: IO ()
main = do
  conn <- connect defaultConnectInfo
    { connectHost     = "localhost"
    , connectDatabase = "taskdb"
    , connectUser     = "postgres"
    , connectPassword = "postgres"
    }
  putStrLn "Servidor rodando na porta 8080..."
  run 8080 (app conn)
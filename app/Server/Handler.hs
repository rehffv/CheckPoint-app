{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}
module Server.Handler where

import Api.Model
import Data.Proxy
import Network.Wai
import Servant.API
import Servant.Server
import Database.PostgreSQL.Simple
import Control.Monad.IO.Class
import Control.Monad.Except

type API =
      "tasks" :> Get '[JSON] TaskResponse
 :<|> "tasks" :> ReqBody '[JSON] Task :> Post '[JSON] ResultadoResponse
 :<|> "tasks" :> Capture "id" Int :> ReqBody '[JSON] Task :> Put '[JSON] ResultadoResponse
 :<|> "tasks" :> Capture "id" Int :> Delete '[JSON] ResultadoResponse
 :<|> "tasks" :> Verb 'OPTIONS 200 '[JSON] ()
 :<|> "tasks" :> Capture "id" Int :> Verb 'OPTIONS 200 '[JSON] ()

handlerGetTasks :: Connection -> Handler TaskResponse
handlerGetTasks conn = do
  res <- liftIO $ query_ conn
    "SELECT id, titulo, descricao, prioridade, concluida FROM tasks"
  let ts = map (\(i, t, d, p, c) -> Task (Just i) t d p c) res
  pure (TaskResponse ts)

handlerPostTask :: Connection -> Task -> Handler ResultadoResponse
handlerPostTask conn task = do
  res <- liftIO $ query conn
    "INSERT INTO tasks (titulo, descricao, prioridade, concluida) VALUES (?,?,?,?) RETURNING id"
    (titulo task, descricao task, prioridade task, concluida task)
  case res of
    [Only novoId] -> pure (ResultadoResponse novoId)
    _             -> throwError err500

handlerPutTask :: Connection -> Int -> Task -> Handler ResultadoResponse
handlerPutTask conn tid task = do
  _ <- liftIO $ execute conn
    "UPDATE tasks SET titulo=?, descricao=?, prioridade=?, concluida=? WHERE id=?"
    (titulo task, descricao task, prioridade task, concluida task, tid)
  pure (ResultadoResponse tid)

handlerDeleteTask :: Connection -> Int -> Handler ResultadoResponse
handlerDeleteTask conn tid = do
  _ <- liftIO $ execute conn
    "DELETE FROM tasks WHERE id=?" (Only tid)
  pure (ResultadoResponse tid)

options :: Handler ()
options = pure ()

optionsId :: Int -> Handler ()
optionsId _ = pure ()

addCorsHeader :: Middleware
addCorsHeader app' req resp =
  app' req $ \res ->
    resp $ mapResponseHeaders
      ( \hs ->
        [ ("Access-Control-Allow-Origin", "*")
        , ("Access-Control-Allow-Headers", "Content-Type, Authorization")
        , ("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
        ] ++ hs
      )
      res

server :: Connection -> Server API
server conn =
       handlerGetTasks conn
  :<|> handlerPostTask conn
  :<|> handlerPutTask conn
  :<|> handlerDeleteTask conn
  :<|> options
  :<|> optionsId

app :: Connection -> Application
app conn = addCorsHeader (serve (Proxy @API) (server conn))
{-# LANGUAGE DeriveGeneric #-}
module Api.Model where

import GHC.Generics
import Data.Aeson
import Database.PostgreSQL.Simple.FromRow

-- Tipo que representa uma tarefa
data Task = Task
  { taskId       :: Maybe Int
  , titulo       :: String
  , descricao    :: Maybe String
  , prioridade   :: String   -- "baixa", "media", "alta"
  , concluida    :: Bool
  } deriving (Show, Generic)

instance ToJSON Task
instance FromJSON Task
instance FromRow Task

-- Para retornar lista de tarefas
newtype TaskResponse = TaskResponse { tasks :: [Task] }
  deriving (Show, Generic)

instance ToJSON TaskResponse

-- Para retornar ID após criação
newtype ResultadoResponse = ResultadoResponse { resultId :: Int }
  deriving (Show, Generic)

instance ToJSON ResultadoResponse
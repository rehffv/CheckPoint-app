{-# LANGUAGE DeriveGeneric #-}
module Api.Model where

import GHC.Generics
import Data.Aeson
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.ToField

data Task = Task
  { taskId       :: Maybe Int
  , titulo       :: String
  , descricao    :: Maybe String
  , prioridade   :: String
  , concluida    :: Bool
  , prazo        :: Maybe String
  } deriving (Show, Generic)

instance ToJSON Task
instance FromJSON Task
instance FromRow Task
instance ToRow Task

newtype TaskResponse = TaskResponse { tasks :: [Task] }
  deriving (Show, Generic)

instance ToJSON TaskResponse

newtype ResultadoResponse = ResultadoResponse { resultId :: Int }
  deriving (Show, Generic)

instance ToJSON ResultadoResponse
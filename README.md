# ✅ CheckPoint

Aplicação web de gerenciamento de tarefas com **timer de prazo em tempo real**, desenvolvida como projeto acadêmico para a disciplina de Tópicos Especiais em Informática — FATEC ADS.

---

## 🚀 Demonstração

- **Frontend:** [rehffv.github.io/CheckPoint-app](https://rehffv.github.io/CheckPoint-app/)
- **API:** [checkpoint-app-w7ue.onrender.com/tasks](https://checkpoint-app-w7ue.onrender.com/tasks)

---

## 📋 Funcionalidades

- Criar, editar e excluir tarefas
- Definir prioridade (baixa, média, alta)
- Marcar tarefas como concluídas
- Definir prazo com **contador regressivo em tempo real**
- Tarefas vencidas ficam em vermelho com borda piscando
- Indicação de "Concluída no prazo" ou "Concluída atrasada"
- Filtros por status, prioridade e tarefas vencidas
- Interface responsiva — funciona no celular

---

## 🛠️ Tecnologias

### Backend
- **Haskell** — linguagem funcional
- **Servant** — biblioteca para criação de APIs REST
- **Warp** — servidor HTTP
- **PostgreSQL** — banco de dados relacional
- **postgresql-simple** — conexão com o banco

### Frontend
- **HTML / CSS / JavaScript** — vanilla, sem frameworks
- **Google Fonts** — tipografia (Syne + DM Sans)

### Infraestrutura
- **Render** — deploy do backend e banco de dados
- **GitHub Pages** — hospedagem do frontend
- **Docker** — containerização do backend

---

## 🗂️ Estrutura do Projeto

```
CheckPoint-app/
├── app/
│   ├── Main.hs              # Ponto de entrada, conexão com banco
│   ├── Api/
│   │   └── Model.hs         # Tipos e modelos de dados
│   └── Server/
│       └── Handler.hs       # Rotas e handlers da API
├── docs/
│   └── index.html           # Frontend completo
├── Dockerfile               # Configuração para deploy
└── haskprojeto.cabal        # Configuração do projeto Haskell
```

---

## 🔌 Endpoints da API

| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/tasks` | Lista todas as tarefas |
| POST | `/tasks` | Cria uma nova tarefa |
| PUT | `/tasks/:id` | Atualiza uma tarefa |
| DELETE | `/tasks/:id` | Remove uma tarefa |

---

## 🏃 Como rodar localmente

### Pré-requisitos
- [GHCup](https://www.haskell.org/ghcup/) (GHC 9.6.7 + Cabal)
- [PostgreSQL](https://www.postgresql.org/download/)
- MSYS2 com `mingw-w64-x86_64-postgresql` (Windows)

### Passos

**1. Clone o repositório**
```bash
git clone https://github.com/rehffv/CheckPoint-app.git
cd CheckPoint-app
```

**2. Crie o banco de dados**
```sql
psql -U postgres
CREATE DATABASE taskdb;
\c taskdb
CREATE TABLE tasks (
  id        SERIAL PRIMARY KEY,
  titulo    VARCHAR(255) NOT NULL,
  descricao TEXT,
  prioridade VARCHAR(10) DEFAULT 'media',
  concluida BOOLEAN DEFAULT FALSE,
  prazo     TIMESTAMP
);
```

**3. Configure a conexão** em `app/Main.hs`:
```haskell
connectHost     = "localhost"
connectDatabase = "taskdb"
connectUser     = "postgres"
connectPassword = "sua_senha"
```

**4. Compile e rode**
```bash
cabal build
cabal run
```

**5. Abra o frontend**

Abra `docs/index.html` com Live Server ou qualquer servidor HTTP local, apontando para `http://localhost:8080`.

---

## 👩‍💻 Autores

Desenvolvido por **Renata e Patrick** — FATEC ADS, 6º Semestre.

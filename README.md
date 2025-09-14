# Rust Lua Demo

Um projeto acadêmico demonstrando a integração entre Rust e Lua para criar um sistema de armazenamento chave-valor com validações customizadas.

## 📋 Sobre o Projeto

Este projeto implementa um banco de dados simples em memória que permite armazenar e recuperar valores usando chaves. O diferencial está na validação automática de dados específicos através de scripts Lua, demonstrando como linguagens diferentes podem trabalhar em conjunto.

### Funcionalidades

- **Armazenamento chave-valor**: Sistema básico de banco de dados em memória
- **Validação de CPF**: Chaves que começam com `cpf_` são automaticamente validadas
- **Validação de data**: Chaves que começam com `data_` validam formato YYYY-MM-DD
- **Formatação automática**: CPFs são formatados com máscara e datas são convertidas para formato brasileiro
- **Interface colorida**: Terminal com cores para melhor experiência do usuário

## 🚀 Como Executar

### Pré-requisitos

- Rust (versão 1.70 ou superior)
- Cargo (gerenciador de pacotes do Rust)

### Instalação e Execução

1. Clone ou baixe o projeto
2. Navegue até o diretório do projeto
3. Execute o comando:

```bash
cargo run
```

O programa será compilado automaticamente e iniciado.

## 📖 Como Usar

Após executar o programa, você verá uma interface interativa com os seguintes comandos:

### Comandos Disponíveis

- **`ADD <chave> <valor>`**: Adiciona um valor a uma chave
- **`GET <chave>`**: Recupera o valor de uma chave
- **`COMMANDS`**: Exibe a lista de comandos
- **`EXIT`**: Sai do programa

### Exemplos de Uso

#### Dados Simples
```
> ADD nome João
> GET nome
```

#### CPF (com validação)
```
> ADD cpf_cliente 12345678901
> GET cpf_cliente
```
Saída: `123.456.789-01`

#### Data (com validação)
```
> ADD data_nascimento 1990-05-15
> GET data_nascimento
```
Saída: `15/05/1990`

## 🛠️ Tecnologias Utilizadas

- **Rust**: Linguagem principal para a aplicação
- **Lua**: Scripts para validação e formatação de dados
- **mlua**: Biblioteca Rust para integração com Lua
- **Cargo**: Gerenciador de dependências e build

## 📁 Estrutura do Projeto

```
rust_lua_demo/
├── src/
│   ├── main.rs          # Código principal em Rust
│   └── script.lua       # Scripts de validação em Lua
├── Cargo.toml           # Configuração do projeto
├── .gitignore           # Arquivos ignorados pelo Git
└── README.md            # Este arquivo
```

## 🔍 Detalhes Técnicos

### Validações Implementadas

#### CPF
- Verifica se possui exatamente 11 dígitos
- Valida os dígitos verificadores usando o algoritmo oficial
- Aplica formatação com máscara (XXX.XXX.XXX-XX)

#### Data
- Verifica formato YYYY-MM-DD
- Valida meses (1-12) e dias apropriados
- Considera anos bissextos para fevereiro
- Converte para formato brasileiro (DD/MM/YYYY)

### Integração Rust-Lua

O projeto demonstra como:
- Executar código Lua a partir do Rust
- Compartilhar dados entre as linguagens
- Capturar e tratar erros do Lua no Rust
- Usar Lua para lógica de negócio flexível

## 🎯 Objetivos Acadêmicos

Este projeto foi desenvolvido para demonstrar:

1. **Integração entre linguagens**: Como Rust pode incorporar scripts Lua
2. **Validação de dados**: Implementação de regras de negócio em Lua
3. **Tratamento de erros**: Gerenciamento de exceções entre linguagens
4. **Interface de usuário**: Criação de CLI interativa e colorida
5. **Estruturação de código**: Organização clara entre lógica principal e scripts

## 📚 Aprendizados

- Uso da biblioteca `mlua` para integração Rust-Lua
- Implementação de validadores de CPF e data
- Criação de interfaces de linha de comando interativas
- Gerenciamento de estado compartilhado entre linguagens
- Tratamento de erros e validação de entrada do usuário

## 🔧 Possíveis Melhorias

- Persistência de dados em arquivo
- Suporte a mais tipos de validação
- Interface web ou gráfica
- Comandos para listar e remover chaves
- Sistema de backup e restauração
- Suporte a tipos de dados complexos (JSON, arrays)

---

*Este é um projeto acadêmico desenvolvido para demonstrar conceitos de integração entre linguagens de programação.*

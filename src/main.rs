use mlua::prelude::*;
use std::fs;
use std::io::{self, Write};

const YELLOW: &str = "\x1b[1;33m";
const BLUE: &str = "\x1b[1;34m";
const GREEN: &str = "\x1b[1;35m";
const CYAN: &str = "\x1b[1;36m";
const RED: &str = "\x1b[1;31m";
const RESET: &str = "\x1b[0m";

fn show_commands() {
    println!("{BLUE}Execute algum comando. Exemplos:{RESET}");
    println!(
        "- {YELLOW}ADD{RESET} {CYAN}<abc>{RESET} {GREEN}<1234>{RESET} ---> Adiciona o valor 1234 na chave abc"
    );
    println!(
        "- {YELLOW}GET{RESET} {CYAN}<abc>{RESET} ---> Retorna o valor da chave abc se existir"
    );
    println!("- {YELLOW}COMMANDS{RESET} ---> Exibe novamente essa lista de comandos");
    println!("- {RED}EXIT{RESET} --->  sair do programa");
}

fn validate_key(key: &str) -> Result<String, String> {
    if key.is_empty() {
        return Err("Chave não pode ser vazia".into());
    }

    Ok(key.to_string())
}

fn validate_pair(key: &str, value: &str) -> Result<(String, String), String> {
    validate_key(key)?;

    if value.is_empty() {
        return Err("Valor não pode ser vazio".into());
    }

    Ok((key.to_string(), value.to_string()))
}

fn get_input() -> Result<(String, Vec<String>), Box<dyn std::error::Error>> {
    print!("> ");
    io::stdout().flush()?;
    let mut input = String::new();
    io::stdin().read_line(&mut input)?;
    input = input.trim().to_string();
    let parts: Vec<String> = input.split_whitespace().map(|s| s.to_string()).collect();

    Ok((input, parts))
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let lua = Lua::new();

    let script = fs::read_to_string("src/script.lua")?;
    lua.load(&script).exec()?;

    let globals = lua.globals();
    let db = lua.create_table()?;
    globals.set("DB", db)?;
    let lua_add_f: LuaFunction = globals.get("ADD")?;
    let lua_get_f: LuaFunction = globals.get("GET")?;

    show_commands();

    loop {
        let (_, command_input) = get_input()?;

        if command_input.len() > 0 && command_input[0] == "EXIT" {
            println!("Fechando...");
            break;
        } else if command_input.len() > 0 && command_input[0] == "ADD" {
            let key = command_input.get(1).map(|s| s.as_str()).unwrap_or("");
            let value = command_input.get(2).map(|s| s.as_str()).unwrap_or("");

            if let Err(error) = validate_pair(key, value) {
                eprintln!("{RED}ERROR: {error}{RESET}");
                continue;
            }

            let _: () = lua_add_f.call((key, value))?;
            println!("{BLUE}Valor {GREEN}{value} {BLUE}adicionado a chave {CYAN}{key}{RESET}");
        } else if command_input.len() > 0 && command_input[0] == "GET" {
            let key = command_input.get(1).map(|s| s.as_str()).unwrap_or("");

            if let Err(error) = validate_key(key) {
                eprintln!("{RED}ERROR: {error}{RESET}");
                continue;
            }

            let result: Result<String, LuaError> = lua_get_f.call(key);
            match result {
                Ok(value) => {
                    println!("{BLUE}Valor: {value}{RESET}");
                }
                Err(_) => {
                    println!("{RED}Chave {CYAN}{key} {RED}não encontrada.{RESET}");
                    println!(
                        "DICA: {BLUE}Use o comando {YELLOW}ADD {CYAN}{key} {GREEN}<valor>{BLUE} para adicionar um valor a essa chave.{RESET}"
                    );
                    continue;
                }
            }
        } else if command_input.len() > 0 && command_input[0] == "COMMANDS" {
            show_commands();
        } else {
            println!("{RED}Comando inválido.{RESET}");
        }
    }

    Ok(())
}

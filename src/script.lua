function ADD(key, value)
  if string.sub(key, 1, 4) == "cpf_" then
    if not Validate_cpf(value) then
      error("CPF inválido")
    end
  end

  DB[key] = value
end

function GET(key)
  if DB[key] == nil then
    error("Chave não encontrada")
  end

  if string.sub(key, 1, 4) == "cpf_" then
    return Format_cpf_mask(DB[key])
  end

  return DB[key]
end

function Validate_cpf(cpf)
  if #cpf ~= 11 then
    return false
  end
  local first_validator = string.sub(cpf, 10, 10)
  local second_validator = string.sub(cpf, 11, 11)

  local first_sum = 0
  for i = 1, 9 do
    first_sum = first_sum + tonumber(string.sub(cpf, i, i)) * (11 - i)
  end

  if ((first_sum * 10) % 11) % 10 ~= tonumber(first_validator) then
    return false
  end

  local second_sum = 0
  for i = 1, 10 do
    second_sum = second_sum + tonumber(string.sub(cpf, i, i)) * (12 - i)
  end

  if ((second_sum * 10) % 11) % 10 ~= tonumber(second_validator) then
    return false
  end
  return true
end

function Format_cpf_mask(cpf)
  return string.format("%s.%s.%s-%s", string.sub(cpf, 1, 3), string.sub(cpf, 4, 6), string.sub(cpf, 7, 9),
    string.sub(cpf, 10, 11))
end

function Validate_date(date)
  -- logica para formatar a data no formato ISO8601 (2022-10-23)
end

function Format_date_br(date)
  -- logica para formatar a data no formato dd/mm/yyyy
end

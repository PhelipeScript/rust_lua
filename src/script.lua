function ADD(key, value)
  DB[key] = value
end

function GET(key)
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

  if (first_sum * 10) % 11 ~= tonumber(first_validator) then
    return false
  end

  local second_sum = 0
  for i = 1, 10 do
    second_sum = second_sum + tonumber(string.sub(cpf, i, i)) * (12 - i)
  end

  if (second_sum * 10) % 11 ~= tonumber(second_validator) then
    return false
  end
  return true
end

function Format_cpf_mask(cpf)
  -- logica para formatar o cpf no formato xxx.xxx.xxx-xx
end

function Validate_date(date)
  -- logica para formatar a data no formato ISO8601 (2022-10-23)
end

function Format_date_br(date)
  -- logica para formatar a data no formato dd/mm/yyyy
end

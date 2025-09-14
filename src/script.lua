function ADD(key, value)
  if string.sub(key, 1, 4) == "cpf_" then
    if not Validate_cpf(value) then
      error("CPF inválido")
    end
  end

  if string.sub(key, 1, 5) == "data_" then
    if not Validate_date(value) then
      error("Data inválida. Formato esperado YYYY-MM-DD")
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

  if string.sub(key, 1, 5) == "data_" then
    return Format_date_br(DB[key])
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
  if not string.match(date, "^%d%d%d%d%-%d%d%-%d%d$") then
    return false
  end

  local matches = {string.match(date, "^(%d%d%d%d)%-(%d%d)%-(%d%d)$")}
  local year = tonumber(matches[1])
  local month = tonumber(matches[2])
  local day = tonumber(matches[3])

  if month < 1 or month > 12 then
    return false
  end
  if day < 1 or day > 31 then
    return false
  end
  if (month == 4 or month == 6 or month == 9 or month == 11) and day > 30 then
    return false
  end

  if month == 2 then
    local is_leap_year = (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0)
    if (is_leap_year and day > 29) or (not is_leap_year and day > 28) then
      return false
    end
  end

  return true
end

function Format_date_br(date)
  return string.format("%s/%s/%s", string.sub(date, 9, 10), string.sub(date, 6, 7), string.sub(date, 1, 4))
end

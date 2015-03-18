local _file_values = './data/karma.lua'

function read_file_values( )
    local f = io.open(_file_values, "r+")
    -- If file doesn't exists
    if f == nil then
        -- Create a new empty table
        print ('Created value file '.._file_values)
        serialize_to_file({}, _file_values)
    else
        print ('Values loaded: '.._file_values)
        f:close()
    end
    return loadfile (_file_values)()
end

_values = read_file_values()

function save_value(chat, text )
    var_name = string.match(text, "(%a+)")
    var_name = string.lower(var_name);
    if _values[chat] == nil then
        _values[chat] = {}
    end

    if (string.match(text, "%+%+")) then
        if (_values[chat][var_name] == nil) then
            _values[chat][var_name] = 1
            var_int = 1
            serialize_to_file(_values, _file_values)
            return (var_name:gsub("^%l", string.upper)) .. "'s karma is verhoogd naar " .. tostring(var_int)
        else
            var_int = tonumber(_values[chat][var_name])
            var_int = var_int + 1
            _values[chat][var_name] = var_int
            serialize_to_file(_values, _file_values)
            return (var_name:gsub("^%l", string.upper)) .. "'s karma is verhoogd naar " .. tostring(var_int)
        end
    elseif (string.match(text, "%-%-")) then
        if (_values[chat][var_name] == nil) then
            _values[chat][var_name] = -1
            var_int = -1
            serialize_to_file(_values, _file_values)
            return (var_name:gsub("^%l", string.upper)) .. "'s karma is verlaagd naar " .. tostring(var_int)
        else
            var_int = tonumber(_values[chat][var_name])
            var_int = var_int - 1
            _values[chat][var_name] = var_int
            serialize_to_file(_values, _file_values)
            return (var_name:gsub("^%l", string.upper)) .. "'s karma is verlaagd naar " .. tostring(var_int)
        end
    end


end

function run(msg, matches)
    local text = ''
    if string.match(msg.text, "^!karma$") then
        for key,value in pairs(_values[tostring(msg.to.id)]) do --actualcode
            print(key)
            print(value)
            text = text..key..' : '..value..'\n'
        end
    else
        local chat_id = tostring(msg.to.id)
        text = save_value(chat_id, msg.text)
    end
    return text
end

return {
    description = "Plugin om karma bij te houden",
    usage = "!karma: Overzicht van de karma",
    patterns = {"^(%a+)%+%+$","^(%a+)%-%-$","^!karma$"},
    run = run
}


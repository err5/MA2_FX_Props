function print(data)
    gma.feedback(data)
    gma.echo(data)
end

function string_formatter(input)
    local words = {}
    local index = 1

    for word in string.gmatch(input, "%S+") do
        words[index] = word
        index = index + 1
    end
    return words
end

function processEffect()
    local effect_range_selector = gma.show.getvar("FX_mult_selector")
    local pget = gma.show.property.get

    local effect_mult = gma.textinput("Optionasa hera. w->wings, b->blocks, g->groups / for div, * for mult", "w*2")

    local type_switch = string.sub(effect_mult, 1, 1)
    local mult_div_switch = string.sub(effect_mult, 2, 2)
    local mult_div_value = string.sub(effect_mult, 3, 9)

    local r_start = tonumber(string_formatter(effect_range_selector)[1])
    local r_end = tonumber(string_formatter(effect_range_selector)[2])
    if (r_end == nil) then
        r_end = r_start
    end

    local fx_type
    local cmd_fx
    print("ts " .. type_switch)
    if (type_switch == "w") then
        fx_type = 17
        cmd_fx = " /Wings="
    elseif (type_switch == "b") then
        fx_type = 16
        cmd_fx = " /Blocks="
    elseif (type_switch == "g") then
        fx_type = 15
        cmd_fx = " /Groups="
    end
    print("ft" .. fx_type)

    local i = r_start
    local k = 0
    local effect_line
    local gbw_proc
    local effect = ""

    local result = ""
    while (i <= r_end) do
        k = 0

        effect = gma.show.getobj.handle("Effect " .. i)
        print("i: " .. i)
        while (k < gma.show.getobj.amount(effect)) do
            print("k: " .. k)
            effect_line = gma.show.getobj.child(effect, k)
            local gbw = pget(effect_line, fx_type)

            if (gbw == "None") then
                gbw = 0
            end
            print(gbw)

            if (mult_div_switch == "/") then
                gbw_proc = gbw / mult_div_value
            else
                gbw_proc = gbw * mult_div_value
            end

            gma.cmd("Assign Effect 1." .. gma.show.getobj.number(effect) .. "." .. k + 1 .. cmd_fx .. gbw_proc)

            result = result .. gbw_proc .. " "
            k = k + 1
        end
        i = i + 1
    end

    print(result:sub(1, -2))
end

return processEffect

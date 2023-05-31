function print(data)
    gma.feedback(data)
    gma.echo(data)
end

function processInput(input)
  local output = ""
  
  local startNum, endNum = input:lower():match("(%d+)%s*thru%s*(%d+)")
  if startNum and endNum then
    output = startNum .. " " .. endNum
  else
    local num = input:lower():match("(%d+)")
    if num then
      output = num
    end
  end
    print("Selected range is: " .. output) 
  return output
end


function selector()
 local input_range = gma.textinput("Gimme dat range or single", "1 OR 1 THRU 5" )
 gma.show.setvar("FX_mult_selector", processInput(input_range)) 
end

return selector 
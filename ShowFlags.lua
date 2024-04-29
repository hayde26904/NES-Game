-- Define a function to update and display the carry flag value
function updateCarryFlag()
    -- Read the carry flag from the CPU status register (P register)
    local carryFlag = memory.readbyte(0x6000) -- Assuming NES CPU status register address
    
    -- Display the carry flag value
    gui.text(10, 10, "Carry Flag: " .. carryFlag)
end

-- Main loop
while true do
    -- Update and display the carry flag value
    updateCarryFlag()
    
    -- Emulate a delay to control the refresh rate of the display
    emu.frameadvance()
end

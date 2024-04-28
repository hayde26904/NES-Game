local function drawFlags()
    local flags = {
        C = (cpu.getRegister("P") & 1) == 1 and 1 or 0,
        Z = (cpu.getRegister("P") & 2) == 2 and 1 or 0,
        I = (cpu.getRegister("P") & 4) == 4 and 1 or 0,
        D = (cpu.getRegister("P") & 8) == 8 and 1 or 0,
        B = (cpu.getRegister("P") & 16) == 16 and 1 or 0,
        V = (cpu.getRegister("P") & 64) == 64 and 1 or 0,
        N = (cpu.getRegister("P") & 128) == 128 and 1 or 0
    }
    
    gui.drawText(10, 10, "C: " .. flags.C, 0xFFFFFFFF, 0x000000FF)
    gui.drawText(50, 10, "Z: " .. flags.Z, 0xFFFFFFFF, 0x000000FF)
    gui.drawText(90, 10, "I: " .. flags.I, 0xFFFFFFFF, 0x000000FF)
    gui.drawText(10, 30, "D: " .. flags.D, 0xFFFFFFFF, 0x000000FF)
    gui.drawText(50, 30, "B: " .. flags.B, 0xFFFFFFFF, 0x000000FF)
    gui.drawText(90, 30, "V: " .. flags.V, 0xFFFFFFFF, 0x000000FF)
    gui.drawText(130, 30, "N: " .. flags.N, 0xFFFFFFFF, 0x000000FF)
end

while true do
    drawFlags()
    emu.frameadvance()
end

HCS_MessageFrameUI = {}

-- Create a frame to display the message
local messageFrame = CreateFrame("Frame", nil, UIParent)
messageFrame:SetSize(300, 50) -- Set the size of the frame
messageFrame:SetPoint("CENTER", UIParent, "CENTER") -- Position at the center of the screen
messageFrame.text = messageFrame:CreateFontString(nil, "ARTWORK") -- Create a font string for the frame
messageFrame.text:SetAllPoints()
messageFrame.text:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE") -- Set the font, size, and style
messageFrame:Hide() -- Hide the frame initially

-- Function to display a message and auto-hide the frame after a delay
function HCS_MessageFrameUI.DisplayMessage(msg, delay)
    messageFrame.text:SetText(msg) -- Set the message
    messageFrame:Show() -- Show the frame
    C_Timer.After(delay or 5, function() -- Start the timer
        messageFrame:Hide()
    end)
end



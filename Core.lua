local MyAuctionTotal_Version = GetAddOnMetadata("MyAuctionTotal", "Version");
local MyAuctionTotal_Text = nil

MyAuctionTotal = LibStub("AceAddon-3.0"):NewAddon("MyAuctionTotal", "AceConsole-3.0", "AceEvent-3.0")

function MyAuctionTotal:CalculateTotals(input)
    -- now handle it!
    local total = 0
	local incoming = 0
	local totalString
	local incomingString
	for i=1, GetNumAuctionItems("owner") do
		local buyout, _, _, _, _, _, sold = select(10, GetAuctionItemInfo("owner", i))
		total = total + buyout
		if sold == 1 then
			incoming = incoming + buyout
		end
	end

	-- Add to Auction Tab
	if (MyAuctionTotal:isEmpty(MyAuctionTotal_Text)) then
		MyAuctionTotal_Text = AuctionFrameAuctions:CreateFontString()
		MyAuctionTotal_Text:SetFontObject(GameFontNormal)
		MyAuctionTotal_Text:SetPoint("BOTTOMLEFT", AuctionFrameAuctions, "BOTTOMLEFT", 190, 20)
	end
	if (total > 0) then
		totalString = format("Buyout Total Value: |cffffffff%s|r", GetCoinTextureString(total))
		MyAuctionTotal_Text:SetText(totalString)
	else
		MyAuctionTotal_Text:SetText("No Auctions Found")
	end
end

function MyAuctionTotal:OnInitialize()
	-- Code that you want to run when the addon is first loaded goes here.
	self:RegisterEvent("AUCTION_OWNED_LIST_UPDATE", "CalculateTotals")
end

function MyAuctionTotal:OnEnable()
    -- Called when the addon is enabled
    -- AceConsole used as a mixin for AceAddon
	MyAuctionTotal:Print("Version " .. MyAuctionTotal_Version .. " loaded.")
end

function MyAuctionTotal:OnDisable()
-- Called when the addon is disabled
end

function MyAuctionTotal:isEmpty(s)
	return s == nil or s == ''
end

function PajFindItem(item_name)
    local items = {}

    for i = 0,4 do
        for x = 1, GetContainerNumSlots(i) do
            y = GetContainerItemLink(i,x)
            if y then
                if GetItemInfo(y) == item_name then
                    items[#items+1] = {i, x}
                end
            end
        end
    end

    return items
end

function PajFindFromVendor(item_name)
    local numMerchantItems = GetMerchantNumItems()

    if numMerchantItems == 0 then
        return 0
    end

    for i = 1, numMerchantItems do
        local name, _, _, _, _, _, _ = GetMerchantItemInfo(i)
        if name == item_name then
            return i
        end
    end

    return 0
end

function PajBuyFromVendor(item_name, quantity, stack_size)
    local itemIndex = PajFindFromVendor(item_name)
    if itemIndex == 0 then
        return
    end

    if quantity == nil then
        quantity = 1
    end

    if stack_size == nil then
        stack_size = 1
    end

    for i = 1, quantity do
        BuyMerchantItem(itemIndex, stack_size)
    end
end

function PajTradeItem(item_name)
    local items = PajFindItem(item_name)
    local i = 1
    for k, v in pairs(items) do
        PickupContainerItem(v[1], v[2])
        DropItemOnUnit("target")

        if i == 6 then
            break
        end
        i = i + 1
    end
end

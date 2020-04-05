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

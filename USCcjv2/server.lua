addEvent( "onPlayerBuyClothes", true )
addEventHandler( "onPlayerBuyClothes", root,
function ( categoryClothes, price )
    if ( categoryClothes and price ) then
        for i=0, 17 do
            local texture, model = categoryClothes[i].tex, categoryClothes[i].mod
                if texture and model then
                    addPedClothes ( source, texture, model, i )
                end
        end
		takePlayerMoney( source, price)
    end
end
)
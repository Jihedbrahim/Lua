addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
   	txd = engineLoadTXD ( "data/roads.txd" )
	engineImportTXD ( txd, 18450 )
	txd = engineLoadTXD ( "data/jumps.txd" )
	engineImportTXD ( txd, 1655 )
end)
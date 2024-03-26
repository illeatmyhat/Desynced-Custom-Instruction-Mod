local package = ...

-- files loaded when mod is initializing
package.includes = {
	"instructions.lua"
}

-- called when mod is initializing
function package:init()
end

-- called when a mod is upgrading from a previous version
---@param ver integer Comes from `version_code` in def.json
function package:on_update(ver)
	if ver == 2 then
	elseif ver == 1 then
	end
end

-- Local references for shorter names and avoiding global lookup on every use
local Get, GetNum, GetCoord, GetId, GetEntity, AreEqual, Set, BeginBlock, Error = InstGet, InstGetNum, InstGetCoord, InstGetId, InstGetEntity, InstAreEqual, InstSet, InstBeginBlock, InstError

---@class Behavior
---@field name string The name of this behavior
---@field parameters table<any, table>
---@field subs table<integer, Behavior> Subroutines.
Behavior = {}

---@class Code
---@field op "call" | string
---@field next integer | nil
---@field nx number | nil
---@field ny number | nil
---@field sub Behavior
Code = {}


---@see data.instructions.call defines `returns`'
---@see UploadBehavior instantiates the bulk of this table.
---@class State
---@field asm table
---@field mem Register[] The list of registers, including Signal, Visual, Store, Goto, and the unit's component registers and the parameters of this instruction.
---@field main Behavior | table<integer, Code> The code this instruction is running in.
---@field counter integer Determines which exec path, defined in `args`, to follow after execution is finished. Default is `1`.
---@field lastcounter integer 
---@field regs integer Number of registers. The length of `state.main.parameters`
---@field returns table | nil A subroutine call stack. elements are {state.counter, state.asm, #state.mem, state.lastcounter, sub}
State = {}


data.instructions.my_custom_instruction =
{
	---A simple template instruction designed to show as many features as possible.
	---@param comp Component
	---@param state State
	---@param cause integer Is sometimes set to a CC_ prefixed global flag.
	---@param value1 Register
	---@param value2 Register
	---@param out_result Register
	func = function(comp, state, cause, value1, value2, out_result)
		local val1 = GetNum(comp, state, value1)
		local val2 = GetNum(comp, state, value2)
		print("value1", val1)
		print("value2", val2)
		print("value1 + value2 = ", val1 + val2)
		Set(comp, state, out_result, { num = value1 + value2 })
	end,

	---@see data.instruction_argument_filters
	--- { "in"|"out"|"exec", name(string), description(string), data.instruction_argument_filters, is_extra_param(bool) }
	args = {
		{ "in", "Value", "Some Description", "num" },
		{ "in", "Value", "Another Description", "num" },
		{ "out", "Number", "Result" },
	},
	name = "My Custom Instruction",
	desc = "Does nothing of value.",
	category = "Custom",
	icon = "Main/skin/Icons/Special/Commands/Compare Values.png",
}
local _M = {}
local word_maps = {}
local group_maps = {}
local default_configs = {}

local function random_bg_color()
	local r = math.random(0, 255)
	local g = math.random(0, 255)
	local b = math.random(0, 255)
	return string.format("#%02X%02X%02X", r, g, b)
end

local function craete_highlight_group()
	local random = math.random(0, 67998)
	local group_name = "mg_highlight_" .. random
	local cmd = "highlight " .. group_name .. " guibg=" .. random_bg_color()
	vim.cmd(cmd)
	return {
		group_name = group_name,
	}
end

function _M.setup(config) end

function _M.mark(word)
	local cur_word = word or vim.fn.expand("<cword>")
	if word_maps[word] then
		_M.clear(word_maps[word])
	end
end

function _M.clear(item)
	vim.fn.matchdelete(item.match_id)
	item.word = nil
	item.match_id = nil
end

function _M.clear_all()
	for _, item in ipairs(group_maps) do
		if item.match_id then
			_M.clear(item)
		end
	end
end

function _M.next() end

function _M.prev() end

return _M

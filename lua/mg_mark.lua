local _M = {}
local vim = vim
local word_maps = {}

local function random_bg_color()
	local r = math.random(0, 255)
	local g = math.random(0, 255)
	local b = math.random(0, 255)
	return string.format("#%02X%02X%02X", r, g, b)
end

local function create_highlight_group()
	local random = math.random(0, 67998)
	local group_name = "mg_highlight_" .. random
	local cmd = "highlight " .. group_name .. " guibg=" .. random_bg_color()
	vim.cmd(cmd)
	return group_name
end

function _M.setup(config) end

function _M.mark(iword)
	local word = iword or vim.fn.expand("<cword>")
	if word_maps[word] and word_maps[word].match_id then
		_M.clear(word_maps[word])
		word_maps[word] = nil
		return
	end

	local group_name = create_highlight_group()
	local match_id = vim.fn.matchadd(group_name, "\\<" .. word .. "\\>")
	word_maps[word] = {
		group_name = group_name,
		match_id = match_id,
	}
end

function _M.clear(item)
	vim.fn.matchdelete(item.match_id)
	local cmd = "highlight " .. item.group_name .. " NONE"
	vim.cmd(cmd)
end

function _M.clear_all()
	for _, item in pairs(word_maps) do
		if item and item.match_id then
			_M.clear(item)
		end
	end
	word_maps = {}
end

function _M.next(iword)
	local word = iword or vim.fn.expand("<cword>")
	if word_maps[word] == nil or word_maps[word].match_id == nil or word_maps[word].group_name == nil then
		return
	end

	if vim.fn.search(word, "W") == 0 then
		vim.cmd("norm! gg")
		vim.fn.search(word, "W")
	end
end

function _M.prev(iword)
	local word = iword or vim.fn.expand("<cword>")
	if word_maps[word] == nil or word_maps[word].match_id == nil or word_maps[word].group_name == nil then
		return
	end

	if vim.fn.search(word, "bW") == 0 then
		vim.cmd("norm! G")
		vim.fn.search(word, "bW")
	end
end

return _M

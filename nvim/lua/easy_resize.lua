local v_size = 5
local h_size = 2

local is_last_in_row  = function()
    if vim.fn.winnr('1l') == vim.fn.winnr() then
        return true
    end
    return false
end

local is_first_in_col = function()
    if vim.fn.winnr('1k') == vim.fn.winnr() then
        return true
    end
    return false
end

local is_last_in_col = function()
    if vim.fn.winnr('1j') == vim.fn.winnr() then
        return true
    end
    return false
end

local right_resize = function()
    if is_last_in_row() then
        vim.cmd("vertical resize " .. "-" .. v_size)
    else
        vim.cmd("vertical resize " .. "+" .. v_size)
    end
end

local left_resize = function()
    if is_last_in_row() then
        vim.cmd("vertical resize " .. "+" .. v_size)
    else
        vim.cmd("vertical resize " .. "-" .. v_size)
    end
end

local up_resize = function()
    if is_last_in_col() then
        vim.cmd("horizontal resize " .. "+" .. h_size)
    else
        vim.cmd("horizontal resize " .. "-" .. h_size)
    end
end

local down_resize = function()
    if is_last_in_col() then
        vim.cmd("horizontal resize " .. "-" .. h_size)
    else
        vim.cmd("horizontal resize " .. "+" .. h_size)
    end
end

return {
    left_resize = left_resize,
    right_resize = right_resize,
    up_resize = up_resize,
    down_resize = down_resize
}

vim.ui.select = function (items, opts, on_choice)
    assert(type(on_choice) == "function", "on_choice must be a function")
    opts = opts or {}

    ---@type snacks.picker.finder.Item[]
    local finder_items = {}
    for idx, item in ipairs(items) do
        local text = (opts.format_item or tostring)(item)
        table.insert(finder_items, {
            formatted = text,
            text = idx .. " " .. text,
            item = item,
            idx = idx,
        })
    end

    local title = opts.prompt or "Select"
    title = title:gsub("^%s*", ""):gsub("[%s:]*$", "")
    local completed = false

    ---@type snacks.picker.finder.Item[]
    return Snacks.picker.pick({
        source = "select",
        items = finder_items,
        format = Snacks.picker.format.ui_select(opts.kind, #items),
        title = title,
        prompt = " Select :: ",
        layout = {
            preset = "ivy",
            preview = false,
            layout = {
                height = math.min(#items, 13),
            },
        },
        win = {
            input = {
                keys = {
                    ["<tab>"] = { "complete_from_selected", mode = { "i", "n" }, desc = "complete from selected" }
                },
            },
        },
        actions = {
            complete_from_selected = function (picker, item)
                local new_prompt = item.item
                vim.api.nvim_buf_set_lines(picker.input.win.buf, 0, -1, false, { new_prompt })
                vim.api.nvim_win_set_cursor(picker.input.win.win, { 1, #new_prompt })
                picker:find()
            end,
            confirm = function (picker, item)
                if completed then
                    return
                end
                completed = true
                picker:close()
                vim.schedule(function ()
                    on_choice(item and item.item, item and item.idx)
                end)
            end,
        },
        on_close = function ()
            if completed then
                return
            end
            completed = true
            vim.schedule(on_choice)
        end,
    })
end

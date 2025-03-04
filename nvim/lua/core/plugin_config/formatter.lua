require('formatter').setup(
    {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
            python = {
                require("formatter.filetypes.python").black,
                function()
                    local util = require("formatter.util")
                    return {
                        exe = "isort",
                        args = {
                            "--quiet",
                            "--",
                            util.escape_path(util.get_current_buffer_file_path())
                        },
                        stdin = false
                    }
                end,
                -- require("formatter.filetypes.python").isort,
            },
            ["*"] = {
                require("formatter.filetypes.any").remove_trailing_whitespace
            }
        }
    }
)

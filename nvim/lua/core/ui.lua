vim.opt.list = true
vim.opt.mouse = ""
vim.opt.listchars = table.concat(
    {
        'tab:├─',
        'trail:␣',
        'extends:→',
        'precedes:←',
        'nbsp:◊',
    },
    ","
)
vim.opt.title = true
vim.opt.foldcolumn = '5'
vim.opt.background = 'dark'
vim.opt.cmdheight = 2
vim.opt.scrolloff = 7
vim.opt.wildmenu = true
vim.opt.wildignore = table.concat(
    {
        '*.lnk',
        '*~',
        '*.bak',
        '*.pyc',
        '*/.hg/*',
        '*/.svn/*',
        '*/env/*',
        '*.egg-info/*',
        '*/__pycache__/*',
        'doc/_build/*',
    },
    ','
)
vim.opt.wildmode = 'longest:full,full'
vim.opt.shada = "%,'50,<100,n~/.local/state/nvim/shada-local"
vim.opt.pastetoggle = "<F3>"
vim.opt.modeline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.showcmd = true
-- vim.opt.timeout
-- timeoutlen=1000
-- ttimeoutlen=100
vim.opt.backspace = 'indent,eol,start'
-- vim.opt.tags=./tags;

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:3'
vim.opt.showbreak = ' … '

vim.opt.textwidth = 79

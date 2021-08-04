local gl = require 'galaxyline'
local gls = gl.section
local fileinfo = require 'galaxyline.provider_fileinfo'
local fn = vim.fn

local cl = {
    blue = '#4078f2',
    green = '#50a14f',
    crimson = '#ca1243',
    violet = '#a626a4',
    mandy = '#e45649',
    lochmara = '#0184bc',
    chelseaGem = '#986801',
    dodgerBlue = '#526fff',
    fg = '#494b53',
    bg = '#dfdfdf'
}

gl.short_line_list = {'toggleterm', 'dashboard', 'vim-plug'}

local mode_map = {
    ['n'] = {'NORMAL', cl.blue},
    ['i'] = {'INSERT', cl.green},
    ['R'] = {'REPLACE', cl.crimson},
    ['v'] = {'VISUAL', cl.violet},
    ['V'] = {'V-LINE'},
    ['c'] = {'COMMAND', cl.mandy},
    ['s'] = {'SELECT', cl.lochmara},
    ['S'] = {'S-LINE'},
    ['t'] = {'TERMINAL', cl.chelseaGem},
    [''] = {'V-BLOCK'},
    [''] = {'S-BLOCK'},
    ['Rv'] = {'VIRTUAL', cl.dodgerBlue},
    ['rm'] = {'--MORE'}
}

local function buffer_not_empty() return fn.empty(fn.expand('%:t')) ~= 1 end
local function mode_label() return mode_map[fn.mode()][1] or 'N/A' end
local function mode_hl() return mode_map[fn.mode()][2] or cl.fg end
local function is_file() return buffer_not_empty() and vim.bo.filetype ~= '' end
local function in_git_repo()
   local vcs = require('galaxyline.provider_vcs')
   local branch_name = vcs.get_git_branch()
   return branch_name ~= nil
end
local function highlight(group, fg, bg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
    if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
    vim.cmd(cmd)
end

gls.left = {
  {Ws = {provider = function() return ' ' end, highlight = 'GalaxyViMode'}},
  {
    BufferNumber = {
      provider = 'BufferNumber',
      separator = ' ',
      separator_highlight = 'GalaxyViMode',
      highlight = 'GalaxyViMode'
    }
  },
  {
    ViMode = {
      provider = function()
      local modehl = mode_hl()
        highlight('GalaxyViMode', cl.bg, modehl, 'bold')
        highlight('GalaxyViModeInv', modehl, cl.bg, 'bold')
        return string.format(' %s ', mode_label())
      end,
      separator = ' ',
      separator_highlight = 'GalaxyViModeInv'
    }
  },
  {
    GitIcon = {
      provider = function() return ' ' end,
      condition = in_git_repo,
      highlight = {cl.crimson, cl.bg}
    }
  },
  {
    GitBranch = {
      provider = function()
        local vcs = require('galaxyline.provider_vcs')
        local branch_name = vcs.get_git_branch()
        if (string.len(branch_name) > 28) then
          return string.sub(branch_name, 1, 25) .. "..."
        end
          return branch_name .. " "
      end,
      condition = in_git_repo,
      highlight = {cl.fg, cl.bg},
      separator = ' ',
      separator_highlight = {cl.blue, cl.bg}
    }
  },
  {
    FileIcon = {
      provider = 'FileIcon',
      condition = is_file,
      highlight = {
        require('galaxyline.provider_fileinfo').get_file_icon_color,
          cl.bg
      }
    }
  },
  {
    FileName = {
      provider = function()
        if not buffer_not_empty() then return '' end
        local fname = fn.fnamemodify(fn.expand '%', ':~:.')
        if #fname == 0 then return '' end
        if vim.bo.readonly then
          fname = fname .. ' ' .. ''
        end
        if vim.bo.modified then
          fname = fname .. ' ' .. ''
        end
        return ' ' .. fname .. ' '
      end,
      condition = is_file,
      highlight = {cl.blue, cl.bg},
      separator = '',
      separator_highlight = {cl.blue, cl.bg}
    }
  },
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {cl.crimson, cl.bg}
    }
  },{Space = {provider = function() return ' ' end, highlight = {cl.bg, cl.bg}}},
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {cl.chelseaGem, cl.bg}
    }
  },{Space = {provider = function() return ' ' end, highlight = {cl.bg, cl.bg}}},
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = '  ',
      highlight = {cl.green, cl.bg}
    }
  },{Space = {provider = function() return ' ' end, highlight = {cl.bg, cl.bg}}},
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {cl.blue, cl.bg}
    }
  }
}

gls.right = {
    {
        DiffAdd = {
            provider = 'DiffAdd',
            icon = ' ',
            condition = in_git_repo,
            highlight = {cl.green, cl.bg}
        }
    }, {
        DiffModified = {
            provider = 'DiffModified',
            icon = ' ',
            condition = in_git_repo,
            highlight = {cl.mandy, cl.bg}
        }
    }, {
        DiffRemove = {
            provider = 'DiffRemove',
            icon = ' ',
            condition = in_git_repo,
            highlight = {cl.crimson, cl.bg}
        }
    }, {
        FileType = {
            provider = function()
                if not buffer_not_empty() then return '' end
                return string.format(' %s ', vim.bo.filetype)
            end,
            condition = is_file,
            highlight = {cl.fg, cl.bg},
            separator = '',
            separator_highlight = {cl.blue, cl.bg}
        }
    }, {
        PositionInfo = {
            provider = function()
                return string.format(' %s:%s ', fn.line('.'), fn.col('.'))
            end,
            highlight = 'GalaxyViMode',
            condition = buffer_not_empty,
            separator = '',
            separator_highlight = 'GalaxyViModeInv'
        }
    }, {
        PercentInfo = {
            provider = fileinfo.current_line_percent,
            highlight = 'GalaxyViMode',
            condition = buffer_not_empty,
            separator = '',
            separator_highlight = 'GalaxyViMode'
        }
    }
}

gls.short_line_left = {
    {Ws = {provider = function() return ' ' end, highlight = 'GalaxyViMode'}}, {
        ViMode = {
            provider = function()
                local modehl = mode_hl()
                highlight('GalaxyViMode', cl.blue7, modehl, 'bold')
                highlight('GalaxyViModeInv', modehl, cl.bg, 'bold')
                return string.format(' %s ', mode_label())
            end,
            separator = ' ',
            separator_highlight = 'GalaxyViModeInv'
        }
    }
}

gl.load_galaxyline()

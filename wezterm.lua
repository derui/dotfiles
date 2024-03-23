local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Moralerspace Neon HWNF'
config.font_size = 14

-- fishを利用しておく
config.default_prog = { '/bin/fish', '-l' }
-- 色はmodus-viventiをベースにする
config.colors = {
   -- The default text color
  foreground = '#ffffff',
  -- The default background color
  background = '#0d0e1c',
  selection_fg = '#005e8b',
  selection_bg = '#bfefff',
  cursor_bg = '#005e8b',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#bfefff',
  
  ansi = {
    '#000000',
    '#ff5f59',
    '#44bc44',
    '#d0bc00',
    '#2fafff',
    '#feacd0',
    '#00d3d0',
    '#ffffff',
  },
  brights = {
    '#1d2235',
    '#ff5f5f',
    '#44df44',
    '#efef00',
    '#338fff',
    '#ff66ff',
    '#00eff0',
    '#989898',
  },
}

-- キーバインド
local act = wezterm.action

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.leader = { key = 't', mods = 'CTRL' }
config.keys = {
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  {
    key = 'a',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'activate_pane',
      one_shot = false,
    },
  },

  -- paneの移動は一級市民としておく
  {
     key = 'j',
     mods = 'LEADER',
     action = act.ActivatePaneDirection 'Down',
  },
  {
     key = 'k',
     mods = 'LEADER',
     action = act.ActivatePaneDirection 'Up',
  },
  {
     key = 'h',
     mods = 'LEADER',
     action = act.ActivatePaneDirection 'Left',
  },
  {
     key = 'l',
     mods = 'LEADER',
     action = act.ActivatePaneDirection 'Right',
  },
  -- tabを追加する
  {
    key = 'n',
    mods = 'LEADER',
    action = act.SpawnTab 'DefaultDomain',
  },
  { key = ',', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = '.', mods = 'LEADER', action = act.ActivateTabRelative(1) },

  -- pane関連の設定
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 't',
    mods = 'LEADER|CTRL',
    action = wezterm.action.PaneSelect {},
  },

  -- copy modeの起動
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode,
  }
}

-- LEADER + 1-8 でタブを移動する
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end


config.key_tables = {
  -- Defines the keys that are active in our resize-pane mode.
  -- Since we're likely to want to make multiple adjustments,
  -- we made the activation one_shot=false. We therefore need
  -- to define a key assignment for getting out of this mode.
  -- 'resize_pane' here corresponds to the name="resize_pane" in
  -- the key assignments above.
  resize_pane = {
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },

  -- Defines the keys that are active in our activate-pane mode.
  -- 'activate_pane' here corresponds to the name="activate_pane" in
  -- the key assignments above.
  activate_pane = {
    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },

    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },

    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },

    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },

  },
}

return config

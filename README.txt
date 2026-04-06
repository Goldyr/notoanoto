NOTOANOTO

small nvim plugin to create/edit notes, done via lua
Tested with lazy.nvim not sure how compatible vim.pack is yet

return {
  'Goldyr/notoanoto',
  opts = {
    notes_path = '~/Documents/notes',
  },
}

notes_path defines the location of your notes

for local testing:

return {
  dir = '~/Projects/notoanoto',
  name = 'notoanoto',
  opts = {
   notes_path = '~/Documents/notes',
  },
}

links:
lazy nvim
https://github.com/folke/lazy.nvim
TJ neovim plugin from scratch
https://www.youtube.com/watch?v=VGid4aN25iI

<div align="center">

# pushqrdx's dotfiles

A minimalistic (almost) unopinionated configs for my terminal life

![Preview](https://github.com/pushqrdx/dotfiles/raw/master/screenshots/vim.png)

</div>

# Vim

> If you're using neovim copy `.vimrc` into your `init.vim`

* Theme: [vim-cinnabar](https://github.com/vimoxide/vim-cinnabar) *
* Config: [.vimrc](https://github.com/pushqrdx/dotfiles/blob/master/.vimrc) *

### Desclaimer

You need to read and understand the changes i made because even though
i try be as close to vanilla vim as possible, there's still changes that
deviate from that.

### Features

* My own *sensible* defaults
   * `<Space>` as leader
   * `Y` Yanks from cursor to the end of the line, like normal mode `D`
   * Reduced timouts in vim
   * Automatic normal/insert modes relative line number switching
   * More Emacs keybindings in insert/command modes (`<C-k>`, `<C-e>`, `<C-a>`, `<C-u>`)
   * Disable auto insert comment
   * Backup, Swap, Undo enabled and saved into `.vim` folder next to `.vimrc` or `init.vim`
* Leader
   * `p` Vifm as quick file opener/drawer
   * `bn`, `bp` Cycle through active buffers ignoring terminal and closed buffers
   * `v` quickly open your vimrc
* `Tab` in normal mode, toggle folds
* `Q` in normal mode, quickly repeat last macro 
* `<C-Space>` for quick mark
* Repeat last action on selected (visual) lines without losing selection
* `<bar>` to quickly create a vertical split
* Indent/De-dent in visual mode without losing selection
* `<M-o>`. `<M-O>` insert line above/below without entering insert mode
* `<M-p>`. `<M-P>` put above/below current line
* More range selectors `'_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#'`
* `<C-s>` save (easier than `:w<CR>`)
* `<C-q>` quit
* `<C-(h, j, k, l)>` instead of `<C-w>...`

### Curated plugins

* Colorscheme `vim-cinnabar`
* Indentation detection `vim-indent-detector`
* Indentation textobject `vim-indent-object`
* Complete words from buffer in `%s/` `vim-sherlock`
* Easily use `f, F, t, T` with `vim-quickscope`
* Lighweight [Statusline](https://github.com/pushqrdx/dotfiles/raw/master/screenshots/vim.png) with my fork of `vim-spaceline`
* Quickly align stuff `vim-lion`
* Create directories if non existent `vim-mkdir`

### Questions

> Colors aren't as they're in the picture

You will need `termguicolors` compatible terminal in order to have accurate colors. Or gui version (MacVim, gVim, etc)

> Why all the repos are cloned into vimoxide?

I like to lock down updates and curate changes that suites my needs, mostly for stability, However all cloned repos should have names that are identical, and links that point, to the original

> Is there a terminal color profiles?

I'll be releasing iTerm, Alacritty and other terminal profiles with the color scheme if anyone is interested in them. If you like customizing your own terminal colors here's the palette:-

#### Normal Colors

|Color|Hex|
|:-|:-|
|Black|#000000|
|Red|#e04128|
|Green|#5da602|
|Yellow|#cfad00|
|Blue|#417ab3|
|Magenta|#88658d|
|Cyan|#02aa91|
|White|#dbded8|

#### Bright Colors

|Color|Hex|
|:-|:-|
|Black|#676965|
|Red|#f44135|
|Green|#7cb934|
|Yellow|#fcea60|
|Blue|#83afd8|
|Magenta|#bc93b6|
|Cyan|#38e7be|
|White|#f1f1ef|

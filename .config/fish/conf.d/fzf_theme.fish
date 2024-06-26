# ~/.config/fish/functions/fzf.fish
function update_fzf_theme --on-variable background_mode
  if [ "$background_mode" = "dark" ]

    # --color=fg:#908caa,bg:#232136,hl:#ea9a97
    # --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97

    # https://github.com/rose-pine/fzf/blob/main/dist/rose-pine-moon.fish
    set -Ux FZF_DEFAULT_OPTS "
    --color=fg:#908caa,bg:-1,hl:#ea9a97
    --color=fg+:#e0def4,bg+:-1,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

  else if [ "$background_mode" = "light" ]

    # https://github.com/rose-pine/fzf/blob/main/dist/rose-pine-dawn.fish
    # --color=fg:#797593,bg:#faf4ed,hl:#d7827e
    # --color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
    set -Ux FZF_DEFAULT_OPTS "
    --color=fg:#797593,bg:-1,hl:#d7827e
    --color=fg+:#575279,bg+:-1,hl+:#d7827e
    --color=border:#dfdad9,header:#286983,gutter:#faf4ed
    --color=spinner:#ea9d34,info:#56949f,separator:#dfdad9
    --color=pointer:#907aa9,marker:#b4637a,prompt:#797593"

  end
end


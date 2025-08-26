$env.config.edit_mode = 'vi'

# Disable prompt from Nushell Because it is duplicated with that of Starship
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""

# Use cursor shapes to differentiate instead
$env.config.cursor_shape.vi_insert = "blink_line"
$env.config.cursor_shape.vi_normal = "blink_block"

# use /Users/alex/.cache/starship/init.nu
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source /Users/alex/.cache/zoxide/init.nu
source /Users/alex/.cache/carapace/init.nu

# Nushell Environment Config File

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'}
$env.PROMPT_COMMAND_RIGHT = {|| "" }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Use starship prompt
$env.STARSHIP_SHELL = "nu"

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    # ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    # ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

$env.PATH = ($env.PATH | split row (char esep) | prepend [
  '/usr/local/go/bin'
  '/usr/local/bin'
  $"($env.HOME)/.local/share/coursier/bin"
  $"($env.HOME)/go/bin/"
  $"($env.HOME)/bin"
  $"($env.HOME)/local/.bin"
  $"($env.HOME)/.config/fnm"
  $"($env.HOME)/.cargo/bin"
  $"($env.HOME)/google-cloud-sdk/bin"
  #'/home/linuxbrew/.linuxbrew/bin'
  #'/home/linuxbrew/.linuxbrew/sbin'
  #$"($env.HOME)/.pyenv/shims"
])

$env.JAVA_HOME = (cs java-home)

$env.EDITOR = 'nvim'

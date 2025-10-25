# set NU_OVERLAYS with overlay list, useful for starship prompt
$env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt | append {||
  let overlays = overlay list | slice 1..
  if not ($overlays | is-empty) {
    $env.NU_OVERLAYS = $overlays | str join ", "
  } else {
    $env.NU_OVERLAYS = null
  }
})

zoxide init nushell | save -f ~/.zoxide.nu
$env.EDITOR = "nvim"

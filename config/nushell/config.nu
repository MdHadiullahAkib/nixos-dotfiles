let carapace_completer = {|spans|
               carapace $spans.0 nushell ...$spans | from json
               }
               $env.config = {
                show_banner: false,
                completions: {
                case_sensitive: false # case-sensitive completions
                quick: false    # set to false to prevent auto-selecting completions
                partial: true    # set to false to prevent partial filling of the prompt
                algorithm: "fuzzy"    # prefix or fuzzy
                external: {
                # set to false to prevent nushell looking into $env.PATH to find more suggestions
                    enable: true
                # set to lower can improve completion performance at the cost of omitting some options
                    max_results: 100
                    completer: $carapace_completer # check 'carapace_completer' 
                  }
                }
               }
               $env.PATH = ($env.PATH |
               split row (char esep) |
               prepend /home/akib/.apps |
               append /usr/bin/env
)

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# set NU_OVERLAYS with overlay list, useful for starship prompt
$env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt | append {||
  let overlays = overlay list | slice 1..
  if not ($overlays | is-empty) {
    $env.NU_OVERLAYS = $overlays | str join ", "
  } else {
    $env.NU_OVERLAYS = null
  }
})

  if (( 'WAYLAND_DISPLAY' not-in $env ) and ($env.XDG_VTNR == '1')) {
    exec Hyprland
  }

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

alias "balkama" = sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-minipc-btw
source ~/.zoxide.nu

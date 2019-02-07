# https://github.com/albertz/dotfiles/blob/master/.config/fish/config.fish
egrep "^export " ~/.profile | while read e
	set var (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\1/")
	set value (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\2/")

	# remove surrounding quotes if existing
	set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

	if test $var = "PATH"
		# replace ":" by spaces. this is how PATH looks for Fish
		set value (echo $value | sed -E "s/:/ /g")

		# use eval because we need to expand the value
		eval set -xg $var $value

		continue
	end

	# evaluate variables. we can use eval because we most likely just used "$var"
	set value (eval echo $value)

	#echo "set -xg '$var' '$value' (via '$e')"
	set -xg $var $value
end

# install fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# change location of packages installed by fisher
set -g fisher_path ~/.config/fish/fisher-pkg

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file ^ /dev/null
end

# disable virtualenv's original prompt
set -g VIRTUAL_ENV_DISABLE_PROMPT "1"
# enable virtualenv if exists
if test -f ~/.virtualenv/bin/activate.fish
    . ~/.virtualenv/bin/activate.fish
end

# Load opam config if it exists
if test -f ~/.opam/opam-init/init.fish
    builtin source ~/.opam/opam-init/init.fish
end

# Enable cargo with rustup
if test -f ~/.cargo/env
    builtin source ~/.cargo/env
end
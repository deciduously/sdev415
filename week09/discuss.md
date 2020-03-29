I'm going to walk through my personal `~/.bashrc` initialization file.  I am running a relatively new installation, and made a concious choice this time around to only tweak things as needs arise and not just for the heck of it, so this should be relatively clean.

My current operating system in the [Pop_OS!](https://system76.com/pop) spin of Ubuntu 19.10.

At the top, some Ubuntu-provided set up.  First, the hashbang:

```bash
#!/usr/bin/env bash
```

This directs Linux to the `bash` executable when running this file.  This is an essential component, clearly.

Next, the standard check to ensure this is indeed an interactive shell.  If it isn't this file should not be sourced.

```bash
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac
```

This is also an essential component.  Not all shells are interactive shells - this allows us to create subshells, such as the shell that is created when you *run* a bash script.  For these, we do not want to run any of this initialziation, as it wastes time and resources and may enable settings that are explicitly not desired in a non-interactive shell.

This next section is entirely provided by the [bash-it](https://github.com/Bash-it/bash-it) plugin framework.  This is similar in spirit to [oh-my-zsh](https://ohmyz.sh/), but I feel fairly strongly about keeping it purely `bash`.  Luckily, there's this option!  I won't go into detail about each line in this section, it's all pre-populated boilerplate.  I have commented out some unused sections entirely, but left them commented in case I should decide differently in the future.

```bash
# Path to the bash it configuration
export BASH_IT="/home/ben/.bash_it"

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
# export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
```

Some highlights here are the paths, as well as the setting for your TMUX bar.  TMUX is a terminal multiplexer that allows you to split your terminal window, or even detach from a shell session and run it in the background of your OS, and hop back in later.  I tend to always launch tmux when using the terminal, it's great to be able to multitask even if you're running a long job.

This snippet also unsets `MAILCHECK`, a feature I do not use.

Finally, this is the stuff I've added myself.  I'm trying to keep this small.

```bash
eval "$(starship init bash)"
```

I use [`starship`](https://starship.rs/) to automatically manage my `$PS1` variable.  It contains information about my current directory's git status as well as the versions of any compilers and interpreters it finds configured for the local project.  There is an animation demoing some features at that linked webpage.  To use it, you just need to call it during initialization.

Next up, some aliases:

```bash
function ls() {
	exa "$@"
}

function npm() {
    pnpm "$@"
}
```

Exa is a rewqrite of the "ls" command with the same API, and pnpm is a package manager for the JS/npm ecosystem that attempts to conserve space via symbolic links instead of pulling whole new cop[ies of re-used libraries into each new project directory.

I have a few aliases:

```bash
alias u='sudo apt update && sudo apt full-upgrade'
alias rup='rustup update && cargo install-update -a'

dockstprm () {
    docker stop $1 && docker rm $1
}

tag_deciduously () {
    docker tag $1 deciduously0/deciduously-com:$2
}

alias h=history
```

Those docker commands are pretty lazy - I should really get around to making them more general but for now I only use DockerHub for one single project and haven't cared to spend more time on this.

That `h=history` alias is straight outta SDEV-415 - thanks for the idea!  Finally, a few last scripts to call.  `broot` is a rewritten version of the `tree` command, and `asdf` is a toolchain manager that is extensible for a variety of programming languages.  This le

Also, the `.` character is shorthand for the `source` command.  I should not have mixed styles like this, it's gross and I should be ashamed of myself.

```bash
source /home/ben/.config/broot/launcher/bash/br

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

#MMIXWARE
export PATH="$PATH:/home/ben/mmixware"
```

The final line adds a toolchain's path to my shells `$PATH` so that I can execute things found there without specifying a complete path, `bash` will know to look for it there when invoked.  Some of the other scripts like `asdf.bash` also add their own paths to `$PATH`, it's just hidden from the top-level script.

Works cited:

Baker, Jason "How to set your $PATH variable in Linux" opensource.com 17 Jun 2017 https://opensource.com/article/17/6/set-path-linux

“Source Command.” Source Command - Linux Shell Scripting Tutorial - A Beginner's Handbook, 8 Apr. 2012, bash.cyberciti.biz/guide/Source_command.

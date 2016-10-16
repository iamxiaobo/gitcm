# Git Config Manager

# Table of Contents 

 - [Introduce](#introduce)
   - [How it works](#how-it-works)
   - [Support platform](#support-platform)
 - [Installation](#installation)
   - [Install script](#install-script)
   - [Verify installation](#verify-installation)
   - [Manual install](#manual-install)
 - [Usage](#usage)
   - [.gitcmrc](#gitcmrc)
   - [Deeper Shell Integration](#deeper-shell-integration)
 - [License](#license)

## Introduce
Gitcm is a tool manager your gitconfig. In v0.x versions, It's mainly to solve one problem: auto configure `user.name` and `user.email` for your git repository.
Why need to solve this problem? think about this, we use company email and name to commit code in work time, but not want use same configuration at lease `user.name` and `user.email` to commit code such as github or someone else. Surely you could change diretory to your git repository and use `git config ...`, but if you forgot then something wrong may happeded. So let's use gitcm to avoid the problem.

### How it works
We know that when commit code, git will lookup configuration from these places: `.git/config`, `$HOME/.gitconfig`, `/etc/gitconfig`. If `$HOME/.gitconfig` is used for company, and we create a new project in `$HOME/github/awesome_project `, after push code to remote repository and then found forgot to configure user.name and user.email, thus your company email and name list in your git log, so sad. - -
Gitcm will find .gitcmrc in current path or parents path, if found, `user.name` and `user.email` would be configured to your current git repository by commands. If you are using zsh, through some code in .zshrc, gitcm will auto affect git config without use commands.

### Support platform
Gitcm supports `Linux` and Linux like system such as MacOS, not supports window for now.

## Installation
Gitcm doesn't need other dependencies, you can use below methods to ininstall gitcm.

### Install script
To install gitcm, you can use the [install script](https://raw.githubusercontent.com/suniaoo/gitcm/master/install.sh) using cURL:

```sh
curl -o- https://raw.githubusercontent.com/suniaoo/gitcm/master/install.sh  | bash
```

or Wget:

```sh
wget -qO- https://raw.githubusercontent.com/suniaoo/gitcm/master/install.sh | bash
```

<sub>
The script clones the gitcm repository to `~/.gitcm` and adds the source line to your profile (`~/.bash_profile`, `~/.zshrc`, `~/.profile`, or `~/.bashrc`).
</sub>

### Manual install
For manual install create a folder somewhere in your filesystem with the `gitcm.sh` file inside it. I put mine in `~/.gitcm`.

Or if you have `git` installed (requires git v1.7+):

1. clone this repo
1. check out the latest version
1. activate gitcm by sourcing it from your shell

```sh
export GITCM_DIR="$HOME/.gitcm" && (
  git clone https://github.com/suniaoo/gitcm.git "$GITCM_DIR"
  cd "$GITCM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
) && . "$GITCM_DIR/gitcm.sh"
```

Add these lines to your `~/.bashrc`, `~/.profile`, or `~/.zshrc` file to have it automatically sourced upon login:
(you may have to add to more than one of the above files)

```sh
export GITCM_DIR="$HOME/.gitcm"
[ -s "$GITCM_DIR/gitcm.sh" ] && . "$GITCM_DIR/gitcm.sh" # This loads gitcm
```

### Verify Installation
To verify that gitcm has been installed, do:
```sh
command -v gitcm
```

which should output 'gitcm' if the installation was successful. Please note that `which gitcm` will not work, since `gitcm` is a sourced shell function, not an executable binary.


## Usage
First, you need a .gitcmrc file in your directory. For example, your work directory is `~/work`, there are many project in this diretory, usually you need do `git cnofig` for each project in their directory. Also your personal direcyory is `~/dev`, you need to `git config` for each project too.Through gitcm, just need a .gitcmrc file in your `~/work` with the user.name and user.email used for your company, and another .gitcmrc file in `~/dev` config the user.name and user.email for your personal. then just commit your code without doubt.

To init gitcm config, do this:
```sh
gitcm init
```
According the interactive shell, finish the init job.

Manual make gitcmrc work, do this:
```sh
gitcm use
```

Print current gitcm config, do this:
```sh
gitcm ls
```

Print gitcm version, do this:
```sh
gitcm --version
```

Get help information, do this:
```sh
gitcm help
```

### .gitcmrc
The file format is like this:

```sh
name=your name
email=your email
```

This file usually advise generate by `gitcm init`, if your need revise, use editor to change it such as vi, sublime and others. 

### .Deeper Shell Integration
#### Calling `gitcm use` automatically in a direcyory with `.gitcmrc` file
Put this init your `$HOME/.zshrc` to call `gitcm use` automatically whenever you enter or leave a direcyory.

``` 
add-zsh-hook chpwd load-gitcm
load-gitcm
```


## License
gitcm is released under the MIT license.

Copyright (c) 2016 sunxiaobo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

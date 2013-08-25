# pw-vim : PerfectWorks's Vim Distribution

 ______   __     __        __   __   __     __    __    
    /\  == \ /\ \  _ \ \      /\ \ / /  /\ \   /\ "-./  \   
    \ \  _-/ \ \ \/ ".\ \     \ \ \'/   \ \ \  \ \ \-./\ \  
     \ \_\    \ \__/".~\_\     \ \__|    \ \_\  \ \_\ \ \_\ 
      \/_/     \/_/   \/_/      \/_/      \/_/   \/_/  \/_/ 
                                                        

[pw-vim] is a distribution of vim plugins and resources for Vim, Gvim and [MacVim], an forked repository from [spf13-vim].

# Installation

## Linux, \*nix, Mac OSX Installation

The easiest way to install pw-vim is to use our [automatic installer](https://raw.github.com/perfectworks/pw-vim/master/bootstrap.sh) by simply copying and pasting the following line into a terminal. This will install pw-vim and backup your existing vim configuration. If you are upgrading from a prior version (before 3.0) this is also the recommended installation.

```bash
    curl https://raw.github.com/perfectworks/pw-vim/master/bootstrap.sh -L -o - | sh
```

## Installing on Windows

On Windows and \*nix [Git] and [Curl] are required. Also, if you haven't already, you'll need to install [Vim].

### Installing dependencies

#### Install [msysgit]

After installation try running `git --version` within _command prompt_ (press Win-R,  type `cmd`, press Enter) to make sure all good:

    C:\> git --version
    git version 1.7.4.msysgit.0

#### Setup [Curl]
_Instructions blatently copied from vundle readme_
Installing Curl on Windows is easy as [Curl] is bundled with [msysgit]!
But before it can be used with [NeoBundle] it's required make `curl` run in _command prompt_.
The easiest way is to create `curl.cmd` with [this content](https://gist.github.com/912993)

    @rem Do not use "echo off" to not affect any child calls.
    @setlocal

    @rem Get the abolute path to the parent directory, which is assumed to be the
    @rem Git installation root.
    @for /F "delims=" %%I in ("%~dp0..") do @set git_install_root=%%~fI
    @set PATH=%git_install_root%\bin;%git_install_root%\mingw\bin;%PATH%

    @if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
    @if not exist "%HOME%" @set HOME=%USERPROFILE%

    @curl.exe %*


And copy it to `C:\Program Files\Git\cmd\curl.cmd`, assuming [msysgit] was installed to `c:\Program Files\Git`

to verify all good, run:

    C:\> curl --version
    curl 7.21.1 (i686-pc-mingw32) libcurl/7.21.1 OpenSSL/0.9.8k zlib/1.2.3
    Protocols: dict file ftp ftps http https imap imaps ldap ldaps pop3 pop3s rtsp smtp smtps telnet tftp
    Features: Largefile NTLM SSL SSPI libz


#### Installing pw-vim on Windows

The easiest way is to download and run the pw-vim-windows-install.cmd file. Remember to run this file in **Administrator Mode** if you want the symlinks to be created successfully.

## Updating to the latest version
The simpliest (and safest) way to update is to simply rerun the installer. It will completely and non destructively upgrade to the latest version.

```bash

    curl https://raw.github.com/perfectworks/pw-vim/master/bootstrap.sh -L -o - | sh

```

Alternatively you can manually perform the following steps. If anything has changed with the structure of the configuration you will need to create the appropriate symlinks.

```bash
    cd $HOME/to/pw-vim/
    git pull
    vim +NeoBundleInstall! +NeoBundleClean +q
```

## Customization

Create `~/.vimrc.local` and `~/.gvimrc.local` for any local
customizations.

For example, to override the default color schemes:

```bash
    echo colorscheme ir_black  >> ~/.vimrc.local
```

### Fork Customization

There is an additional tier of customization available to those who want to maintain a
fork of pw-vim specialized for a particular group. These users can create `.vimrc.fork`
and `.vimrc.bundles.fork` files in the root of their fork.  The load order for the configuration is:

1. `.vimrc.bundles.local` - local user bundle configuration
2. `.vimrc.bundles.fork` - fork bundle configuration
3. `.vimrc.bundles` - pw-vim bundle configuration
4. `.vimrc` - pw-vim vim configuration 
5. `.vimrc.fork` - fork vim configuration
6. `.vimrc.local` - local user configuration

See `.vimrc.bundles` for specifics on what options can be set to override bundle configuration. See `.vimrc` for specifics
on what options can be overridden. Most vim configuration options should be set in your `.vimrc.fork` file, bundle configuration
needs to be set in your `.vimrc.bundles.fork` file.

You may also want to update your `README.markdown` file so that the `bootstrap.sh` link points to your repository and your `bootstrap.sh`
file to pull down your fork.

# Plugins

pw-vim contains a curated set of popular vim plugins, colors, snippets and syntaxes. Great care has been made to ensure that these plugins play well together and have optimal configuration.

## Adding new plugins

Create `~/.vimrc.bundles.local` for any additional bundles.

To add a new bundle

```bash
    echo NeoBundle \'spf13/vim-colors\' >> ~/.vimrc.bundles.local
```

## Removing (disabling) an included plugin

Create `~/.vimrc.local` if it doesn't already exist.

Add the NeoBundleDisable command to this line. It takes the same input as the Bundle line, so simply copy the line you want to disable and add 'Un' to the beginning.

For example, disabling the 'AutoClose' and 'scrooloose/syntastic' plugins

```bash
    echo NeoBundleDisable \'AutoClose\' >> ~/.vimrc.local
    echo NeoBundleDisable \'scrooloose/syntastic\' >> ~/.vimrc.local
```

**Remember to run ':NeoBundleClean!' after this to remove the existing directories**

# Difference betweet pw-vim and [spf13-vim]

Main changes:

* Use [Unite] instead [ctrlp].
* Map `jj` to `<ESC>`.
* Add block search support.
* Map `<F7>` and `<F8>` to jump in `location-list`.
* Swap `0` and `^`, `0` is more convenience.
* Use my favorite color theme [molokai] instead [solarized].
* Remove a dozen language support plugins such like ruby, scala, twig, cucumber.
* Remove some useless plugin: [neocomplcache], [tagbar], [Syntastic].
* Reset some Vim settings to default:
    * Unbind vim register and system clipboard.
    * Remove `options` from `viewoptions`.
    * `nospell`.
    * `wrap`.
    * `scrolljump` to 0.
    * `scrolloff` to 0.
* Key mapping
    * Unmap `<C-J>`, `<C-K>`, `<C-L>`, `<C-H>`.
    * Unmap `<` and `>`.
    * Unmap `j`/`k`.
* Add a new bundle group `fenbi` for my team.

The reason is very simple: I don't need them.

# Bundle group `fenbi`

The bundle group `fenbi` is some plugin used by our team, so fell free to disable this group if you is not in our team.

# Fork me on GitHub

I'm always happy to take pull requests from others. Go ahead and fork me.

[Git]:http://git-scm.com
[Curl]:http://curl.haxx.se
[Vim]:http://www.vim.org/download.php#pc
[msysgit]:http://code.google.com/p/msysgit
[MacVim]:http://code.google.com/p/macvim/
[pw-vim]:https://github.com/perfectworks/pw-vim
[spf13-vim]:https://github.com/spf13/spf13-vim
[contributors]:https://github.com/spf13/spf13-vim/contributors

[NeoBundle]:https://github.com/Shougo/neobundle.vim
[PIV]:https://github.com/spf13/PIV
[NERDCommenter]:https://github.com/scrooloose/nerdcommenter
[Undotree]:https://github.com/mbbill/undotree
[NERDTree]:https://github.com/scrooloose/nerdtree
[ctrlp]:https://github.com/kien/ctrlp.vim
[solarized]:https://github.com/altercation/vim-colors-solarized
[neocomplcache]:https://github.com/shougo/neocomplcache
[Fugitive]:https://github.com/tpope/vim-fugitive
[Surround]:https://github.com/tpope/vim-surround
[Tagbar]:https://github.com/majutsushi/tagbar
[Syntastic]:https://github.com/scrooloose/syntastic
[vim-easymotion]:https://github.com/Lokaltog/vim-easymotion
[Matchit]:http://www.vim.org/scripts/script.php?script_id=39
[Tabularize]:https://github.com/godlygeek/tabular
[EasyMotion]:https://github.com/Lokaltog/vim-easymotion
[Airline]:https://github.com/bling/vim-airline
[Powerline]:https://github.com/lokaltog/powerline
[Powerline Fonts]:https://github.com/Lokaltog/powerline-fonts

[spf13-vim-img]:https://i.imgur.com/UKToY.png
[spf13-vimrc-img]:https://i.imgur.com/kZWj1.png
[autocomplete-img]:https://i.imgur.com/90Gg7.png
[tagbar-img]:https://i.imgur.com/cjbrC.png
[fugitive-img]:https://i.imgur.com/4NrxV.png
[nerdtree-img]:https://i.imgur.com/9xIfu.png
[phpmanual-img]:https://i.imgur.com/c0GGP.png
[easymotion-img]:https://i.imgur.com/ZsrVL.png
[airline-img]:https://i.imgur.com/sU0PG5P.png

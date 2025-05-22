#!/usr/bin/env fish

set cmd $argv[1]
set repo_result (pkgfile -b $cmd 2>/dev/null)
set aur_result (yay -Qs "^$cmd\$" 2>/dev/null)

if test -n "$repo_result"
    set full_pkg (echo $repo_result | awk '{print $1}')
    set repo_pkg (string split '/' $full_pkg)[2]

    if test -n "$repo_pkg"
        set_color yellow
        echo -e "⚠️  Command '$cmd' not found."
        set_color cyan
        echo -e "💡 Found in repo: $full_pkg"
        set_color normal
        read -l -P "📦 Install '$repo_pkg'? [Y/n] " confirm
        if test "$confirm" = "y" -o "$confirm" = "Y" -o "$confirm" = ""
            echo "📦 Installing..."
            yay -S $repo_pkg
        end
    else
        set_color red
        echo -e "❌ Unable to extract package name."
        set_color normal
    end

else if test -n "$aur_result"
    set_color yellow
    echo -e "⚠️  Command '$cmd' not found."
    set_color magenta
    echo -e "💡 Found in AUR:"
    yay -Ss $cmd | grep -A2 "$cmd" | head -n 5
    set_color normal
    read -l -P "📦 Install '$cmd' from AUR? [Y/n] " confirm
    if test "$confirm" = "y" -o "$confirm" = "Y" -o "$confirm" = ""
        echo "📦 Installing..."
        yay -S $cmd
    end

else
    set_color red
    echo -e "❌ Command '$cmd' not found and no package found."
    set_color normal
end


if status is-login; and status is-interactive
    ssh-add -l >/dev/null || ssh-add --apple-load-keychain &>/dev/null
end

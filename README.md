# \$HOME

```
$ sh -c "$(curl -fsLS get.chezmoi.io)"
$ chezmoi init agjacome --apply --exclude externals
$ chezmoi apply --include externals
$ gpg --import $HOME/.gnupg/private_keys.pgp
```

### TODO

- Manage chezmoi and all required programs through nix home-manager

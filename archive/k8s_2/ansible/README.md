# Ansible

# Install via pipx (which requires Python, which can best be installed on windows with Scoop)


### Scoop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

### Python

```powershell
scoop install python
```

### pipx

```powershell
scoop install pipx
pipx ensurepath
```

### Ansible

```powershell
pipx install --include-deps ansible
```
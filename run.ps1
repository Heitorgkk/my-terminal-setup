# arquivo para re-executar as configurações sem passar pela etapa de instalação novamente

Write-Host "Recarregando configurações..." -ForegroundColor Green

Copy-Item "$env:MY_TERMINAL_SETUP\configs\profile.ps1" $PROFILE -Force
Copy-Item "$env:MY_TERMINAL_SETUP\configs\config.jsonc" "$env:USERPROFILE\.config\fastfetch" -Force

Start-Sleep -M 500

powershell
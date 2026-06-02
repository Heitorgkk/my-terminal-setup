# arquivo para re-executar as configurações sem passar pela etapa de instalação novamente

Write-Host "Recarregando configurações..." -ForegroundColor Green

Copy-Item ".\configs\profile.ps1" $PROFILE -Force
Copy-Item ".\configs\config.jsonc" "$env:USERPROFILE\.config\fastfetch" -Force

Start-Sleep -M 500

powershell
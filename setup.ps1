Write-Host "Bem vindo ao meu setup de personalizacao do Powershell" -ForegroundColor Green
Write-Host ""
Write-Host "Instalando dependencias..."
Write-Host ""


# criar arquivo profile para personalizar promt
$profilePath = Split-Path -Parent $PROFILE
if (!(Test-Path $profilePath)) {
    New-Item -ItemType Directory -Path $profilePath -Force
}

# copiar profile do setup
Copy-Item ".\profile.ps1" $PROFILE -Force


Write-Host "Arquivo Profile instalado em: " -NoNewLine -ForegroundColor Blue
Write-Host "$PROFILE" -ForegroundColor DarkMagenta
Write-Host ""

Write-Host "Instalando Fastfetch..."
winget install Fastfetch-cli.Fastfetch --source winget --disable-interactivity

# atualizar PATH dps do winget instalar o fastfetch

$env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# gerar arquivo de conf inicial
fastfetch --gen-config "$env:USERPROFILE\.config\fastfetch\config.jsonc"

# copiar arquivo de configuração do fastfetch
Copy-Item ".\config.jsonc" "$env:USERPROFILE\.config\fastfetch"

Write-Host "Fastfetch instalado e configurado com sucesso!"
Write-Host ""

# desbloquear execução do profile (por conta do execution policy)
Unblock-File -Path $PROFILE

Write-Host "Ambiente personalizado instalado com sucesso!" -ForegroundColor Green

timeout /t -1
Clear-Host

powershell
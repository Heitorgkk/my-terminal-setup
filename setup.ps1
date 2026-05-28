Write-Host "Bem vindo ao meu setup de personalização do Powershell" -ForegroundColor Green
Write-Host ""
Write-Host "Instalando dependências..."
Write-Host ""

# criar variavel de ambiente com path do projeto
$env:MY_TERMINAL_SETUP = Get-Location

# criar arquivo profile para personalizar promt
$profilePath = Split-Path -Parent $PROFILE
if (!(Test-Path $profilePath)) {
    New-Item -ItemType Directory -Path $profilePath -Force
}

# copiar profile do setup
Copy-Item ".\profile.ps1" $PROFILE -Force
Write-Host "Arquivo Profile instalado em: " -NoNewLine -ForegroundColor Blue
Write-Host "$PROFILE" -ForegroundColor DarkMagenta


Write-Host "Instalando Fastfetch..."
winget install Fastfetch-cli.Fastfetch --source winget --disable-interactivity

# atualizar PATH dps do winget instalar o fastfetch
$env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# gerar arquivo de conf inicial
fastfetch --gen-config "$env:USERPROFILE\.config\fastfetch\config.jsonc"

# copiar arquivo de configuração do fastfetch
Copy-Item ".\config.jsonc" "$env:USERPROFILE\.config\fastfetch"

Write-Host "Fastfetch instalado e configurado com sucesso!"

# Desbloquear todos os arquivos do diretorio, veja Get-Help Unblock-File para mais detalhes

Get-ChildItem | Unblock-File
Get-ChildItem .\functions | Unblock-File


Write-Host "Ambiente personalizado instalado com sucesso!"

Start-Sleep -Seconds 2
Clear-Host

powershell
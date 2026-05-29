Write-Host "Bem vindo ao meu setup de personalizacao do Powershell" -ForegroundColor Green
Write-Host ""
Write-Host "Instalando dependencias..."
Write-Host ""

# criar variavel de ambiente com path do projeto
$projectDir = Get-Location

[System.Environment]::SetEnvironmentVariable(
    "MY_TERMINAL_SETUP",
    $projectDir,
    "User"
)

# criar arquivo profile para personalizar promt
$profilePath = Split-Path -Parent $PROFILE
if (!(Test-Path $profilePath)) {
    New-Item -ItemType Directory -Path $profilePath -Force
}

# copiar profile do setup
Copy-Item ".\configs\profile.ps1" $PROFILE -Force
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
Copy-Item ".\configs\config.jsonc" "$env:USERPROFILE\.config\fastfetch"

Write-Host "Fastfetch instalado e configurado com sucesso!"
Write-Host ""

# Desbloquear todos os arquivos do diretorio, veja Get-Help Unblock-File para mais detalhes

Get-ChildItem | Unblock-File
Get-ChildItem .\functions | Unblock-File
Get-ChildItem .\configs | Unblock-File


Write-Host "Ambiente personalizado instalado com sucesso!" -ForegroundColor Green

Write-Host "AVISO: O primeiro run pode causar um erro com relação aos paths, mas só ocorre uma vez" -ForegroundColor DarkRed

timeout /t -1
Clear-Host

powershell
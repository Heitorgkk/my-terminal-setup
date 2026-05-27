Write-Host "Bem vindo ao meu setup de personalização do Powershell" -ForegroundColor Red
Write-Host ""
Write-Host "Instalando dependências..."
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


Write-Host "Instalando Fastfetch..."
winget install Fastfetch-cli.Fastfetch --source winget --nowarn --disable-interactivity

# definir arquivo de configuração do fastfetch para .\config
powershell
fastfetch --config .\config.jsonc

Clear-Host
Write-Host "Fastfetch instalado e configurado com sucesso!"

# permitir executar scripts
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

Write-Host "Ambiente personalizado instalado com sucesso!"
powershell
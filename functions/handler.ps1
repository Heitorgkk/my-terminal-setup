$projectDir = $env:MY_TERMINAL_SETUP
$configs    = "$projectDir\configs"
$themes     = "$projectDir\themes"

function MYS-Switch {
    param(
        [Parameter(Mandatory)]
        [string]$Theme
    )

    $promptSrc  = "$themes\prompt-themes\$Theme.ps1"
    $fastSrc    = "$themes\fastfetch-themes\$Theme.jsonc"

    $promptDest = "$configs\profile.ps1"
    $fastDest   = "$configs\config.jsonc"

    if (-not (Test-Path $promptSrc)) {
        Write-Host "[MYS] Tema '$Theme' não encontrado em prompt-themes." -ForegroundColor Red
        return
    }

    Copy-Item -Path $promptSrc -Destination $promptDest -Force

    if (Test-Path $fastSrc) {
        Copy-Item -Path $fastSrc -Destination $fastDest -Force
    } else {
        Write-Host "[MYS] Aviso: sem tema fastfetch para '$Theme', mantendo o atual." -ForegroundColor DarkYellow
    }

    [System.Environment]::SetEnvironmentVariable("MY_TERMINAL_THEME", $Theme, "User")
    $env:MY_TERMINAL_THEME = $Theme

    Write-Host "[MYS] Tema '$Theme' aplicado. Recarregando..." -ForegroundColor Green
    . "$projectDir\run.ps1"
}

# mostrar temas disponíveis
function MYS-List {
    $available = Get-ChildItem "$themes\prompt-themes" -Filter "*.ps1" |
                 Select-Object -ExpandProperty BaseName

    Write-Host "Temas disponíveis:" -ForegroundColor Green

    $available | ForEach-Object {
        
        $marker = if ($_ -eq $env:MY_TERMINAL_THEME) { " <- ativo" } else { "" }
        
        Write-Host "  $_$marker" -ForegroundColor White
    }

}
# NOTA DO AUTOR: ESTE ARQUIVO FOI GERADO COM IA

# ─────────────────────────────────────────
#  diagnostics.ps1
#  Funções de diagnóstico do ambiente
# ─────────────────────────────────────────


# Mostra todas as entradas do PATH, uma por linha
function Show-Path {
    Write-Host "`n PATH entries:" -ForegroundColor Cyan
    $env:PATH -split ";" | ForEach-Object {
        if ($_ -ne "") {
            $exists = Test-Path $_
            $color = if ($exists) { "Green" } else { "DarkRed" }
            $icon  = if ($exists) { "  V" } else { "  X" }
            Write-Host "$icon  $_" -ForegroundColor $color
        }
    }
}


# Mostra variáveis de ambiente (filtra por prefixo opcional)
function Show-Env {
    param (
        [string]$Filter = ""
    )

    Write-Host "`n Variáveis de ambiente:" -ForegroundColor Cyan

    Get-ChildItem Env: |
        Where-Object { $_.Name -like "*$Filter*" } |
        Sort-Object Name |
        ForEach-Object {
            Write-Host "  " -NoNewline
            Write-Host $_.Name -NoNewline -ForegroundColor DarkMagenta
            Write-Host " = " -NoNewline -ForegroundColor DarkGray
            Write-Host $_.Value -ForegroundColor Gray
        }
}


# Recarrega o PATH do registro do Windows (útil após winget instalar algo)
function Refresh-Path {
    $env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")
    Write-Host " PATH recarregado." -ForegroundColor Green
}


# Mostra informações gerais do sistema !!!!! TA DANDO UM ERRO MUITO ABSURDO SLA
function Show-SysInfo {

    $os   = Get-CimInstance Win32_OperatingSystem
    $cpu  = Get-CimInstance Win32_Processor | Select-Object -First 1
    $ram  = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    $free = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $used = [math]::Round($ram - $free, 2)
    $uptime = (Get-Date) - $os.LastBootUpTime

    Write-Host ""
    Write-Host "  ╔══════════════════════════════════╗" -ForegroundColor DarkCyan
    Write-Host "  ║         System Info              ║" -ForegroundColor DarkCyan
    Write-Host "  ╚══════════════════════════════════╝" -ForegroundColor DarkCyan

    Write-Host "   User     : " -NoNewline -ForegroundColor DarkGray
    Write-Host "$env:USERNAME @ $env:COMPUTERNAME" -ForegroundColor Blue

    Write-Host "   OS       : " -NoNewline -ForegroundColor DarkGray
    Write-Host $os.Caption -ForegroundColor Gray

    Write-Host "   CPU      : " -NoNewline -ForegroundColor DarkGray
    Write-Host $cpu.Name -ForegroundColor Gray

    Write-Host "   RAM      : " -NoNewline -ForegroundColor DarkGray
    Write-Host "${used}GB | ${ram}GB" -ForegroundColor Gray

    Write-Host "   Uptime   : " -NoNewline -ForegroundColor DarkGray
    Write-Host ("{0}d {1}h {2}m" -f $uptime.Days, $uptime.Hours, $uptime.Minutes) -ForegroundColor Gray

    Write-Host "   Profile  : " -NoNewline -ForegroundColor DarkGray
    Write-Host $PROFILE -ForegroundColor DarkMagenta
    Write-Host ""

}






# Verifica se um comando está disponível no PATH
function Check-Command {
    param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    $found = Get-Command $Name -ErrorAction SilentlyContinue
    if ($found) {
        Write-Host "V '$Name' encontrado em: " -NoNewline -ForegroundColor Green
        Write-Host $found.Source -ForegroundColor Gray
    } else {
        Write-Host "X '$Name' não encontrado no PATH." -ForegroundColor Red;
    }
}

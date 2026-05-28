# NOTA DO AUTOR: ESTE ARQUIVO FOI GERADO COM IA

# ─────────────────────────────────────────
#  prompt-utils.ps1
#  Utilitários de personalização do prompt
# ─────────────────────────────────────────


# Esquemas de cores disponíveis para o prompt
$script:PromptThemes = @{
    kali = @{
        bracket  = "DarkGray"
        user     = "Blue"
        at       = "Cyan"
        host     = "Blue"
        path     = "DarkMagenta"
        arrow    = "DarkGray"
    }
    matrix = @{
        bracket  = "DarkGreen"
        user     = "Green"
        at       = "Green"
        host     = "Green"
        path     = "Green"
        arrow    = "DarkGreen"
    }
    dracula = @{
        bracket  = "DarkGray"
        user     = "Magenta"
        at       = "DarkGray"
        host     = "Cyan"
        path     = "Yellow"
        arrow    = "DarkGray"
    }
    minimal = @{
        bracket  = "DarkGray"
        user     = "Gray"
        at       = "DarkGray"
        host     = "Gray"
        path     = "White"
        arrow    = "DarkGray"
    }
}

# Tema ativo (padrão: kali)
$script:ActiveTheme = "kali"


# Aplica um tema ao prompt
function Set-PromptTheme {
    param (
        [Parameter(Mandatory)]
        [ValidateSet("kali", "matrix", "dracula", "minimal")]
        [string]$Theme
    )

    if ($script:PromptThemes.ContainsKey($Theme)) {
        $script:ActiveTheme = $Theme
        Write-Host " Tema '$Theme' aplicado." -ForegroundColor Cyan
    } else {
        Write-Host " Tema '$Theme' não encontrado." -ForegroundColor DarkRed
    }
}


# Lista os temas disponíveis com preview de cores
function Show-Themes {
    Write-Host "`n Temas disponíveis:`n" -ForegroundColor Cyan

    foreach ($themeName in $script:PromptThemes.Keys) {
        $t = $script:PromptThemes[$themeName]
        $active = if ($themeName -eq $script:ActiveTheme) { " < ativo" } else { "" }

        Write-Host ""  [$themeName]$active"" -ForegroundColor White
        Write-Host "    " -NoNewline
        Write-Host "┌──(" -NoNewline -ForegroundColor $t.bracket
        Write-Host "user" -NoNewline -ForegroundColor $t.user
        Write-Host "@" -NoNewline -ForegroundColor $t.at
        Write-Host "host" -NoNewline -ForegroundColor $t.host
        Write-Host ")-[" -NoNewline -ForegroundColor $t.bracket
        Write-Host "~/pasta" -NoNewline -ForegroundColor $t.path
        Write-Host "]" -ForegroundColor $t.bracket
        Write-Host "    " -NoNewline
        Write-Host "└──" -NoNewline -ForegroundColor $t.arrow
        Write-Host "$ " -ForegroundColor $t.arrow
        Write-Host ""
    }
}


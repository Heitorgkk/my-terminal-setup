Clear-Host
Write-Host ""
fastfetch --config "$env:USERPROFILE\.config\fastfetch\config.jsonc"
Write-Host ""

function prompt {
    $user = $env:USERNAME
    $hostName = $env:COMPUTERNAME
    $path = Split-Path -Leaf (Get-Location)

    Write-Host "┌──(" -NoNewline -ForegroundColor DarkGray
    Write-Host "${user}" -NoNewline -ForegroundColor White
    Write-Host "@" -NoNewline -ForegroundColor DarkGray
    Write-Host "${hostName}" -NoNewline -ForegroundColor White
    Write-Host ")-[" -NoNewline -ForegroundColor DarkGray
    Write-Host "$path" -NoNewline -ForegroundColor Gray
    Write-Host "]" -ForegroundColor DarkGray

    Write-Host "└──" -NoNewline -ForegroundColor DarkGray
    return "$ "
}

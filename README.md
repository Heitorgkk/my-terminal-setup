# My Terminal Setup!

Customização de terminal no PowerShell com foco em visual limpo, estilo Linux/Kali e reutilização fácil.

<div align="center">

![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white) ![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white) ![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

### Previews

<img src=".\assets\preview1.png" width=100%>
<img src=".\assets\preview2.png" width=100%>
<img src=".\assets\preview3.png" width=100%>


</div>




---

## Estrutura

```
.
├── config.json     # Configuração do fastfetch
├── profile.ps1     # Configuração do powershell profile 
├── setup.ps1       # Script de instalação
├── README.md       
└── assets(D)        
```

---

## Instalação

Para aplicar essa configuração em qualquer máquina Windows:

```powershell
.\setup.md
```

O script vai:

- Copiar o `.profile.ps1` para o caminho correto do    PowerShell (`$PROFILE`)
- Configurar permissões de execução
- Preparar o ambiente automaticamente



> **Atenção**
> Possíveis erros com relação a Política de Execução (`Get-ExecutionPolicy -list`) 


---

## Customização do Prompt

A aparência do terminal é controlada pela função `prompt` dentro de `$PROFILE`:

```powershell
function prompt {
    # variaveis para colocar no terminal
    $user = $env:USERNAME
    $hostName = $env:COMPUTERNAME
    $path = Split-Path -Leaf (Get-Location)

    # construção da linha
    Write-Host "┌──(" -NoNewline -ForegroundColor DarkGray
    Write-Host "${user}" -NoNewline -ForegroundColor Blue
    Write-Host "@" -NoNewline -ForegroundColor Cyan
    Write-Host "${hostName}" -NoNewline -ForegroundColor Blue
    Write-Host ")-[" -NoNewline -ForegroundColor DarkGray
    Write-Host "$path" -NoNewline -ForegroundColor DarkMagenta
    Write-Host "]" -ForegroundColor DarkGray

    Write-Host "└──" -NoNewline -ForegroundColor DarkGray

    return "$ "
}
```

### Como mudar as cores

Cada parte do prompt usa:

```powershell
-ForegroundColor <COR>
```

Para alterar, basta trocar o nome da cor no final da linha. Exemplo:

```powershell
Write-Host "${user}" -NoNewline -ForegroundColor Green
```

### 🎨 Cores disponíveis

| Cor            | Variante escura  |
|----------------|------------------|
| `Black`        | `DarkGray`       |
| `Gray`         | —                |
| `White`        | —                |
| `Red`          | `DarkRed`        |
| `Green`        | `DarkGreen`      |
| `Blue`         | `DarkBlue`       |
| `Cyan`         | `DarkCyan`       |
| `Magenta`      | `DarkMagenta`    |
| `Yellow`       | `DarkYellow`     |

---

## Objetivo

Criar um ambiente:

- **Bonito**
- **Rápido de configurar**
- **Reutilizável**
- **Com identidade própria**

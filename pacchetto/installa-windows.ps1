# Installer dell'agente coach per Windows (fase di test, senza marketplace).
# Si avvia con doppio clic su installa-windows.cmd.
# Si può rilanciare per aggiornare: sostituisce il plugin, non tocca la memoria.

$ErrorActionPreference = 'Stop'
$Pkg        = Split-Path -Parent $MyInvocation.MyCommand.Path
$PluginDest = Join-Path $env:USERPROFILE '.agente-coach\plugin'
$Desktop    = [Environment]::GetFolderPath('Desktop')
$Instanza   = Join-Path $Desktop 'il mio coach'
$Utf8NoBom  = New-Object System.Text.UTF8Encoding $false

function Stop-Installer($msg) { Write-Host $msg -ForegroundColor Yellow; exit 1 }

Write-Host ''
Write-Host 'Agente coach: installazione'
Write-Host '---------------------------'

if (-not (Test-Path (Join-Path $Pkg 'plugin\coach'))) {
  Stop-Installer 'Non trovo la cartella plugin\coach accanto a questo script. Estrai tutto lo zip (tasto destro > Estrai tutto) e riprova.'
}
if ($Pkg.StartsWith($PluginDest, [StringComparison]::OrdinalIgnoreCase)) {
  Stop-Installer "Estrai lo zip in un'altra cartella (per esempio Download) e rilancia."
}

# 1. Claude Code e Git Bash (Claude Code su Windows lo usa per i comandi e per l'hook di avvio)
$ClaudeCmd = Get-Command claude -ErrorAction SilentlyContinue
if (-not $ClaudeCmd) {
  $candidato = Join-Path $env:USERPROFILE '.local\bin\claude.exe'
  if (Test-Path $candidato) { $ClaudeBin = $candidato }
  else { Stop-Installer 'Claude Code non risulta installato. Installalo da https://code.claude.com/docs/en/setup, fai il primo accesso, poi rilancia.' }
} else {
  $ClaudeBin = $ClaudeCmd.Source
  # installato con npm: Get-Command trova claude.ps1, il collegamento deve puntare a claude.cmd
  if ($ClaudeBin -like '*.ps1') { $ClaudeBin = [IO.Path]::ChangeExtension($ClaudeBin, '.cmd') }
}

$GitBash = @("$env:ProgramFiles\Git\bin\bash.exe", "${env:ProgramFiles(x86)}\Git\bin\bash.exe", "$env:LOCALAPPDATA\Programs\Git\bin\bash.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $GitBash -and -not (Get-Command bash -ErrorAction SilentlyContinue)) {
  Write-Host 'Attenzione: non trovo Git Bash. Senza, l''agente non carica la memoria all''avvio: dovrai scrivere /coach a inizio sessione. Puoi installarlo da https://git-scm.com/download/win' -ForegroundColor Yellow
}

# Modello (facoltativo): variabile COACH_MODEL, oppure quello già nel collegamento di un'installazione precedente.
# Senza nessuno dei due, Claude Code usa il suo modello di default.
$LinkPath = Join-Path $Desktop 'Avvia coach.lnk'
$Modello = $env:COACH_MODEL
if (-not $Modello -and (Test-Path $LinkPath)) {
  $vecchio = (New-Object -ComObject WScript.Shell).CreateShortcut($LinkPath).Arguments
  if ($vecchio -match '--model ([A-Za-z0-9._-]+)') { $Modello = $Matches[1] }
}
if ($Modello -and $Modello -notmatch '^[A-Za-z0-9._-]+$') { Stop-Installer "COACH_MODEL non valido: $Modello" }
$ModelArgs = @()
if ($Modello) { $ModelArgs = @('--model', $Modello); Write-Host "Modello: $Modello" }

# 2. Plugin: copiato (o aggiornato) in %USERPROFILE%\.agente-coach\plugin
if (Test-Path $PluginDest) { Remove-Item -Recurse -Force $PluginDest }
New-Item -ItemType Directory -Force -Path $PluginDest | Out-Null
Copy-Item -Recurse -Force (Join-Path $Pkg 'plugin\*') $PluginDest
$Manifest = Get-Content -Raw -Encoding UTF8 (Join-Path $PluginDest 'coach\.claude-plugin\plugin.json') | ConvertFrom-Json
Write-Host "Plugin $($Manifest.version) copiato in $PluginDest"

# 3. Istanza personale: creata solo se non esiste già
$CoachJson = Join-Path $Instanza 'coach.json'
if (Test-Path $CoachJson) {
  Write-Host 'La tua cartella "il mio coach" esiste già: memoria lasciata com''è.'
} else {
  $Nome = Read-Host 'Come ti chiami? (lo userà l''agente)'
  $Nome = ($Nome -replace '["\\]', '').Trim()
  New-Item -ItemType Directory -Force -Path $Instanza | Out-Null
  Copy-Item -Recurse -Force (Join-Path $PluginDest 'coach\istanza-modello\*') $Instanza
  $testo = [IO.File]::ReadAllText($CoachJson, $Utf8NoBom)
  $testo = $testo.Replace('"cliente": ""', '"cliente": "' + $Nome + '"').Replace('"creata": ""', '"creata": "' + (Get-Date -Format 'yyyy-MM-dd') + '"')
  [IO.File]::WriteAllText($CoachJson, $testo, $Utf8NoBom)
  Write-Host 'Creata la cartella "il mio coach" sul Desktop.'
}
# Il percorso formativo: copiato in memoria solo se non c'e' gia' (le correzioni del cliente restano)
$PercorsoSrc = Join-Path $Pkg 'percorso-ai-talent.md'
$PercorsoDst = Join-Path $Instanza 'memoria\percorso.md'
if ((Test-Path $PercorsoSrc) -and -not (Test-Path $PercorsoDst)) {
  New-Item -ItemType Directory -Force -Path (Join-Path $Instanza 'memoria') | Out-Null
  Copy-Item $PercorsoSrc $PercorsoDst
  Write-Host 'Aggiunto il calendario del percorso in memoria\percorso.md.'
}

# 4. Collegamento "Avvia coach" sul Desktop
$Shell = New-Object -ComObject WScript.Shell
$Link  = $Shell.CreateShortcut($LinkPath)
$Link.TargetPath       = $ClaudeBin
$Link.Arguments        = (($ModelArgs -join ' ') + ' --plugin-dir "' + (Join-Path $PluginDest 'coach') + '" "/coach"').Trim()
$Link.WorkingDirectory = $Instanza
$Link.Description      = 'Agente coach'
$Link.Save()

Write-Host ''
Write-Host 'Fatto. Per partire: doppio clic su "Avvia coach" sul Desktop.'
Write-Host 'All''avvio parla per primo il coach: ti guida lui. Per vedere i comandi: /coach aiuto'
Write-Host ''
$Subito = Read-Host 'Vuoi avviarlo adesso? (s/n)'
if ($Subito -match '^[sS]') {
  Set-Location $Instanza
  & $ClaudeBin @ModelArgs --plugin-dir (Join-Path $PluginDest 'coach') "/coach"
}

#!/usr/bin/env python3
"""Test di struttura del plugin coach. Uso: python3 tests/check_structure.py [cartella-istanza]"""
import json, os, re, subprocess, sys, tempfile, shutil, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
errors = []
def err(m): errors.append(m)

# manifest e hook
for p in ['.claude-plugin/plugin.json', 'hooks/hooks.json', 'istanza-modello/coach.json', '../.claude-plugin/marketplace.json']:
    try: json.loads((ROOT / p).read_text())
    except Exception as e: err(f'JSON non valido: {p}: {e}')
if not os.access(ROOT / 'hooks/session-start.sh', os.X_OK): err('session-start.sh non eseguibile')
if not os.access(ROOT / 'hooks/session-message.sh', os.X_OK): err('session-message.sh non eseguibile')
if 'intake' not in json.loads((ROOT / 'istanza-modello/coach.json').read_text()): err('istanza-modello/coach.json senza campo intake')
PKG = ROOT.parent.parent / 'pacchetto'
for p in ['installa-mac.command', 'installa-windows.cmd', 'installa-windows.ps1', 'LEGGIMI.md', 'costruisci-pacchetto.sh', 'processo-agente-coach.docx']:
    if not (PKG / p).exists(): err(f'pacchetto: manca {p}')
for p in ['installa-mac.command', 'installa-windows.ps1']:
    if (PKG / p).exists() and '"/coach"' not in (PKG / p).read_text(encoding='utf-8-sig'): err(f'pacchetto/{p}: il launcher non passa /coach come primo messaggio')
ver = json.loads((ROOT / '.claude-plugin/plugin.json').read_text())['version']
mk = json.loads((ROOT / '../.claude-plugin/marketplace.json').read_text())['plugins'][0]['version']
if ver != mk: err(f'versione plugin.json ({ver}) diversa da marketplace.json ({mk})')
if f'## {ver} ' not in (ROOT / 'CHANGELOG.md').read_text(): err(f'CHANGELOG senza la versione {ver}')
# l'intake si chiude solo sui criteri di p01, mai sul solo profilo compilato
_p01 = (ROOT / 'skills/coach-sessioni/p01-intake.md').read_text(encoding='utf-8')
if "## Quando l'intake è chiuso" not in _p01: err('p01 senza i criteri di chiusura dell intake')
if 'Ruolo e contesto" è già compilata' in (ROOT / 'commands/coach.md').read_text(encoding='utf-8'): err('coach.md chiude ancora l intake sul profilo compilato')
# il documento di processo nel pacchetto deve essere la versione anonimizzata
import zipfile as _zf
if (PKG / 'processo-agente-coach.docx').exists():
    _x = _zf.ZipFile(PKG / 'processo-agente-coach.docx').read('word/document.xml').decode('utf-8')
    if 'Nota su questa copia' not in _x or 'Mac di Max' in _x: err('pacchetto/processo-agente-coach.docx non è la versione anonimizzata')
if (PKG / 'LEGGIMI.md').exists() and f'versione {ver}' not in (PKG / 'LEGGIMI.md').read_text(): err(f'pacchetto/LEGGIMI.md non cita la versione {ver}')

# core
core = (ROOT / 'core/core.md').read_text()
for s in ['## Cosa non fai mai', '## Imparare dalle correzioni', '## Funzioni opzionali']:
    if s not in core: err(f'core senza sezione {s}')

# skill
skills = sorted((ROOT / 'skills').iterdir())
if len(skills) != 8: err(f'attese 8 skill, trovate {len(skills)}')
nfiles = 0
for d in skills:
    sk = (d / 'SKILL.md').read_text()
    m = re.match(r'---\nname: (\S+)\ndescription: "(.+)"\n---\n', sk)
    if not m: err(f'{d.name}: frontmatter mancante'); continue
    if m.group(1) != d.name: err(f'{d.name}: name diverso dalla cartella')
    if len(m.group(2)) > 1024: err(f'{d.name}: descrizione oltre 1024 caratteri')
    listed = set(re.findall(r'\]\(([a-z]\d\d-[a-z0-9-]+\.md)\)', sk))
    present = {f.name for f in d.glob('[a-z][0-9][0-9]-*.md')}
    if listed != present: err(f'{d.name}: indice e file non coincidono: {listed ^ present}')
    for f in d.glob('[a-z][0-9][0-9]-*.md'):
        nfiles += 1
        t = f.read_text()
        if not t.split('\n')[2].startswith('**Usalo quando:**'): err(f'{f.name}: manca la riga Usalo quando')
        for ref in re.findall(r'`((?:\.\./coach-[a-z]+/)?[a-z]\d\d-[a-z0-9-]+\.md)`', t):
            if not (d / ref).resolve().exists(): err(f'{f.name}: rimando rotto {ref}')
if nfiles != 37: err(f'attesi 37 file di metodo, trovati {nfiles}')

# niente dati personali nel metodo
for f in list((ROOT / 'skills').rglob('*.md')) + [ROOT / 'core/core.md', ROOT / 'commands/coach.md'] + list((ROOT / 'istanza-modello').rglob('*.md')):
    if re.search(r'\bMax\b', f.read_text()): err(f'nome personale nel metodo: {f.relative_to(ROOT)}')

# hook: silenzioso fuori da un'istanza, attivo dentro
env = dict(os.environ, CLAUDE_PLUGIN_ROOT=str(ROOT))
with tempfile.TemporaryDirectory() as tmp:
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-start.sh')], env=dict(env, CLAUDE_PROJECT_DIR=tmp), capture_output=True, text=True)
    if out.stdout.strip(): err('hook non silenzioso fuori da un\'istanza')
    inst = pathlib.Path(tmp) / 'ist'
    shutil.copytree(ROOT / 'istanza-modello', inst)
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-start.sh')], env=dict(env, CLAUDE_PROJECT_DIR=str(inst)), capture_output=True, text=True)
    if '## Cosa non fai mai' not in out.stdout: err('hook: core non caricato')
    if 'calendario' not in out.stdout: err('hook: funzioni da proporre non elencate')
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-message.sh')], env=dict(env, CLAUDE_PROJECT_DIR=tmp), capture_output=True, text=True)
    if out.stdout.strip(): err('session-message non silenzioso fuori da un\'istanza')
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-message.sh')], env=dict(env, CLAUDE_PROJECT_DIR=str(inst)), capture_output=True, text=True)
    try:
        msg = json.loads(out.stdout)['systemMessage']
        if 'prima volta' not in msg: err('session-message: messaggio di primo avvio atteso con intake vuoto')
    except Exception as e: err(f'session-message: output non JSON: {e}')
    cj = inst / 'coach.json'; cj.write_text(cj.read_text().replace('"intake": ""', '"intake": "2026-01-01"'))
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-message.sh')], env=dict(env, CLAUDE_PROJECT_DIR=str(inst)), capture_output=True, text=True)
    if 'prima volta' in out.stdout: err('session-message: messaggio di primo avvio anche con intake fatto')

if len(sys.argv) > 1:
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-start.sh')], env=dict(env, CLAUDE_PROJECT_DIR=sys.argv[1]), capture_output=True, text=True)
    print(f'Hook sull\'istanza {sys.argv[1]}: {len(out.stdout.split())} parole caricate')

if errors:
    print('ERRORI:'); [print(' -', e) for e in errors]; sys.exit(1)
print(f'OK: 8 skill, {nfiles} file di metodo, manifest, hook, core e pacchetto verificati. Versione {ver}.')

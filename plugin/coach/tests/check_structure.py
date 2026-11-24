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
for p in ['installa-mac.command', 'installa-windows.cmd', 'installa-windows.ps1', 'LEGGIMI.md', 'costruisci-pacchetto.sh', 'processo-agente-coach.docx', 'percorso-ai-talent.md']:
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
# 1.3.0: percorso letto all'avvio, schede allineate ai KPI, copia da condividere
if 'percorso.md' not in (ROOT / 'hooks/session-start.sh').read_text(encoding='utf-8'): err('hook: percorso.md non tra i file da leggere')
if 'ORE/MESE LIBERATE' not in (ROOT / 'skills/coach-automazione/a02-valutare-candidato.md').read_text(encoding='utf-8'): err('a02: scheda senza ore/mese liberate')
if '## Copia da condividere' not in (ROOT / 'skills/coach-processi/m07-template-processo.md').read_text(encoding='utf-8'): err('m07: manca la copia da condividere')
if '## Diario leggero' not in (ROOT / 'skills/coach-tempo/t03-metodi-raccolta.md').read_text(encoding='utf-8'): err('t03: manca il diario leggero')
# 1.4.0: tempo nell'accordo e versioni rapide
_core = (ROOT / 'core/core.md').read_text(encoding='utf-8')
if 'quanto tempo ha adesso' not in _core or 'p07' not in _core: err('core: manca il tempo nell accordo o il rimando a p07')
if not (ROOT / 'skills/coach-sessioni/p07-lavoro-a-tempo.md').exists(): err('manca p07-lavoro-a-tempo.md')
# tetto del core: ogni aggiunta obbliga a spostare o togliere qualcosa
_parole = len(_core.split())
if _parole > 1300: err(f'core di {_parole} parole: il tetto è 1300. Sposta le procedure nelle skill prima di aggiungere')
for _f, _h in [('skills/coach-sessioni/p01-intake.md', '## Versione breve'), ('skills/coach-processi/m01-mappare-processo.md', '## Mappa rapida'), ('skills/coach-automazione/a02-valutare-candidato.md', '## Scheda rapida')]:
    if _h not in (ROOT / _f).read_text(encoding='utf-8'): err(f'{_f}: manca {_h}')
# 1.5.0: output standard
for _f in ['r01-filtro.md', 'r02-scrivere-requisiti.md', 'r03-consegna-agenti.md']:
    if not (ROOT / 'skills/coach-requisiti' / _f).exists(): err(f'coach-requisiti: manca {_f}')
_r02 = ROOT / 'skills/coach-requisiti/r02-scrivere-requisiti.md'
if _r02.exists():
    _t = _r02.read_text(encoding='utf-8')
    for _s in ['## 0. Filtro', '## 6. Requisiti', '## 8. Eccezioni', '## 9. Controllo umano', '## 11. Criteri di accettazione', '## 13. Domande aperte', '## Consegna', 'tipo: requisiti']:
        if _s not in _t: err(f'r02: manca {_s}')
if 'coach-requisiti' not in _core: err('core: manca il rimando a coach-requisiti in Chi sei')
if 'dove vuole arrivare' not in _core: err('core: l accordo non chiede dove vuole arrivare')
if '**Dove vuoi arrivare.**' not in (ROOT / 'skills/coach-sessioni/p03-sessione-coaching.md').read_text(encoding='utf-8'): err('p03: manca Dove vuoi arrivare')
_p01 = (ROOT / 'skills/coach-sessioni/p01-intake.md').read_text(encoding='utf-8')
for _phrase in ['che cosa dovrebbe essere diverso nel tuo lavoro', 'Quanto vuoi che ti sfidi', 'Intake in corso', 'Dopo ogni criterio chiuso']:
    if _phrase not in _p01: err(f'p01: manca {_phrase}')
_p02 = (ROOT / 'skills/coach-sessioni/p02-check-in.md').read_text(encoding='utf-8')
if 'Cosa ti ha portato a quel numero?' not in _p02: err('p02: manca la domanda aggiornata sul punteggio')
if 'Perché quel numero e non due in meno?' in _p02: err('p02: contiene ancora la domanda precedente sul punteggio')
_p03 = (ROOT / 'skills/coach-sessioni/p03-sessione-coaching.md').read_text(encoding='utf-8')
if 'documento di specifiche' not in _p03 or 'Cosa ti porti da oggi?' not in _p03: err('p03: manca la spiegazione della requisitazione o la chiusura aggiornata')
_p06 = (ROOT / 'skills/coach-sessioni/p06-scrivere-memoria.md').read_text(encoding='utf-8')
if '5-8 righe' not in _p06: err('p06: manca il recap breve della sessione')
if '## Intestazione comune degli artefatti' not in (ROOT / 'skills/coach-processi/m07-template-processo.md').read_text(encoding='utf-8'): err('m07: manca l intestazione comune')
for _f, _tipo in [('skills/coach-processi/m07-template-processo.md', 'tipo: processo'), ('skills/coach-automazione/a02-valutare-candidato.md', 'tipo: automazione'), ('skills/coach-tempo/t04-leggere-audit.md', 'tipo: time-audit')]:
    if _tipo not in (ROOT / _f).read_text(encoding='utf-8'): err(f'{_f}: modello senza intestazione comune')
if '`requisiti`' not in (ROOT / 'commands/coach.md').read_text(encoding='utf-8'): err('coach.md: manca il comando requisiti')
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
if len(skills) != 9: err(f'attese 9 skill, trovate {len(skills)}')
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
if nfiles != 41: err(f'attesi 41 file di metodo, trovati {nfiles}')

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
        if 'prima conversazione' not in msg: err('session-message: presentazione del primo incontro attesa con intake vuoto')
        if 'file che legge vengono inviati al servizio' not in msg: err('session-message: manca l avviso sull elaborazione remota')
    except Exception as e: err(f'session-message: output non JSON: {e}')
    cj = inst / 'coach.json'; cj.write_text(cj.read_text().replace('"intake": ""', '"intake": "2026-01-01"'))
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-message.sh')], env=dict(env, CLAUDE_PROJECT_DIR=str(inst)), capture_output=True, text=True)
    if 'prima conversazione' in out.stdout: err('session-message: presentazione del primo incontro anche con intake fatto')

if len(sys.argv) > 1:
    out = subprocess.run(['bash', str(ROOT / 'hooks/session-start.sh')], env=dict(env, CLAUDE_PROJECT_DIR=sys.argv[1]), capture_output=True, text=True)
    print(f'Hook sull\'istanza {sys.argv[1]}: {len(out.stdout.split())} parole caricate')

if errors:
    print('ERRORI:'); [print(' -', e) for e in errors]; sys.exit(1)
print(f'OK: {len(skills)} skill, {nfiles} file di metodo, manifest, hook, core e pacchetto verificati. Versione {ver}.')

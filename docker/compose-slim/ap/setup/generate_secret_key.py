'''
config.iniにdjangoのシークレットキーを出力し，ファイルパーミッションを600にする．
config.iniが存在する場合は読み込んでから上書き，存在しない場合は新規作成で．
'''
import configparser
from django.core.management.utils import get_random_secret_key
import os

skey = f'{get_random_secret_key()}{get_random_secret_key()}'.replace('%', '%%')
config = configparser.ConfigParser(interpolation=None)
config.optionxform = str
if os.path.exists('config.ini'):
    config.read('config.ini', encoding='utf-8')

if 'AP' not in config.sections():
    config.add_section('AP')
config.set('AP', 'SECRET_KEY', skey)

with open('config.ini', 'w') as f:
    config.write(f)

os.chmod('config.ini', 0o600)

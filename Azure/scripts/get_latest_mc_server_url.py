import json
import urllib2


def get_latest():
    url = 'https://launchermeta.mojang.com/mc/game/version_manifest.json'
    response = urllib2.urlopen(url)
    content = response.read()
    values = json.loads(content)
    latest = values['latest']['release']
    for version in values['versions']:
        if version['id'] == latest:
            return version['url']


print(get_latest())
import json
import urllib2


def get_latest_info_url():
    url = 'https://launchermeta.mojang.com/mc/game/version_manifest.json'
    response = urllib2.urlopen(url)
    content = response.read()
    values = json.loads(content)
    latest = values['latest']['release']
    for version in values['versions']:
        if version['id'] == latest:
            return version['url']


def get_latest():
    latest_info_url = get_latest_info_url()
    response = urllib2.urlopen(latest_info_url)
    content = response.read()
    values = json.loads(content)
    latest_server_download = values['downloads']['server']['url']
    return latest_server_download

print(get_latest())
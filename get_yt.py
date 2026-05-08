import urllib.request
import re

try:
    url = 'https://www.youtube.com/@hack-hardwareaccelerationc9241/videos'
    html = urllib.request.urlopen(url).read().decode('utf-8')
    matches = re.findall(r'"title":\{"runs":\[\{"text":"(.*?)"\}', html)
    
    seen = set()
    for title in matches:
        if title not in seen:
            seen.add(title)
            print(title)
except Exception as e:
    print(e)

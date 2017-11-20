import json
import bunch
metadata = bunch.Bunch(json.load(open('/'.join(str(__file__).split('/')[:-1])+'/metadata.json')))

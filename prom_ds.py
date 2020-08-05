import json
import requests
import subprocess

tokenholder = open("key.txt", 'w')
args = ['curl', 'http://localhost:3000/api/auth/keys', '-XPOST', '-uadmin:admin', '-H', 'Content-Type: application/json', '-d', '{"role":"Admin","name":"new_api_key"}']
process = subprocess.run(args, stdout=tokenholder)#, stderr=tokenholder)
#print(tokenholder)
tokenholder.close()

tokenholder = open("key.txt", 'r')
token_raw = tokenholder.readline()
tokenholder.close()
token_dict = json.loads(token_raw)
print(token_dict["key"])

token = token_dict["key"]
#token = "eyJrIjoiWExadXNCUlNNT3NaQW1wUGtxeVdCNjZURDhQMDEwUWgiLCJuIjoibmV3X2FwaV9rZXkiLCJpZCI6MX0="

graf_base = "http://localhost:3000/"
headers = {"Content-Type": "application/json", "Authorization": f"Bearer {token}"}


prom_source_url = f"{graf_base}api/datasources"
message = {"name":"prometheus", "type":"prometheus", "url":"http://localhost:9090", "access":"proxy", "basicAuth":False}
response = requests.post(prom_source_url, headers=headers, json=message)
#response = requests.get(prom_source_url, headers=headers)


if response.status_code == 200:
    print(json.loads(response.content.decode('utf-8')))
else:
    #print(response.content.decode('utf-8'))
    print(json.loads(response.content.decode('utf-8')))

dashboard_url = f"{graf_base}api/dashboards/import"
#message =
response = requests.post(dashboard_url, headers=headers, data=open('nodefull.json', 'rb'))
print(json.loads(response.content.decode('utf-8')))


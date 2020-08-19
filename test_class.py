import json
import requests
import subprocess
import time

tokenholder = open("key.txt", 'w')
args = ['curl', 'http://localhost:3000/api/auth/keys', '-XPOST', '-uadmin:admin', '-H', 'Content-Type: application/json', '-d', '{"role":"Admin","name":"new_api_key"}']
process = subprocess.run(args, stdout=tokenholder)
tokenholder.close()

tokenholder = open("key.txt", 'r')
token_raw = tokenholder.readline()
tokenholder.close()
token_dict = json.loads(token_raw)
print(token_dict["key"])
token = token_dict["key"]

graf_base = "http://localhost:3000/"
headers = {"Content-Type": "application/json", "Authorization": f"Bearer {token}"}

dashboard_url = f"{graf_base}api/dashboards/import"

response = requests.post(dashboard_url, headers=headers, data=open('grafana.json', 'rb'))
print(json.loads(response.content.decode('utf-8')))


from flask import Flask, session, redirect, url_for, escape, request
import json


app = Flask(__name__)

@app.route('/notify', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        data = json.loads(request.data)
        #print '\n\ndata:',data["actions"]
        js = data["actions"][0]
        #print 'js:',js
        str = '\"CONTRACT_NAME\" : \"{}\", \"ACTION_NAME\" : \"{}\", \"ACTION_DATA\" : \"{}\",\"IRREVERSIBLE\" : \"{}\"'.format(js["account"],js["name"],js["action_data"],data["irreversible"])
        print '\n\n"MESSAGE" ====>',str
        print '***********************************************************************'
    return "Hello World!"

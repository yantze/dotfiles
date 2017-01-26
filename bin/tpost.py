#!/usr/bin/env python
# -*- coding: utf-8 -*-
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests

def email_alert(first, second, third):
    report = {}
    report["value1"] = first
    report["value2"] = second
    report["value3"] = third
    requests.post("https://maker.ifttt.com/trigger/YourEventName/with/key\
    /YourSecretKey", data=report)    

print("Choose your first string.")
a = input()
print("Choose your second string.")
b = input()
print("Choose your third string.")
c = input()
email_alert(a, b, c)

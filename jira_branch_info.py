from jira import JIRA
import os
import subprocess
import re

token = os.environ.get("JIRA_API_TOKEN") 
jira = JIRA(server='https://visto-tech.atlassian.net/', basic_auth=('andres@visto.ai', token))

r = subprocess.check_output("git branch", shell=True)
for i in r.decode("utf-8").split('\n'):
    i = i.replace("*",'')
    m = re.search(r'([A-Za-z]{2,3})-([0-9]{3})',i.strip())
    if m:
        jira_issue = m.group()
        j = jira.issue(jira_issue)
        print(f"{i.strip()} {j.fields.summary} {j.permalink()}")

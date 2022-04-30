from jira import JIRA
import os
import subprocess
import re
from colorama import Fore, Back, Style


token = os.environ.get("JIRA_API_TOKEN") 
user = os.environ.get("JIRA_USERNAME")
jira_url = os.environ.get("JIRA_URL")

jira = JIRA(server=jira_url, basic_auth=(user, token))

r = subprocess.check_output("git branch", shell=True)
for i in r.decode("utf-8").split('\n'):
    m = re.search(r'([A-Za-z]{2,3})-([0-9]{3})',i.strip())
    if m:
        jira_issue = m.group()
        j = jira.issue(jira_issue)
        print(f"{Fore.GREEN} {i.lstrip()}  {Fore.CYAN}{j.fields.summary} {Fore.RESET}{j.permalink()}")
    else:

        print(f"{Fore.MAGENTA} {i.strip()}")

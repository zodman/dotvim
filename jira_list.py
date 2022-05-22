#!/bin/env python
"""

use the api token from jira: https://id.atlassian.com/manage-profile/security/api-tokens

# add to ~/.bashrc
export JIRA_API_TOKEN=""
export JIRA_USER=""
export JIRA_URL="https://myjira.atlassian.net/"

# install 
pip install jira colorama

"""
from jira import JIRA
import os
import subprocess
import re
from colorama import Fore, Back, Style


token = os.environ.get("JIRA_API_TOKEN") 
user = os.environ.get("JIRA_USER")
jira_url = os.environ.get("JIRA_URL")

jira = JIRA(server=jira_url, basic_auth=(user, token))

result = jira.search_issues(""" (assignee = currentUser() or assignee="alex@visto.ai") and statuscategory IN ("In Progress","New") ORDER BY updated""")
for j in result:
    print(f"{j.key} {j.fields.assignee} {Fore.LIGHTWHITE_EX} {j.fields.status} {Fore.CYAN}{j.fields.summary} {Fore.RESET}{j.permalink()} ")

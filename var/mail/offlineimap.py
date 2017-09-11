#!/usr/bin/env python
# encoding: utf-8

import re

remote_mapping = {
    'INBOX'               : 'Inbox',
    '[Gmail]/Todos'       : 'All',
    '[Gmail]/Enviados'    : 'Sent',
    '[Gmail]/Borradores'  : 'Drafts',
    'Accounts/GMail'      : 'GMail',
    'Accounts/ESEI'       : 'ESEI',
    'Accounts/Others'     : 'Others'
}

local_mapping = {val: key for key, val in remote_mapping.items()}

def translate_remote(folder):
    return remote_mapping[folder]

def translate_local(folder):
    return local_mapping[folder]

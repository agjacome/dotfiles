import re

mapping = { 'INBOX'              : 'inbox',
            '[Gmail]/Todos'      : 'all_mail',
            '[Gmail]/Papelera'   : 'bin',
            '[Gmail]/Borradores' : 'drafts',
            '[Gmail]/Importante' : 'important',
            '[Gmail]/Enviados'   : 'sent_mail',
            '[Gmail]/Spam'       : 'spam',
            '[Gmail]/Destacados' : 'starred',
            '[Gmail]/Trash'      : 'trash' }

r_mapping = {val: key for key, val in mapping.items()}


def nt_remote(folder):
    try:
        return mapping[folder]
    except:
        return re.sub(' ', '_', folder).lower()


def nt_local(folder):
    try:
        return r_mapping[folder]
    except:
        return re.sub('_', ' ', folder).capitalize()


# folderfilter = exclude(['Label', 'Label', ... ])
def exclude(excludes):
    def inner(folder):
        try:
            excludes.index(folder)
            return False
        except:
            return True

    return inner

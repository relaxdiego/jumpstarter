from os.path import basename
import re


def key_username(keypath):
    filename = basename(keypath)

    match = re.search('(.*).keys', filename)

    if match:
        return match.group(1)
    else:
        raise Exception("Invalid path: %s. Must have pattern */*.keys"
                        % keypath)


class FilterModule(object):

    def filters(self):
        return {
            'key_username': key_username
        }

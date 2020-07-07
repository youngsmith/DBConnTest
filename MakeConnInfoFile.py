#!/usr/bin/env python


import os
import sys
import yaml
# --------------------------------------------------------------------
# Main
# --------------------------------------------------------------------
if __name__ == '__main__':
    with open("Person.yaml", 'r') as stream:
        try:
            os.system('echo "" > ConnInfo.txt')
            a = yaml.safe_load(stream)
            for s in a['server']:
                server_ip = s['ip']
                for d in s['DB']:
                    dp_ip = d['ip']
                    query_list = ''
                    for q in d['query']:
                         query_list += q

                    output = '{}, {}, {}'.format(server_ip, dp_ip, query_list)
                    os.system('echo "{}" >> ConnInfo.txt'.format(output))
                    print(output)
            os.system('echo "EOF" >> ConnInfo.txt'.format(output))
        except yaml.YAMLError as exc:
            print(exc)
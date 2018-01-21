#!/usr/bin/python

import i3

def current_workspace():
    workspaces = i3.get_workspaces()
    for w in workspaces:
        if w['focused'] == True:
            return i3.filter(type='workspace',name=w['name'])[0]['num']

def find_tmp():
    tmps = i3.filter(nodes=[], window=None, name=None)
    if len(tmps) != 1:
        return None
    return tmps[0]['id']

def create_tmp(current_id):
    i3.focus(con_id=current_id)
    i3.split('vertical')
    i3.open()

def destroy_tmp(tmp_id):
    i3.kill(con_id=tmp_id)

def make_float(current_id):
    i3.focus(con_id=current_id)
    i3.floating('enable')
    i3.resize('set 1000 1000')
    i3.move('position center')

def make_unfloat(current_id):
    i3.focus(con_id=current_id)
    i3.floating('disable')

def main():
    current = i3.filter(nodes=[], focused=True)[0]
    current_id = current['id']
    if "on" in current['floating']:
        tmp_id = find_tmp()
        if tmp_id != None:
            i3.focus(con_id=tmp_id)
            make_unfloat(current_id)
            destroy_tmp(tmp_id)
        else:
            make_unfloat()
    else:
        if find_tmp() == None:
            create_tmp(current_id)
            make_float(current_id)


main()

#!/usr/bin/env python3
import socket
import i3ipc
from threading import Thread, Event

class BreakoutException(Exception):
    pass

class currws():
    def __init__(self):
        self.i3 = i3ipc.Connection()
        self.i3.on('workspace::focus', self.on_ws_focus)
        self.name=""
        self.event=Event()
        self.event.clear()

    def on_ws_focus(self, i3, event):
        self.name=event.current.name
        self.event.set()

def listen(cws):
    conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    conn.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    conn.bind(('0.0.0.0', 5555))
    conn.listen(10)
    while True:
        try:
            current_conn, address = conn.accept()
            while True:
                data = current_conn.recv(2048)
                if data is None:
                    current_conn.shutdown(1)
                    current_conn.close()
                    break
                elif 'idle' in data.decode():
                    while True:
                        if cws.event.wait():
                            current_conn.shutdown(1)
                            current_conn.close()
                            cws.event.clear()
                            raise BreakoutException
                elif 'get' in data.decode():
                    current_conn.send(cws.name.encode())
                    current_conn.shutdown(1)
                    current_conn.close()
                    break
        except BreakoutException:
            pass

if __name__ == "__main__":
    cws = currws()
    Thread(target=listen, args=(cws,), daemon=True).start()
    Thread(target=cws.i3.main,daemon=False).start()

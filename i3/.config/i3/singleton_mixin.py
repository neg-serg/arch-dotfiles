from threading import Lock

# Based on tornado.ioloop.IOLoop.instance() approach.
# See https://github.com/facebook/tornado
class SingletonMixin(object):
    __singleton_lock = Lock()
    __singleton_instance = None

    @classmethod
    def instance(class_):
        if not class_.__singleton_instance:
            with class_.__singleton_lock:
                if not class_.__singleton_instance:
                    class_.__singleton_instance = class_()
        return class_.__singleton_instance

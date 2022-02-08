# 统一返回接口
from libs.ResultCode import *


# 成功
def success(data=None):
    rpos = SUCCESS()
    rpos["data"] = data
    return rpos


def successCode(code=None, data=None, message=None):
    rpos = {
        "code": code,
        "message": message,
        "data": data
    }
    return rpos


def successMapp(func):
    return func()


# 失败
def error(message=None):
    rpos = ERROR()
    rpos["message"] = message
    return rpos


def errorCode(code=None, message=None):
    rpos = {
        "code": code,
        "message": message,
        "data": None
    }
    return rpos


def errorMapp(func):
    return func()

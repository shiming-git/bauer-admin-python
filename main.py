# coding=utf-8

import tornado.web
import tornado.netutil
import tornado.process
import logging
import os
from tornado.ioloop import IOLoop
from tornado.httpserver import HTTPServer
from tornado.routing import RuleRouter, Rule, PathMatches
from libs.MySqlServe import MysqlUtile
from libs.RedisServer import RedisUtil
from config.configSys import *
from libs import systemInfo

from handlers.sys_tmep.url import url as sys_url
from handlers.online_tmep.url import url as onl_url


def initHandler():
    MysqlUtile()
    RedisUtil()
    logging.info("初始化数据链接完成...")


def initLogging():
    LOG_FORMAT = "%(asctime)s %(name)s %(levelname)s %(pathname)s %(message)s "  # 配置输出日志格式
    DATE_FORMAT = '%Y-%m-%d  %H:%M:%S %a '  # 配置输出时间的格式，注意月份和天数不要搞乱了
    logging.basicConfig(level=logging.DEBUG,
                        format=LOG_FORMAT,
                        datefmt=DATE_FORMAT,
                        )


def getLogo():
    filePath = "banner"
    if os.path.exists(filePath):
        f = None
        try:
            f = open(filePath, 'r', encoding="UTF-8")
            print(f.read())
        finally:
            if f:
                f.close()


"""
路由
"""
router = RuleRouter([
    Rule(PathMatches("/sys.*"), sys_url),
    Rule(PathMatches("/onl.*"), onl_url)
])


def liunxState():
    sockets = tornado.netutil.bind_sockets(port)
    tornado.process.fork_processes(thread)
    server = HTTPServer(router)
    server.add_sockets(sockets)
    logging.info("liunx系统启动成功...")
    tornado.ioloop.IOLoop.instance().start()


def windState():
    server = HTTPServer(router)
    server.listen(port)
    logging.info("windows系统启动成功...")
    IOLoop.current().start()


if __name__ == "__main__":
    getLogo()
    initLogging()
    initHandler()
    systemInfo.show_os_all_info()
    tem = systemInfo.get_system().lower()

    if (tem == "windows"):
        windState()
    else:
        liunxState()

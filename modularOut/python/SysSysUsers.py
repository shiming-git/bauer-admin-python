# -*- coding:utf-8 -*-

import uuid
from templates.webHandle import webHandler
from tool import Result
from tool import ResultCode
from templates import Handler
from tool.MySqlServe import MysqlUtile
from config import configMysql
from modularHandle.OnlHandle import OnlGenerate


"""
服务请求路径区
"""
(r"/sys/sys_users", SysSysUsers.SysSysUsers),
(r"/sys/sys_users/one", SysSysUsers.SysSysUsersOne)

"""
服务代码区
"""
class SysSysUsers(webHandler):
    """
    用户表
    """
    TABLENAME = "sys_users"

    def get(self, *args, **kwargs):
        dataList = self.query_list(self.TABLENAME)
        return self.finish(Result.success(dataList))

    def post(self, *args, **kwargs):
        index = self.addHandle(self.TABLENAME)
        if index == -2:
            return self.finish(ResultCode.PARAM_IS_NULL())
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())
        return self.finish(Result.success(index))

    def put(self, *args, **kwargs):
        index = self.editHandle(self.TABLENAME)
        if index == -2:
            return self.finish(ResultCode.PARAM_IS_NULL())
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())
        return self.finish(Result.success(index))

    def delete(self, *args, **kwargs):
        index = self.deleteHandle(self.TABLENAME)
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())
        return self.finish(Result.success())

class SysSysUsersOne(webHandler):
    """
    查询单个数据
    """
    TABLENAME = "sys_users"

    def get(self, *args, **kwargs):
        data = self.queryOne(self.TABLENAME)
        return self.finish(Result.success(data))
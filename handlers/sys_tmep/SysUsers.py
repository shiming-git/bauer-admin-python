# -*- coding:utf-8 -*-

import uuid
from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler

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

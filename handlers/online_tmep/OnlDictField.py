# -*- coding:utf-8 -*-

import json
from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler
from libs import RedisServer
from config import configSys
from libs.MySqlServe import MysqlUtile

"""
服务代码区
"""


class OnlOnlDictField(webHandler):
    """
    字典字段
    """
    TABLENAME = "onl_dict_field"

    def get(self, *args, **kwargs):
        dataList = self.query_list(self.TABLENAME)
        return self.finish(Result.success(dataList))

    def post(self, *args, **kwargs):
        index = self.addHandle(self.TABLENAME)
        if index == -2:
            return self.finish(ResultCode.PARAM_IS_NULL())
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        dict_code = self.get_body_parameter("dict_code")
        if dict_code:
            Handler.deleteCacheDict(dict_code)

        return self.finish(Result.success(index))

    def put(self, *args, **kwargs):
        index = self.editHandle(self.TABLENAME)
        if index == -2:
            return self.finish(ResultCode.PARAM_IS_NULL())
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        dict_code = self.get_body_parameter("dict_code")
        if dict_code:
            Handler.deleteCacheDict(dict_code)

        return self.finish(Result.success(index))

    def delete(self, *args, **kwargs):
        index = self.deleteHandle(self.TABLENAME)
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        dict_code = self.get_body_parameter("dict_code")
        if dict_code:
            Handler.deleteCacheDict(dict_code)
        return self.finish(Result.success())


class OnlOnlDictFieldOne(webHandler):
    """
    查询单个数据
    """
    TABLENAME = "onl_dict_field"

    def get(self, *args, **kwargs):
        data = self.queryOne(self.TABLENAME)
        return self.finish(Result.success(data))


class OnlDictCode(webHandler):
    TABLENAME = "onl_dict_field"

    """
    字典查询
    code 字典/表字段
    table 表名
    value 值名称
    where 条件
    """

    def get(self, *args, **kwargs):
        code = self.get_argument('code', None)
        table = self.get_argument("table", None)
        value = self.get_argument("value", None)
        where = self.get_argument("where", None)

        if not code:
            return self.finish(ResultCode.PARAM_IS_NULL())

        list_dict = self.getDictCode(code, table, value, where)
        return self.finish(Result.success(list_dict))

# -*- coding:utf-8 -*-

from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler

"""
服务代码区
"""


class OnlOnlTableField(webHandler):
    """
    onl字段名
    """
    TABLENAME = "onl_table_field"

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


class OnlOnlTableFieldOne(webHandler):
    """
    查询单个数据
    """
    TABLENAME = "onl_table_field"

    def get(self, *args, **kwargs):
        data = self.queryOne(self.TABLENAME)
        return self.finish(Result.success(data))


class OnlTableFieldName(webHandler):
    """
    获取字段名
    """
    def get(self, *args, **kwargs):
        table_name = self.get_argument("table_name")
        if not table_name:
            return self.finish(Result.error(ResultCode.DATABASE_OPERATE_ERROR))

        dataList = Handler.get_table_field(table_name)
        return self.finish(Result.success(dataList))
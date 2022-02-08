# -*- coding:utf-8 -*-

from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler


class OnlTableFieldList(webHandler):
    """
    字段表
    """
    TABLENAME = "onl_dict_field"

    def get(self, *args, **kwargs):
        pass

    def delete(self, *args, **kwargs):

        index = self.deleteHandle(self.TABLENAME)
        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        return self.finish(Result.success())


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

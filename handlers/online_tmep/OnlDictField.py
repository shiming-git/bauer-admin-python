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
    """

    def get(self, *args, **kwargs):
        code = self.get_argument('code', None)
        table = self.get_argument("table", None)
        value = self.get_argument("value", None)
        where = self.get_argument("where", None)

        if not code:
            return self.finish(ResultCode.PARAM_IS_NULL())

        redis = RedisServer.RedisUtil()
        # 查询字典
        if not table or not value:
            redis_key = configSys.CacheDict + code
            list_dict = redis.get(redis_key)
            if list_dict:
                return self.finish(Result.success(json.loads(list_dict)))

            sql = "SELECT `code`,`table` AS `value` FROM onl_dict_field WHERE dict_code = %s ORDER BY sort ASC"
            db = MysqlUtile()
            list_dict = db.query(sql, code)
            db.dispose()
            redis.set(redis_key, json.dumps(list_dict), configSys.ExDict)

            return self.finish(Result.success(list_dict))

        sql = f""" SELECT `{code}` AS `code`,`{value}` AS `value` FROM `{table}` """

        if where:
            sp_list = where.split(",")
            w = str.join(sp_list, " AND ")
            sql += f"""  WHERE dict_code =  {w}"""

        db = MysqlUtile()
        list_dict = db.query(sql)
        db.dispose()

        return self.finish(Result.success(list_dict))

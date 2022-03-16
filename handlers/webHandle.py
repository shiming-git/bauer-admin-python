import copy

from tornado.web import RequestHandler
from handlers import Handler
from libs import Result, ResultCode
import logging
import json
import uuid
from libs.MySqlServe import MysqlUtile
from libs.RedisServer import RedisUtil
from libs.TokenJWT import Token
from config import configSys
from datetime import datetime


# 在正常情况下没跑出错误的顺序：
#     set_default_headers：设置头
#     initialize：初始化
#     prepare：预处理（类似于django的中间件作用）
#     HTTP方法（get、post....）
#     on_finish：响应结束后的处理

# 跑出异常错误的情况下的顺序：
#     set_default_headers
#     initialize
#     prepare
#     http
#     set_default_headers：这里错误信息
#     是因为响应错误，需要修改头
#     write_error：重写错误信息
#     on_finish：响应结束后做内存释放，日志处理等操作

# initialize()
#     作用：做一些初始化操作

# prepare()
#     作用：预处理方法，在执行对应的请求方法之前调用
#     注意：任何一种HTTP请求，都会执行prepare方法

# http方法：
#     get：速度快效率高，缺点不安全数据量小
#     post：请求数据在请求体中，数据量大，安全
#     put：从客户端向服务器传输指定的内容
#     delete：请求服务器删除指定的一些资源
#     head：类似get请求，只是响应中没有具体的内容，用户获取报头
#     patch：请求修改局部的数据内容
#     options：返回url支持的所有http方法

# set_default_headers()
# write_error()
# on_finish()：
# 作用：在请求处理结束后调用，该方法中进行资源清理释放，或日志处理
# 注意：尽量不要在该方法中进行响应输出

class webHandler(RequestHandler):

    def set_default_headers(self):
        logging.info('set_default_headers方法执行')
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header("Access-Control-Allow-Headers", "x-requested-with")

    def initialize(self):
        logging.info('initialize方法执行')

    def prepare(self):
        logging.info("-------------请求-------------")
        logging.info("prepare方法执行")
        head = self.request.headers
        path = self.request.path
        method = self.request.method
        host = self.request.host
        logging.info("请求路径：%s" % path)  # 请求路径
        logging.info("请求方法：%s" % method)  # 请求方法
        logging.info("请求地址：%s" % host)  # IP地址

        ct = head.get('Content-Type', None)
        token = head.get('Token', None)

        logging.info('Content-Type：%s' % ct)
        logging.info('Token：%s' % token)
        # 判断是否白名单 直接跳过
        if (Handler.gnoreUrl(path)):
            logging.info("白名单：%s" % path)
            return

        # 判断token是否有效
        ind = Handler.inspectToken(token)
        if (ind == 0):
            logging.info("Token无效：%s" % token)
            return self.finish(ResultCode.USER_TOKEN_INVALID())

        if (ind == -1):
            logging.info("Token过期：%s" % token)
            return self.finish(ResultCode.USER_TOKEN_BEOVERDUE())

        if (ind == -2):
            logging.info("Token已被登陆：%s" % token)
            return self.finish(ResultCode.USER_TOKEN_OFFLINE())

        Handler.refreshCycleToken(ind)
        logging.info("Token正常：%s" % ind)

    # 响应以get方式发起的请求
    def get(self, *args, **kwargs):
        # self.get_query_argument('a', value)  # 用来获取指定参数的值, 当a获取不到值时, 使用value, 无value报错
        # self.get_query_arguments('a')  # 当url中有多个同名变量, 可获取所有值, 127.0.0.1:8000?a=1&a=2
        logging.info('get方法执行')
        # self.write("hello world!")
        return self.finish(ResultCode.INVALID_REQUEST_ERROR())

    # 响应以post方式发起的请求
    def post(self, *args, **kwargs):
        # self.get_body_argument()  # 用法同二中
        # self.get_body_arguments()  # 用法同二中
        # self.request.files  # 获取文件内容
        logging.info('post方法执行')
        # self.finish({"status": "success"})
        # self.write()  # 返回字符串
        # self.redirect()  # 重定向
        # self.render()  # 返回html页面
        return self.finish(ResultCode.INVALID_REQUEST_ERROR())

    def put(self, *args, **kwargs):
        logging.info('put方法执行')

    def delete(self, *args, **kwargs):
        logging.info('delete方法执行')

    def on_finish(self):
        logging.info('on_finish方法执行')

    def write_error(self, status_code, **kwargs):
        logging.info('write_error方法执行')
        super().write_error(status_code, **kwargs)

    # 获取post参数
    def get_body_parameter(self, key, default=None):
        data = json.loads(self.request.body)
        if not data:
            return default
        else:
            return data.get(key, default)

    # 解密token
    def decryptToken(self):
        header = self.request.headers
        userToken = header.get("token", None)
        tk = Token()
        return tk.decrypt(userToken)

    def delete_redis_nav(self):
        """
        删除redis中的用户菜单
        :return:
        """
        key = str(configSys.CacheNavUser) + "*"
        rd = RedisUtil()
        list = rd.keys(key)
        for ke in list:
            rd.delele(ke)
        rd.close()

    def queryOne(self, table_name=None):
        """
        查询单个数据
        :param table_name:
        :return:
        """
        # 获取数据库字段
        field_list = Handler.get_table_field(table_name)
        if not field_list:
            return None

        # 获取数据库字段
        field_list = Handler.get_table_field(table_name)
        if not field_list:
            return None

        # 获取字段参数
        param_list = []
        where_list = []
        for item in field_list:
            fieid = item.get("field_name", None)
            if not fieid:
                continue

            param = self.get_argument(fieid, None)
            if not param:
                continue

            param_list.append(param)
            where_list.append(fieid + "=%s")

        # 获取字段
        field_keys = []
        for item in field_list:
            if item.get("field_is_key", None) and item.get("field_is_key", None) == "PRI":
                field_name = item.get("field_name", None)
                if field_name:
                    field_name = "`" + field_name + "`"
                field_keys.append(field_name)
                continue

            if item.get("show_form", None) and item.get("show_form", None) == "Y":
                field_name = item.get("field_name", None)
                if field_name:
                    field_name = "`" + field_name + "`"
                field_keys.append(field_name)

        field_str = str.join(",", field_keys)
        if not field_str:
            field_str = " * "

        where_str = str.join(" AND ", where_list)

        sql = f"SELECT {field_str} FROM {table_name} WHERE {where_str} "
        db = MysqlUtile()
        data = db.get(sql, param_list)
        db.dispose()
        if data:
            data = self.dataDictHandler(field_list, data)

        return data

    def query_list(self, table_name=None):
        """
        单表查询数据 返回列表
        :param table_name:
        :param where_dict:
        :return:
        """
        # 判断表名
        if not table_name:
            return None

        page_num = self.get_argument('pageNo', None)
        per_page_data = self.get_argument('pageSize', None)
        column = self.get_argument('column', None)
        order = self.get_argument('order', None)

        # 获取数据库字段
        field_list = Handler.get_table_field(table_name)
        if not field_list:
            return None

        field_keys = []
        field_dict = {}
        for item in field_list:
            field_name = item.get("field_name", None)

            if item.get("field_is_key", None) and item.get("field_is_key", None) == "PRI":
                field_dict[field_name] = item
                if field_name:
                    field_name = "`" + field_name + "`"
                field_keys.append(field_name)
                continue

            if item.get("show_list", None) and item.get("show_list", None) == "Y":
                field_dict[field_name] = item
                if field_name:
                    field_name = "`" + field_name + "`"
                field_keys.append(field_name)

        # 获取字段参数
        param_list = []
        where_list = []
        for item in field_list:
            fieid = item.get("field_name", None)
            if not fieid:
                continue

            param = self.get_argument(fieid, None)
            if not param:
                continue

            param_list.append(param)
            where_list.append(fieid + "=%s")

        # 拼接字段
        field_str = str.join(",", field_keys)
        if not field_str:
            field_str = " * "

        sql = f"SELECT {field_str} FROM {table_name} "
        sql_page = f"SELECT COUNT(1) AS count FROM {table_name} "

        where_str = str.join(" AND ", where_list)
        if where_str:
            sql += f" WHERE {where_str}"
            sql_page += f" WHERE {where_str}"

        # 排序条件
        if order and column:
            sql += f" ORDER BY {column} {order} "

        # 判断分页
        if page_num and per_page_data:
            sql += self.paging_handler(page_num, per_page_data)

        logging.info("sql语句: %s", sql)
        logging.info("sql计数：%s", sql_page)
        db = MysqlUtile()
        dataList = db.query(sql, param_list)
        count = db.get(sql_page, param_list)
        db.dispose()

        # 数据类型处理
        dataList = self.dataListHandler(field_list, dataList)
        # 数据映射处理

        for row in dataList:
            deep_row = copy.deepcopy(row)
            for key in deep_row:
                item = field_dict[key]
                if not item:
                    continue
                code = item.get("dictionary_code", None)
                table = item.get("dictionary_table", None)
                value = item.get("dictionary_text", None)
                where = ""

                if not code or code == 'None':
                    continue

                dict_codes = self.getDictCode(code, table, value, where)
                for dic in dict_codes:
                    if dic["code"] == str(row[key]):
                        fid_name = key + "_describe"
                        row[fid_name] = dic["value"]

        obj = {
            "data": dataList,
            "count": count["count"]
        }
        return obj

    def dataDictHandler(self, field_list, data_dict):
        """
        字典
        :param field_list:
        :param data_dict:
        :return:
        """
        field_type = {}
        for item in field_list:
            fie_key = item.get("field_name", None)
            fie_type = item.get("field_type", None)
            if fie_key and fie_type:
                field_type[fie_key] = fie_type

        for key in data_dict.keys():
            data_dict[key] = self.data_type_handler(field_type[key], data_dict[key])

        return data_dict

    def dataListHandler(self, field_list, data_list):
        """
        数据处理
        :param field_list:
        :param dataList:
        :return:
        """
        field_type = {}
        for item in field_list:
            fie_key = item.get("field_name", None)
            fie_type = item.get("field_type", None)
            if fie_key and fie_type:
                field_type[fie_key] = fie_type

        for row in data_list:
            for key in row.keys():
                row[key] = self.data_type_handler(field_type[key], row[key])

        return data_list

    def data_type_handler(self, type, data):
        # 时间处理
        if type == "datetime":
            data = data.strftime("%Y-%m-%d %H:%M:%S") if data else data
        elif type == "date":
            data = data.strftime("%Y-%m-%d") if data else data

        return data

    def paging_handler(self, page_num, per_page_data):
        """
        分页拼接
        :param page:
        :param page_size:
        :return:
        """
        page_num = int(page_num)
        per_page_data = int(per_page_data)
        s1 = (page_num - 1) * per_page_data
        s2 = per_page_data
        sql = f" LIMIT {s1},{s2} "
        return sql

    # 添加
    def addHandle(self, table_name=None):

        # 获取数据库字段
        field_list = Handler.get_table_field(table_name)
        if not field_list:
            return None

        field_keys = []
        param_list = []

        for item in field_list:
            field_name = item.get("field_name", None)
            field_type = item.get("field_type", None)
            field_is_key = item.get("field_is_key", None)
            field_is_null = item.get("field_is_null", None)

            # 默认条件是主键
            # PRI 主键 varchar
            if field_name == "id" and field_is_key == "PRI" and field_type == "varchar":
                uid = Handler.getSnowflakeId()
                field_keys.append("id")
                param_list.append(uid)
                continue

            # 固定字段
            if field_name == "create_time" and field_type == "datetime":
                dt = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                field_keys.append("create_time")
                param_list.append(dt)
                continue

            # 固定字段
            if field_name == "create_user":
                user_info = self.decryptToken().get("data", None)
                field_keys.append("create_user")
                param_list.append(user_info.get('realName', None))
                continue

            field = self.get_body_parameter(field_name)
            # 判断必要参数 不为空
            if field_is_null == "NO":
                if not field:
                    return -2

            # 跳过空参数
            if not field:
                continue

            if field_name:
                field_name = "`" + field_name + "`"

            field_keys.append(field_name)
            param_list.append(field)

        value_set = []
        for item in field_keys:
            value_set.append("%s")

        param_set = str.join(" , ", field_keys)
        field_where = str.join(",", value_set)

        sql = f"INSERT INTO {table_name} ({param_set}) VALUES({field_where})"
        db = MysqlUtile()
        index = db.update(sql, param_list)
        db.dispose()

        return index

    # 修改
    def editHandle(self, table_name=None):
        # 获取数据库字段
        field_list = Handler.get_table_field(table_name)
        if not field_list:
            return None

        field_keys = []
        param_list = []

        field_k = []
        param_k = []
        for item in field_list:
            field_name = item.get("field_name", None)
            field_type = item.get("field_type", None)
            field_is_key = item.get("field_is_key", None)
            field_is_null = item.get("field_is_null", None)

            # 固定字段
            if field_name == "updata_time" and field_type == "datetime":
                dt = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                field_keys.append("updata_time" + "=%s")
                param_list.append(dt)
                continue

            # 固定字段
            if field_name == "updata_user":
                user_info = self.decryptToken().get("data", None)
                field_keys.append("updata_user" + "=%s")
                param_list.append(user_info.get('realName', None))
                continue

            field = self.get_body_parameter(field_name)
            # 判断必要参数 不为空
            if field_is_null == "NO":
                if not field:
                    return -2

            # 跳过空参数
            if not field:
                continue

            if field_name:
                field_name = "`" + field_name + "`"

            # 默认条件是主键
            if field_is_key:
                field_k.append(field_name + "=%s")
                param_k.append(field)
                continue

            field_keys.append(field_name + "=%s")
            param_list.append(field)

        param_set = str.join(" , ", field_keys)
        field_where = str.join(" AND ", field_k)

        param_list.extend(param_k)

        sql = f"UPDATE {table_name} SET {param_set} WHERE {field_where} "
        db = MysqlUtile()
        index = db.update(sql, param_list)
        db.dispose()

        return index

    def deleteHandle(self, table_name=None):
        id = self.get_body_parameter("ids")

        ids = str(id).split(",")

        sql = f"DELETE FROM {table_name} WHERE id =  %s;"
        db = MysqlUtile()
        index = db.deleteMany(sql, ids)
        db.dispose()

        return index

    def requiredParametersHandle(self, data_dict, table_name):
        """
        检查必要参数

        :return:
            返回 参数正确 None
            返回 参数错误 返回必填字段名
        """

        # 获取数据库字段
        field_list = Handler.get_table_field(table_name)
        for item in field_list:
            field_name = item.get("field_name", None)
            field_is_null = item.get("field_is_null", None)
            field_describe = item.get("field_describe", None)

            # 判断必要参数 不为空
            if field_is_null == "NO":
                if not data_dict.get(field_name, None):
                    return {"code": field_name, "name": field_describe}
        return None

    def getDictCode(self, code, table, value, where):
        """
        字典查询
        code 字典/表字段
        table 表名
        value 值名称
        where 条件
        """
        redis = RedisUtil()
        # 查询字典
        if not table or not value:
            redis_key = configSys.CacheDict + code
            list_dict = redis.get(redis_key)
            if list_dict:
                return json.loads(list_dict)

            sql = "SELECT `code`,`table` AS `value` FROM onl_dict_field WHERE dict_code = %s ORDER BY sort ASC"
            db = MysqlUtile()
            list_dict = db.query(sql, code)
            db.dispose()
            redis.set(redis_key, json.dumps(list_dict), configSys.ExDict)
            return json.loads(list_dict)

        sql = f""" SELECT `{code}` AS `code`,`{value}` AS `value` FROM `{table}` """

        if where:
            sp_list = where.split(",")
            w = str.join(sp_list, " AND ")
            sql += f"""  WHERE dict_code =  {w}"""

        db = MysqlUtile()
        list_dict = db.query(sql)
        db.dispose()
        return json.loads(list_dict)

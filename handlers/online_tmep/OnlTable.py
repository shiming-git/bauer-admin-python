# -*- coding:utf-8 -*-

from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler
from libs.MySqlServe import MysqlUtile
from config import configMysql
from online.OnlModular import OnlGenerate
from datetime import datetime
from online.OnlCreateTable import OnlCreateTable
from config import configSys


class OnlTableList(webHandler):
    """
    在线表单设计
    获取所有数据
    """
    TABLENAME = "onl_table"
    TABLENAMEFIELD = "onl_table_field"

    def get(self, *args, **kwargs):
        dataList = self.query_list(self.TABLENAME)
        return self.finish(Result.success(dataList))

    def post(self, *args, **kwargs):
        index = self.addHandle(self.TABLENAME)
        if index == -2:
            return self.finish(ResultCode.PARAM_IS_NULL())
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        Handler.deleteTableFieldName(self.TABLENAME)
        Handler.deleteTableFieldName(self.TABLENAMEFIELD)
        return self.finish(Result.success(index))

    def put(self, *args, **kwargs):
        index = self.editHandle(self.TABLENAME)
        if index == -2:
            return self.finish(ResultCode.PARAM_IS_NULL())
        if index <= 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        Handler.deleteTableFieldName(self.TABLENAME)
        Handler.deleteTableFieldName(self.TABLENAMEFIELD)
        return self.finish(Result.success(index))

    def delete(self, *args, **kwargs):
        id = self.get_body_parameter("ids")

        id = str(id)
        ids = id.split(",")

        sql_field = r"DELETE FROM onl_table_field WHERE table_name in (SELECT table_name FROM onl_table WHERE id = %s);"
        sql = r"DELETE FROM onl_table WHERE id = %s;"

        db = MysqlUtile()
        db.deleteMany(sql_field, ids)
        index = db.deleteMany(sql, ids)
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        Handler.deleteTableFieldName(self.TABLENAME)
        Handler.deleteTableFieldName(self.TABLENAMEFIELD)
        return self.finish(Result.success())


class ReadTableAll(webHandler):
    """
    读取数据库所有表
    表名   描述    创建时间    编码
    """

    def get(self, *args, **kwargs):
        sql = r"select TABLE_NAME AS table_name,TABLE_COMMENT AS table_comment,TABLE_COLLATION AS table_collation,CREATE_TIME AS create_time from information_schema.tables where table_schema=%s;"
        db = MysqlUtile()
        dataList = db.query(sql, configMysql.DBNAME)
        db.dispose()

        for item in dataList:
            item["create_time"] = item["create_time"].strftime('%Y-%m-%d %H:%M:%S')

        return self.finish(Result.success(dataList))


class OnlTableAll(webHandler):
    """
    获取onl表里所有数据
    """

    def get(self, *args, **kwargs):
        sql = r"SELECT table_name,table_describe,create_time FROM onl_table;"
        db = MysqlUtile()
        dataList = db.query(sql)
        db.dispose()

        for item in dataList:
            item["create_time"] = item["create_time"].strftime('%Y-%m-%d %H:%M:%S') if item["create_time"] else None

        return self.finish(Result.success(dataList))

    def post(self, *args, **kwargs):
        tables = self.get_body_parameter("tables")
        if not tables:
            return self.finish(Result.errorMapp(ResultCode.PARAM_IS_NULL))
        user_info = self.decryptToken().get("data", None)
        table_names = []
        table_list = []
        for item in tables:
            str_name = "'" + str(item.get("table_name", None)) + "'"
            table_names.append(str_name)

            list_table = []

            uid = Handler.getSnowflakeId()
            list_table.append(uid)
            list_table.append(user_info.get('realName', None))
            list_table.append(item.get("table_name", None))
            list_table.append(item.get("table_comment", None))
            list_table.append(1)
            list_table.append("Y")
            list_table.append("Y")
            list_table.append(800)
            list_table.append("N")

            table_list.append(list_table)

        sql = """
        INSERT INTO onl_table(id,create_time,create_user,table_name,table_describe,table_edition,table_paging,
        table_tree,dialog_width,dialog_is_whole) 
        VALUES(%s,NOW(),%s,%s,%s,%s,%s,%s,%s,%s)
        """
        db = MysqlUtile()
        index = db.insertMany(sql, table_list)
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        table = str.join(",", table_names)
        sql = f"""
            SELECT TABLE_NAME,COLUMN_NAME,ORDINAL_POSITION,IS_NULLABLE,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,COLUMN_KEY,EXTRA,COLUMN_COMMENT 
            FROM information_schema.`COLUMNS` 
            where TABLE_SCHEMA='{configMysql.DBNAME}' and TABLE_NAME IN ( {table} ) order by COLUMN_NAME;
        """
        db = MysqlUtile()
        dataList = db.query(sql)
        db.dispose()

        field_list = []
        for item in dataList:
            list_table = []
            uid = Handler.getSnowflakeId()
            list_table.append(uid)
            list_table.append(user_info.get('userID', None))
            list_table.append(item.get('TABLE_NAME', None))
            list_table.append(item.get('COLUMN_NAME', None))
            list_table.append(item.get('COLUMN_COMMENT', None))
            list_table.append(item.get('CHARACTER_MAXIMUM_LENGTH', None))
            list_table.append(0)
            list_table.append(item.get('DATA_TYPE', None))
            list_table.append(item.get('COLUMN_KEY', None))
            list_table.append(item.get('IS_NULLABLE', None))
            list_table.append(item.get('ORDINAL_POSITION', None))
            list_table.append(item.get('EXTRA', None))
            field_list.append(list_table)

        sql = r"""
            INSERT INTO `onl_table_field` (id,`create_time`,`create_user`,`table_name`,`field_name`,
            `field_describe`,`field_length`,`field_decimal`,`field_type`,`field_is_key`,`field_is_null`,`sort`,`extra`) 
            VALUES (%s,NOW(), %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s);
        """
        db = MysqlUtile()
        index = db.insertMany(sql, field_list)
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        Handler.deleteTableField()
        return self.finish(Result.success(index))


class OnlGeneration(webHandler):
    """"
        表单生成代码
    """

    def post(self, *args, **kwargs):
        id = self.get_body_parameter("id")
        table_model = self.get_body_parameter("table_model")
        table_describe = self.get_body_parameter("table_describe")

        if not id:
            return ResultCode.PARAM_ERROR()

        sql = f"SELECT * FROM onl_table WHERE id =  %s ;"
        sql_field = "SELECT * FROM onl_table_field WHERE table_name = %s;"
        db = MysqlUtile()
        tableObj = db.get(sql, id)
        table_name = tableObj.get("table_name", None)
        field_list = db.query(sql_field, table_name)
        db.dispose()

        onl = OnlGenerate().generate(tableObj, field_list, table_model, table_describe)
        return self.finish(Result.success(onl))


class OnlTableOne(webHandler):
    """
    获取单个数据
    """
    TABLENAME = "onl_table"

    def get(self, *args, **kwargs):
        data = self.queryOne(self.TABLENAME)
        return self.finish(Result.success(data))


class OnlTableSubmit(webHandler):
    """
    修改临时表数据
    """
    TABLENAME = "onl_table"
    TABLENAMEFIELD = "onl_table_field"

    def post(self, *args, **kwargs):
        table = self.get_body_parameter("table")
        table_field = self.get_body_parameter("table_field")
        if not table:
            return self.finish(ResultCode.PARAM_IS_NULL())

        if not table_field:
            return self.finish(ResultCode.PARAM_IS_NULL())

        if type(table_field) != list:
            return self.finish(ResultCode.PARAM_IS_NULL())

        # 拼接table
        user_info = self.decryptToken().get("data", None)
        create_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        create_user = user_info.get('realName', None)

        table["id"] = Handler.getSnowflakeId()
        table["table_edition"] = 1
        table["create_time"] = create_time
        table["create_user"] = create_user

        is_table = self.requiredParametersHandle(table, self.TABLENAME)
        if is_table:
            return self.finish(Result.error(f"【{is_table['name']}】参数必填"))

        # 拼接table_file
        param_set_f = []
        field_where_f = []
        param_list_f = []
        for item in table_field:
            item["id"] = Handler.getSnowflakeId()
            item["table_name"] = table.get("table_name", None)
            item["create_time"] = create_time
            item["create_user"] = create_user

            is_field = self.requiredParametersHandle(item, self.TABLENAMEFIELD)
            if is_field:
                return self.finish(Result.error(f"【{is_field['name']}】参数必填"))

            param_set_f, field_where_f, param = self.getFieldKeys(item, self.TABLENAMEFIELD)
            param_list_f.append(param)

        field_keys, value_set, param_list = self.getFieldKeys(table, self.TABLENAME)
        param_set = str.join(" , ", field_keys)
        field_where = str.join(",", value_set)

        sql = f"INSERT INTO {self.TABLENAME} ({param_set}) VALUES({field_where})"

        param_set_s = str.join(" , ", param_set_f)
        field_where_s = str.join(",", field_where_f)

        sql_fi = f"INSERT INTO {self.TABLENAMEFIELD} ({param_set_s}) VALUES({field_where_s})"

        db = MysqlUtile()
        index = db.insert(sql, param_list)
        index_fi = db.insertMany(sql_fi, param_list_f)
        db.dispose()

        if index < 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        if index_fi < 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())


        # Handler.deleteTableFieldName(self.TABLENAME)
        # Handler.deleteTableFieldName(self.TABLENAMEFIELD)
        Handler.deleteTableFieldName(table.get("table_name", None))

        return self.finish(Result.success())

    def put(self, *args, **kwargs):
        table = self.get_body_parameter("table")
        table_field = self.get_body_parameter("table_field")
        if not table:
            return self.finish(ResultCode.PARAM_IS_NULL())

        if not table_field:
            return self.finish(ResultCode.PARAM_IS_NULL())

        if type(table_field) != list:
            return self.finish(ResultCode.PARAM_IS_NULL())

        is_table = self.requiredParametersHandle(table, self.TABLENAME)
        if is_table:
            return self.finish(Result.error(f"【{is_table['name']}】参数必填"))

        for item in table_field:
            is_field = self.requiredParametersHandle(item, self.TABLENAMEFIELD)
            if is_field:
                return self.finish(Result.error(f"【{is_field['name']}】参数必填"))

        user_info = self.decryptToken().get("data", None)
        updata_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        updata_user = user_info.get('realName', None)

        table["updata_time"] = updata_time
        table["updata_user"] = updata_user
        table["table_edition"] = table["table_edition"] + 1

        field_keys, value_set, param_list = self.getFieldKeys(table, self.TABLENAME)
        field_keys_str = []
        for item in field_keys:
            field_keys_str.append(item + "=%s")

        param_list.append(table.get("id", None))
        param_set = str.join(" , ", field_keys_str)
        sql = f"UPDATE {self.TABLENAME} SET {param_set} WHERE id=%s "

        # 拼接table_file
        field_keys_f = []
        field_where_f = []
        param_list_f = []
        table_name = table.get("table_name", None)
        for item in table_field:
            if not item.get("id", None):
                item["id"] = Handler.getSnowflakeId()

            item["table_name"] = table_name
            item["create_time"] = updata_time
            item["create_user"] = updata_user
            item["updata_time"] = updata_time
            item["updata_user"] = updata_user

            field_keys_f, field_where_f, par_list = self.getFieldKeys(item, self.TABLENAMEFIELD)
            param_list_f.append(par_list)

        param_set_s = str.join(" , ", field_keys_f)
        field_where_s = str.join(",", field_where_f)
        sql_fi = f"INSERT INTO {self.TABLENAMEFIELD} ({param_set_s}) VALUES({field_where_s})"

        db = MysqlUtile()
        index = db.update(sql, param_list)
        db.delete("DELETE FROM onl_table_field WHERE table_name = %s", table_name)
        index_fi = db.insertMany(sql_fi, param_list_f)
        db.dispose()

        if index < 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        if index_fi < 0:
            return self.finish(ResultCode.DATABASE_OPERATE_ERROR())

        Handler.deleteTableFieldName(table.get("table_name", None))
        # Handler.deleteTableFieldName(self.TABLENAME)
        # Handler.deleteTableFieldName(self.TABLENAMEFIELD)
        return self.finish(Result.success())

    def getFieldKeys(self, data, table_name):
        field_list = Handler.get_table_field(table_name)
        field_keys = []
        param_list = []

        for item in field_list:
            field_name = item.get("field_name", None)
            fie_type = item.get("field_type", None)
            field = data.get(field_name, None)
            if fie_type == "int":
                field = data.get(field_name, 0)
            elif fie_type == "BigDecimal":
                field = data.get(field_name, 0)
            elif fie_type == "double":
                field = data.get(field_name, 0)

            field_keys.append(field_name)
            param_list.append(field)

        value_set = []
        for item in field_keys:
            value_set.append("%s")

        return field_keys, value_set, param_list


class OnlTableCreateForm(webHandler):
    """
    创建表单
    """
    TABLENAME = "onl_table"
    TABLENAMEFIELD = "onl_table_field"

    def post(self, *args, **kwargs):
        table_name = self.get_body_parameter("table_name")
        if not table_name:
            return self.finish(ResultCode.PARAM_IS_NULL())

        table_sql = "SELECT * FROM onl_table WHERE table_name = %s"
        table_field_sql = "SELECT * FROM onl_table_field WHERE table_name = %s"
        schema_table_sql = "SELECT COUNT(1) count from information_schema.tables where table_schema= %s AND table_name = %s"

        db = MysqlUtile()
        table_dict = db.get(table_sql, table_name)
        table_field_list = db.query(table_field_sql, table_name)
        schema_table_count = db.get(schema_table_sql, [configMysql.DBNAME, table_name])
        db.dispose()

        if not table_dict:
            return self.finish(Result.error("未找到表"))

        table_class = OnlCreateTable(table_dict, table_field_list)
        if schema_table_count.get("count") > 0:
            table_class.updataTable()
        else:
            table_class.createTable()

        return self.finish(Result.success())

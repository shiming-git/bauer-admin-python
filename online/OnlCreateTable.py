# -*- coding:utf-8 -*-

from libs.MySqlServe import MysqlUtile


class OnlCreateTable():
    """
    创建数据库表
    """

    def __init__(self, table, table_field):
        self.table = table
        self.table_field = table_field

    def createTable(self):
        """
        创建数据表
        :return:
        """
        table_name = self.table.get("table_name", None)
        field_describe = self.table.get("table_describe", None)

        field_list = self.__createField()
        table_sql = f"""
                    CREATE TABLE IF NOT EXISTS {table_name}({str.join(',', field_list)}) 
                    ENGINE=InnODB CHARSET=utf8 COMMENT= %s;
                    """

        db = MysqlUtile()
        db.insert(table_sql, field_describe)
        db.dispose()

        return True

    def __createField(self):
        field = []
        keys = []
        for row in self.table_field:
            field_name = row.field_name
            field_type = row.field_type
            field_length = row.field_length
            field_decimal = row.field_decimal
            field_describe = row.field_describe
            field_is_key = row.field_is_key
            field_is_null = row.field_is_null

            type_str = field_type + f"({field_length})"
            if field_type == "double" or field_type == "decimal":
                type_str = field_type + f"({field_length},{field_decimal})"

            is_null = "NULL DEFAULT NULL"

            if field_is_null == "NO":
                is_null = "NOT NULL"

            if field_is_key == "PRI":
                is_null = "NOT NULL"
                keys.append(field_name)

            fie = f"{field_name} {type_str} {is_null} COMMENT '{field_describe}'"
            field.append(fie)

        keys_str = f"PRIMARY KEY ({str.join(',', keys)}) USING BTREE"
        field.append(keys_str)

        return field

    def updataTable(self):
        """
        修改表单
        :return:
        """
        table_name = self.table.get("table_name", None)
        field_describe = self.table.get("table_describe", None)
        table_sql = f"ALTER TABLE {table_name} comment %s "
        db = MysqlUtile()
        db.update(table_sql, field_describe)
        db.dispose()

        return True

    def __updataField(self):
        """
        修改字段
        :return:
        """

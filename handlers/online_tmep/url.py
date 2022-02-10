# -*- coding:utf-8 -*-

from tornado.web import Application

from handlers.online_tmep import OnlTable
from handlers.online_tmep import OnlTableField
from handlers.online_tmep import OnlDict
from handlers.online_tmep import OnlDictField

url = Application([
    (r"/onl/onl_table", OnlTable.OnlTableList),
    (r"/onl/onl_table/all", OnlTable.OnlTableAll),
    (r"/onl/onl_table/one", OnlTable.OnlTableOne),
    (r"/onl/onl_table/submit", OnlTable.OnlTableSubmit),
    (r"/onl/read_table_all", OnlTable.ReadTableAll),
    (r"/onl/onl_generation", OnlTable.OnlGeneration),
    (r"/onl/onl_table_create_form", OnlTable.OnlTableCreateForm),
    (r"/onl/onl_field_name", OnlTableField.OnlTableFieldName),

    # 字段
    (r"/onl/onl_table_field", OnlTableField.OnlOnlTableField),
    (r"/onl/onl_table_field/one", OnlTableField.OnlOnlTableFieldOne),

    # 字典
    (r"/onl/onl_dict", OnlDict.OnlOnlDict),
    (r"/onl/onl_dict/one", OnlDict.OnlOnlDictOne),

    # 数据字典
    (r"/onl/onl_dict_field", OnlDictField.OnlOnlDictField),
    (r"/onl/onl_dict_field/one", OnlDictField.OnlOnlDictFieldOne),
    (r"/onl/onl_dict_code", OnlDictField.OnlDictCode),


])

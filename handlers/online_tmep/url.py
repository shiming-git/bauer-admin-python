# -*- coding:utf-8 -*-

from tornado.web import Application

from handlers.online_tmep import OnlTable
from handlers.online_tmep import OnlDictField
from handlers.online_tmep import OnlOnlTableField

url = Application([
    (r"/onl/onl_table", OnlTable.OnlTableList),
    (r"/onl/onl_table/all", OnlTable.OnlTableAll),
    (r"/onl/onl_table/one", OnlTable.OnlTableOne),
    (r"/onl/onl_table/submit", OnlTable.OnlTableSubmit),
    (r"/onl/read_table_all", OnlTable.ReadTableAll),
    (r"/onl/onl_generation", OnlTable.OnlGeneration),
    (r"/onl/onl_table_create_form", OnlTable.OnlTableCreateForm),

    (r"/onl/onl_field_list", OnlDictField.OnlTableFieldList),
    (r"/onl/onl_field_name", OnlDictField.OnlTableFieldName),
    (r"/onl/onl_table_field", OnlOnlTableField.OnlOnlTableField),
    (r"/onl/onl_table_field/one", OnlOnlTableField.OnlOnlTableFieldOne),

])

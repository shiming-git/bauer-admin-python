# -*- coding:utf-8 -*-
import json
import os, sys, re, traceback
from datetime import datetime
from string import Template


class OnlGenerate():

    def __init__(self):
        # 模版文件
        self.this_path = os.getcwd()
        self.fiel_path_list = [
            {
                "model": "python",
                "path": "python/py_handle.template"
            },
            {
                "model": "vue_table",
                "path": "vue/vue_table.template"
            },
            {
                "model": "vue_model",
                "path": "vue/model/vue_model.template"
            },
            {
                "model": "vue_form",
                "path": "vue/model/vue_form.template"
            },
            {
                "model": "vue_form_field_input",
                "path": "vue/model/vue_form_field_input.template"
            },
            {
                "model": "vue_form_field_text",
                "path": "vue/model/vue_form_field_text.template"
            },
            {
                "model": "vue_form_field_number",
                "path": "vue/model/vue_form_field_number.template"
            },
            {
                "model": "vue_form_field_select",
                "path": "vue/model/vue_form_field_select.template"
            },
            {
                "model": "vue_form_field_radio",
                "path": "vue/model/vue_form_field_radio.template"
            },
        ]

    """
    onl 代码生成器
    """

    def generate(self, table: dict, field: list, table_model: str, table_describe: str):
        """
        生成器
        :param table:
        :param field:
        :return:
        """
        table_name = table.get("table_name", None)

        if not table_name:
            return None

        m_file_name = table_name.title().replace("_", "")
        m_file_model = table_model.title().replace("_", "")

        file_obj = self.openFile()
        py_templates = self.generatePy(file_obj, table_name, table_model, table_describe)
        vue_lsit_templates = self.generateVueList(file_obj, table_name, table_model, table_describe)
        vue_model_templates = self.generateVueModel(file_obj, table_name, table_model, table_describe)
        vue_form_templates = self.generateVueForm(file_obj, table_name, table_model, field)

        py_name = f"{m_file_model}{m_file_name}.py"
        self.saveFile("python", py_name, py_templates)

        vue_list_name = f"{m_file_model}{m_file_name}List.vue"
        self.saveFile("vue", vue_list_name, vue_lsit_templates)

        vue_model_name = f"{m_file_model}{m_file_name}Model.vue"
        self.saveFile("vue/model", vue_model_name, vue_model_templates)

        vue_form_name = f"{m_file_model}{m_file_name}Form.vue"
        self.saveFile("vue/model", vue_form_name, vue_form_templates)

        return True

    def generateVueFormField(self, file_obj: dict, fields: list):
        """
        表单字段
        :param file_obj:
        :param table_name:
        :param table_model:
        :param table_describe:
        :return:
        """
        # vue_form_field_ordinary 普通输入框
        # ${fieldDescribe}
        # ${fieldName}
        # ${fieldLength}
        # ${fieldDecimal}
        # ${dictString}
        # ${dateType}

        field_list = []
        read_obj = {}
        for item in fields:
            field_name = item.get("field_name", None)
            field_type = item.get("field_type", None)
            field_is_key = item.get("field_is_key", None)
            field_is_null = item.get("field_is_null", None)
            control_type = item.get("control_type", None)
            validation_required = item.get("validation_required", None)
            is_read_only = item.get("is_read_only", None)
            dictionary_table = item.get("dictionary_table", None)
            dictionary_code = item.get("dictionary_code", None)
            dictionary_text = item.get("dictionary_text", None)
            field_describe = item.get("field_describe", None)
            field_length = item.get("field_length", 0)
            field_decimal = item.get("field_decimal", 0)

            # 控件类型
            # input 文本输入框
            tmpl = ""
            if control_type == "input":
                # 多行文本输入 TEXT  TINYTEXT  MEDIUMTEXT  LONGTEXT
                if field_type == "text" or field_type == "tinytext" or field_type == "mediumtext" or field_type == "longtext":
                    tmpl = Template(file_obj["vue_form_field_text"])

                # 数字输入 INT  BIGINT  DOUBLE
                elif field_type == "int" or field_type == "bigint" or field_type == "double":
                    tmpl = Template(file_obj["vue_form_field_number"])

                # 文字输入
                else:
                    tmpl = Template(file_obj["vue_form_field_input"])

            # select下拉组件
            elif control_type == "select":
                tmpl = Template(file_obj["vue_form_field_select"])

            # radio 单选
            elif control_type == "radio":
                tmpl = Template(file_obj["vue_form_field_radio"])

            # date 日期选择
            elif control_type == "date" or control_type == "datetime":
                tmpl = Template(file_obj["vue_form_field_date"])

            else:
                tmpl = Template(file_obj["vue_form_field_input"])

            # 校验
            if is_read_only == "Y":
                read_obj[field_name] = [
                    {"required": True, "message": f"{field_describe}不能为空！", "trigger": "blur"}
                ]

            # 替换字段
            dict_list = []
            if dictionary_table:
                dict_list.append(dictionary_table)
            if dictionary_text and dictionary_code:
                dict_list.append(dictionary_code)
                dict_list.append(dictionary_text)

            m_dictString = str.join(",", dict_list)

            # 模版替换
            field_list.append(
                tmpl.safe_substitute(
                    fieldDescribe=field_describe,
                    fieldName=field_name,
                    fieldLength=field_length,
                    fieldDecimal=field_decimal,
                    dictString=m_dictString,
                    dateType=control_type
                )
            )

        return str.join("\n", field_list), read_obj

    def generateVueForm(self, file_obj, table_name: str, table_model: str, fields: list):
        """
        前端 表单模板
        ${elColFormItems}
        ${formName}
        ${rulesModel}
        ${serverPath}

        :param file_obj:
        :param table_name:
        :param table_model:
        :param table_describe:
        :return:
        """
        field_str, read_obj = self.generateVueFormField(file_obj, fields)

        m_file_name = table_name.title().replace("_", "")
        m_file_model = table_model.title().replace("_", "")

        m_fileName = f"{m_file_model}{m_file_name}Form"
        m_serverPath = f"/{table_model}/{table_name}"
        m_elColFormItems = field_str
        m_rulesModel = json.dumps(read_obj)

        tmpl = Template(file_obj["vue_form"])
        # 模版替换
        lines = []
        lines.append(
            tmpl.safe_substitute(
                elColFormItems=m_elColFormItems,
                formName=m_fileName,
                rulesModel=m_rulesModel,
                serverPath=m_serverPath
            )
        )
        return lines

    def generateVueModel(self, file_obj, table_name: str, table_model: str, table_describe: str):
        """
        前端 弹窗模板
        ${formName}
        ${fileNmae}
        :param file_obj:
        :param table_name:
        :param table_model:
        :param table_describe:
        :return:
        """
        m_file_name = table_name.title().replace("_", "")
        m_file_model = table_model.title().replace("_", "")

        m_formName = f"{m_file_model}{m_file_name}Form"
        m_modelName = f"{m_file_model}{m_file_name}Model"

        tmpl = Template(file_obj["vue_model"])
        # 模版替换
        lines = []
        lines.append(
            tmpl.safe_substitute(
                formName=m_formName,
                fileNmae=m_modelName
            )
        )
        return lines

    def generateVueList(self, file_obj, table_name: str, table_model: str, table_describe: str):
        """
        前端vue 生成代码
        ${serverPath}
        ${fileName}
        ${tableDescribe}
        ${tableName}
        ${modelName}
        :param file_obj:
        :param table_name:
        :param table_model:
        :param table_describe:
        :return:
        """
        m_file_name = table_name.title().replace("_", "")
        m_file_model = table_model.title().replace("_", "")

        m_serverPath = f"/{table_model}/{table_name}"
        m_fileName = f"{m_file_model}{m_file_name}List"
        m_modelName = f"{m_file_model}{m_file_name}Model"

        tmpl = Template(file_obj["vue_table"])
        # 模版替换
        lines = []
        lines.append(
            tmpl.safe_substitute(
                serverPath=m_serverPath,
                fileName=m_fileName,
                tableName=table_name,
                tableDescribe=table_describe,
                modelName=m_modelName
            )
        )
        return lines

    def generatePy(self, file_obj, table_name: str, table_model: str, table_describe: str):
        """
        后端python3 生成代码
         ${model}
        ${tableName}
        ${fileName}
        ${className}
        ${tableDescribe}
        :return:
        """
        m_file_name = table_name.title().replace("_", "")
        m_file_model = table_model.title().replace("_", "")

        m_model = table_model
        m_tableDescribe = table_describe
        m_tableName = table_name
        m_className = f"{m_file_model}{m_file_name}"
        m_fileName = f"{m_file_model}{m_file_name}"

        tmpl = Template(file_obj["python"])

        # 模版替换
        lines = []
        lines.append(
            tmpl.safe_substitute(
                model=m_model,
                tableName=m_tableName,
                fileName=m_fileName,
                className=m_className,
                tableDescribe=m_tableDescribe
            )
        )
        return lines

    def openFile(self):
        """
        读取模板
        :return:
        """
        path = os.path.join(self.this_path, "modular")
        if not os.path.exists(path):
            return None

        template_file = None
        file_obj = {}
        for item in self.fiel_path_list:
            path_model = os.path.join(path, item["path"])
            template_file = open(path_model, 'r', encoding='UTF-8')
            file_obj[item["model"]] = template_file.read()

        template_file.close()
        return file_obj

    def saveFile(self, file_path: str, file_name: str, lines):
        """
        生成代码文件报错
        :param file_path:
        :param file_name:
        :param lines:
        :return:
        """

        path = os.path.join(self.this_path, "modularOut", file_path)
        file = os.path.join(path, file_name)
        if not os.path.exists(path):
            os.makedirs(path)
        class_file = open(file, 'w', encoding='UTF-8')
        # 0.将生成的代码写入文件
        class_file.writelines(lines)
        class_file.close()

        return file

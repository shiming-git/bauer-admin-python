from handlers.webHandle import webHandler
from tornado.web import RequestHandler
from libs import Result
from libs import ResultCode
from handlers import Handler
from libs.MySqlServe import MysqlUtile
from config.configSys import filePath
import os


class FileUpload(webHandler):
    """
    文件上传
    """

    def post(self, *args, **kwargs):

        file_path = os.path.normcase(os.path.join(filePath))
        if not (os.path.isdir(file_path)):
            os.makedirs(file_path)

        file_metas = self.request.files.get('file', None)  # 提取表单中‘name'为‘file'的文件元数据
        if not file_metas:
            return self.finish(Result.errorMapp(ResultCode.USER_UPLOAD_FILE_ERROR))

        file_new_name = ""

        for meta in file_metas:
            flake_id = Handler.getSnowflakeId()
            file_name = meta['filename']  # 源文件名称
            file_type = os.path.splitext(file_name)[1]  # 取出文件扩展名
            format = file_type.replace(".", "")
            file_new_name = flake_id + file_type  # 新文件名称
            save_file = os.path.join(format, file_new_name)
            path_new_format = os.path.join(file_path, format)
            if not (os.path.isdir(path_new_format)):
                os.makedirs(path_new_format)

            file_new_path = os.path.join(path_new_format, file_new_name)
            # 有些文件需要已二进制的形式存储，实际中可以更改
            with open(file_new_path, 'wb') as up:
                up.write(meta['body'])

            file_size = os.path.getsize(file_new_path)
            self.seveFile(flake_id, file_name, file_new_name, format, save_file, file_size)

        return self.finish(Result.success(file_new_name))

    def seveFile(self, id, file_name=None, file_new_name=None, file_type=None, file_path=None, file_size=0):
        tokenData = self.decryptToken()
        userName = ""
        if (tokenData):
            user = tokenData.get("data", None)
            userName = user.get("userName", None)

        sql = "INSERT INTO sys_file(id,file_name,file_original_name,file_size,created_by,created_date,file_format,file_url) VALUES(%s,%s,%s,%s,%s,NOW(),%s,%s)"
        db = MysqlUtile()
        is_idex = db.insert(sql, [id, file_new_name, file_name, file_size, userName, file_type, file_path])
        db.dispose()
        return is_idex


class FileDowload(RequestHandler):
    """
    文件下载
    """
    buf_size = 1024

    def get(self, fileName, formatName):
        file = fileName + "." + formatName
        file_path = os.path.normcase(os.path.join(filePath, formatName, file))
        if not (os.path.isfile(file_path)):
            return self.finish()

        # # Content-Type这里我写的时候是固定的了，也可以根据实际情况传值进来
        self.set_header('Content-Type', 'application/octet-stream')
        self.set_header('Content-Disposition', 'attachment; filename=' + file)
        # 读取的模式需要根据实际情况进行修改
        with open(file_path, 'rb') as f:
            while True:
                data = f.read(self.buf_size)
                if not data:
                    break
                self.write(data)
        return self.finish()



"""
服务代码区
"""
class FileSysFile(webHandler):
    """
    文件管理
    """
    TABLENAME = "sys_file"

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



class FileSysFileOne(webHandler):
    """
    查询单个数据
    """
    TABLENAME = "sys_file"

    def get(self, *args, **kwargs):
        data = self.queryOne(self.TABLENAME)
        return self.finish(Result.success(data))

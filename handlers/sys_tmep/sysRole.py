from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from libs.MySqlServe import MysqlUtile


class sysRole(webHandler):
    """
    角色
    """
    TABLENAME = "sys_role"

    def get(self, *args, **kwargs):
        """
        获取列表
        :param args:
        :param kwargs:
        :return:
        """
        dataList = self.query_list(self.TABLENAME)
        return self.finish(Result.success(dataList))

    def post(self, *args, **kwargs):
        """
        添加
        :param args:
        :param kwargs:
        :return:
        """
        roleName = self.get_body_parameter("roleName")
        roleSort = self.get_body_parameter("roleSort")
        roleStat = self.get_body_parameter("roleStat")

        sql = r"INSERT INTO sys_role (roleName,dataTime,roleSort,roleStat) VALUES(%s,NOW(),%s,%s);"
        db = MysqlUtile()
        insertId = db.insert(sql, (roleName, roleSort, roleStat))
        db.dispose()

        if insertId <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        return self.finish(Result.success(insertId))

    def put(self, *args, **kwargs):
        """
        修改
        :param args:
        :param kwargs:
        :return:
        """
        roleID = self.get_body_parameter("roleID")
        roleName = self.get_body_parameter("roleName")
        dataTime = self.get_body_parameter("dataTime")
        roleSort = self.get_body_parameter("roleSort")
        roleStat = self.get_body_parameter("roleStat")

        sql = r"UPDATE sys_role SET roleName = %s,dataTime=%s,roleSort=%s,roleStat = %s WHERE roleID=%s ;"
        db = MysqlUtile()
        insertId = db.update(sql, (roleName, dataTime, roleSort, roleStat, roleID))
        db.dispose()

        if insertId <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        self.delete_redis_nav()
        return self.finish(Result.success(insertId))

    def delete(self, *args, **kwargs):
        """
        批量删除
        :param args:
        :param kwargs:
        :return:
        """
        id = self.get_body_parameter("ids")
        if not id:
            return self.finish(Result.errorMapp(ResultCode.PARAM_IS_NULL))
        id = str(id)
        ids = id.split(",")
        sql = r"DELETE FROM sys_role WHERE roleID IN ( %s ) ;"
        db = MysqlUtile()
        index = db.deleteMany(sql, ids)
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        self.delete_redis_nav()
        return self.finish(Result.success(index))


class sysRoleModel(webHandler):
    """
    角色权限
    """

    def get(self, *args, **kwargs):
        id = self.get_argument('id', None)
        if not id:
            return self.finish(Result.errorMapp(ResultCode.PARAM_IS_NULL))
        sql = "SELECT * FROM sys_role_model WHERE roleID = %s;"
        db = MysqlUtile()
        list = db.query(sql, id)
        db.dispose()
        return self.finish(Result.success(list))

    def put(self, *args, **kwargs):
        ids = self.get_body_parameter("ids")
        roleId = self.get_body_parameter("roleId")
        if not ids or not roleId:
            return self.finish(Result.errorMapp(ResultCode.PARAM_IS_NULL))

        list = []
        for id in ids:
            list.append([roleId, id])

        sqlDE = "DELETE FROM sys_role_model WHERE roleID = %s;"
        sqlIN = "INSERT INTO sys_role_model (roleID,modelID) VALUES(%s,%s);"
        db = MysqlUtile()
        db.delete(sqlDE, roleId)
        index = db.insertMany(sqlIN, list)
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        self.delete_redis_nav()
        return self.finish(Result.success(index))

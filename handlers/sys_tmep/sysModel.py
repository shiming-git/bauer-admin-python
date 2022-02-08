from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler
from libs.MySqlServe import MysqlUtile


class getModeTree(webHandler):
    """
    表格名称
    """
    TABLENAME = "sys_model"

    def get(self, *args, **kwargs):
        sql = "SELECT * FROM sys_model  ORDER BY modelSort ASC"
        db = MysqlUtile()
        modeList = db.query(sql)
        db.dispose()
        if not modeList:
            return self.finish(Result.error(ResultCode.ACCESS_UNAUTHORIZED()))
        treeList = Handler.treeCreate(modeList, -1)
        self.finish(Result.success(treeList))

    def post(self, *args, **kwargs):
        modelName = self.get_body_parameter("modelName")
        modelURL = self.get_body_parameter("modelURL")
        modelSup = self.get_body_parameter("modelSup")
        modelSort = self.get_body_parameter("modelSort")
        modelIcon = self.get_body_parameter("modelIcon")
        modelState = self.get_body_parameter("modelState")
        pageName = self.get_body_parameter("pageName")
        modelPath = self.get_body_parameter("modelPath")

        sql = "INSERT INTO sys_model (modelName,modelURL,modelSup,modelSort,modelIcon,modelState,pageName,modelPath) VALUES(%s,%s,%s,%s,%s,%s,%s,%s)"
        db = MysqlUtile()
        index = db.insert(sql, [modelName, modelURL, modelSup, modelSort, modelIcon, modelState, pageName, modelPath])
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))
        return self.finish(Result.success(index))

    def put(self, *args, **kwargs):
        modelID = self.get_body_parameter("modelID")
        modelName = self.get_body_parameter("modelName")
        modelURL = self.get_body_parameter("modelURL")
        modelSup = self.get_body_parameter("modelSup")
        modelSort = self.get_body_parameter("modelSort")
        modelIcon = self.get_body_parameter("modelIcon")
        modelState = self.get_body_parameter("modelState")
        pageName = self.get_body_parameter("pageName")
        modelPath = self.get_body_parameter("modelPath")

        if not modelID:
            return self.finish(Result.errorMapp(ResultCode.PARAM_IS_NULL))

        sql = "UPDATE sys_model SET modelName=%s,modelURL=%s,modelSup=%s,modelSort=%s,modelIcon=%s,modelState=%s,pageName=%s,modelPath=%s WHERE modelID=%s;"
        db = MysqlUtile()
        index = db.update(sql, [modelName, modelURL, modelSup, modelSort, modelIcon, modelState, pageName, modelPath,
                                modelID])
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        self.delete_redis_nav()
        return self.finish(Result.success(index))

    def delete(self, *args, **kwargs):
        ids = self.get_body_parameter("ids")
        if not ids:
            return self.finish(Result.errorMapp(ResultCode.PARAM_IS_NULL))

        sql = "DELETE FROM sys_model WHERE  modelID in(%s);"
        db = MysqlUtile()
        index = db.delete(sql, ids)
        db.dispose()

        if index <= 0:
            return self.finish(Result.errorMapp(ResultCode.DATABASE_OPERATE_ERROR))

        self.delete_redis_nav()
        return self.finish(Result.success(index))

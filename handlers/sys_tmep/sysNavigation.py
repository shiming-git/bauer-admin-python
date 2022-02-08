import json

from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler
from libs.MySqlServe import MysqlUtile
from libs.RedisServer import RedisUtil
from config import configSys


class getTree(webHandler):
    """
    导航
    """

    def get(self, *args, **kwargs):
        tokenData = self.decryptToken()
        user = tokenData.get("data", None)
        userID = user.get("userID", None)
        key = str(configSys.CacheNavUser) + str(userID)
        rd = RedisUtil()
        treeList = rd.get(key)
        if treeList:
            return self.finish(Result.success(json.loads(treeList)))

        sql = "SELECT c.modelID,c.modelName,c.modelURL,c.modelSup,c.modelSort,c.modelIcon,c.modelState,c.pageName,c.modelPath FROM sys_role_user AS a,sys_role_model AS b,sys_model AS c WHERE a.userID = %s AND a.roleID = b.roleID AND b.modelID = c.modelID ORDER BY c.modelSort ASC"
        db = MysqlUtile()
        modeList = db.query(sql, userID)
        db.dispose()
        if not modeList:
            return self.finish(Result.errorMapp(ResultCode.ACCESS_UNAUTHORIZED))

        treeList = Handler.treeCreate(modeList, -1)
        rd.set(key, json.dumps(treeList), configSys.ExNavUser)
        self.finish(Result.success(treeList))

from handlers.webHandle import webHandler
from libs import Result
from libs import ResultCode
from handlers import Handler
from libs.MySqlServe import MysqlUtile




"""
登陆账号密码登陆
passWord: "e10adc3949ba59abbe56e057f20f883e"
realName: ""
userName: "admin"
"""


class LoginAccountPassword(webHandler):

    def get(self, *args, **kwargs):
        return self.finish(Result.errorMapp(ResultCode.INVALID_REQUEST_ERROR))

    def post(self, *args, **kwargs):
        passWord = self.get_body_parameter("passWord")
        userName = self.get_body_parameter("userName")
        passWord = Handler.encryption_md5(passWord)
        sql = " SELECT userID,userName,`passWord`,realName,avatarUrl,state,weixinUser,loginState,sex FROM sys_users WHERE userName=%s "
        db = MysqlUtile()
        data = db.get(sql, userName)
        db.dispose()

        if not data:
            return self.finish(Result.errorMapp(ResultCode.USER_NOT_EXIST))
        if data.get("passWord", '') != passWord:
            return self.finish(Result.errorMapp(ResultCode.USERNAME_OR_PASSWORD_ERROR))
        del data["passWord"]
        data["id"] = data["userID"]
        dicts = {
            "userinfo": data,
            "token": Handler.generateToken(data)
        }
        return self.finish(Result.success(dicts))


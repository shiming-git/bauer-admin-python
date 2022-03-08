import json

from libs.RedisServer import RedisUtil
from libs.MySqlServe import MysqlUtile
from libs.TokenJWT import Token
import hashlib
from config import configSys
from libs.IdWorker import IdWorker
import os

# 检测token是否过期
# 返回 None token无效
# 返回-1 token 过期
# 返回-2 token 已被登陆
# Redis
RD = RedisUtil()
# 雪花算法
WORKER = IdWorker(1, 1, 0)


def inspectToken(token):
    if (not token):
        # 返回 None token无效
        return 0
    tk = Token()
    userinfo = tk.decrypt(token)
    if (not userinfo):
        return 0

    tdata = userinfo.get("data")
    uid = tdata.get("id", None)
    userR = RD.get(configSys.CacheUserInfo + uid)

    if (not userR):
        # 返回-1 token 过期
        return -1

    userR = json.loads(userR)
    rdtime = userR.get("time", None)
    tktime = userinfo.get("time", None)
    if (rdtime != tktime):
        # 返回-2 token 已被登陆
        return -2
    return userR


# 生成token存入redis
# 生效时间 2小时
def generateToken(userinfo={}):
    if "id" not in userinfo:
        return None
    tk = Token()
    token, dict = tk.encryption(userinfo)
    id = userinfo.get("id")
    RD.set(configSys.CacheUserInfo + id, json.dumps(dict), configSys.ExUserInfo)
    return token


# 刷新token生命周期
def refreshCycleToken(userinfo):
    id = userinfo.get("id", None)
    if (not id):
        return None
    return RD.set(configSys.CacheUserInfo + id, json.dumps(userinfo), configSys.ExUserInfo)


# 检测是否忽略URL
def gnoreUrl(url):
    return url in configSys.ignore


# md5加密
def encryption_md5(msg):
    hash3 = hashlib.md5(bytes(configSys.secret_key, encoding='utf-8'))
    hash3.update(bytes(msg, encoding="utf-8"))
    return hash3.hexdigest()


# 建树
def treeCreate(list, key):
    treelist = []
    for item in list:
        if item["modelSup"] == key:
            item["children"] = treeCreate(list, item["modelID"])
            treelist.append(item)
    return treelist


# 获取表字段
def get_table_field(table_name):
    redis_key = configSys.CacheField + table_name
    dataList = RD.get(redis_key)
    if dataList:
        dataList = json.loads(dataList)
        return dataList

    sql = r"SELECT * FROM onl_table_field WHERE table_name = %s ORDER BY sort ASC"
    db = MysqlUtile()
    dataList = db.query(sql, table_name)
    db.dispose()

    for item in dataList:
        item["create_time"] = item["create_time"].strftime("%Y-%m-%d %H:%M:%S") if item["create_time"] else None
        item["updata_time"] = item["updata_time"].strftime("%Y-%m-%d %H:%M:%S") if item["updata_time"] else None

    json_str = json.dumps(dataList)
    RD.set(redis_key, json_str, configSys.ExFieId)
    return dataList


# 删除表缓存模糊
def deleteTableField():
    """
    删除表缓存
    :return:
    """
    redis_key = configSys.CacheField + "*"
    keys = RD.keys(redis_key)
    for item in keys:
        RD.delele(item)
    return True


def deleteTableFieldName(table_name):
    """
    删除指定表名字段缓存
    :param table_name:
    :return:
    """
    if not table_name:
        return False
    redis_key = configSys.CacheField + table_name
    RD.delele(redis_key)
    return True


def sqlInHandle(values: str) -> str:
    """
    处理sql in 判断
    values = "a,b,c"
    :param values:
    :return:
    """
    value_list = values.split(",")
    val_list = []
    for item in value_list:
        val_list.append(f" '{item}' ")

    return str.join(",", val_list)

def getSnowflakeId():
    """
    获取ID
    :return:
    """
    return str(WORKER.get_id())

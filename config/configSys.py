# 端口
port = 8001
# 线程数量
thread = 2
debug = True
# 平台
platform = ""
# 秘钥
secret_key = "svn"

# token忽略URL
ignore = (
    "/sys/login/LoginAccountPassword",
)

# 缓存导航
CacheNavUser = "cache:nav:"
ExNavUser = 60 * 60
# 缓存表字段
CacheField = "cache:field:"
ExFieId = 60 * 60
# 用户信息缓存
CacheUserInfo = "cache:user:"
ExUserInfo = 2 * 60 * 60
# 缓存字典
CacheDict = "cache:dict:"
ExDict = 2 * 60 * 60

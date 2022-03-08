def SUCCESS():
    """
    一切ok
    """
    return {"code": "00000", "message": "一切ok"}


def ERROR():
    """
    系统出错
    """
    return {"code": "B0001", "message": ""}


def USER_ERROR():
    """
    用户端错误
    :return:
    """
    return {"code": "A0001", "message": "用户端错误"}


def USER_TOKEN_INVALID():
    """
    Token无效
    :return:
    """
    return {"code": "A0101", "message": "Token无效"}


def USER_TOKEN_BEOVERDUE():
    """
    Token过期
    :return:
    """
    return {"code": "A0102", "message": "Token过期"}


def USER_TOKEN_OFFLINE():
    """
    Token已被登陆
    :return:
    """
    return {"code": "A0103", "message": "账号已被登陆"}


def USER_LOGIN_ERROR():
    """
    用户登录异常
    :return:
    """
    return {"code": "A0200", "message": "用户登录异常"}


def USER_NOT_EXIST():
    """
    用户不存在
    :return:
    """
    return {"code": "A0201", "message": "用户不存在"}


def USER_ACCOUNT_LOCKED():
    """
    用户账户被冻结
    :return:
    """
    return {"code": "A0202", "message": "用户账户被冻结"}


def USER_ACCOUNT_LOCKED():
    """
    用户账户被冻结
    :return:
    """
    return {"code": "A0202", "message": "用户账户被冻结"}


def USER_ACCOUNT_INVALID():
    """
    用户账户已作废
    :return:
    """
    return {"code": "A0203", "message": "用户账户已作废"}


def WEB_NOT_EXIST():
    """
    站点不存在
    :return:
    """
    return {"code": "A0204", "message": "站点不存在"}


def USERNAME_OR_PASSWORD_ERROR():
    """
    用户名或密码错误
    :return:
    """
    return {"code": "A0211", "message": "用户名或密码错误"}


def INPUT_PASSWORD_EXCEED_LIMIT():
    """
    用户输入密码次数超限
    :return:
    """
    return {"code": "A0210", "message": "用户输入密码次数超限"}


def CLIENT_AUTHENTICATION_FAILED():
    """
    客户端认证失败
    :return:
    """
    return {"code": "A0212", "message": "客户端认证失败"}


def TOKEN_INVALID_OR_EXPIRED():
    """
    token无效或已过期
    :return:
    """
    return {"code": "A0230", "message": "token无效或已过期"}


def TOKEN_ACCESS_FORBIDDEN():
    """
    token已被禁止访问
    :return:
    """
    return {"code": "A0231", "message": "token已被禁止访问"}


def AUTHORIZED_ERROR():
    """
    访问权限异常
    :return:
    """
    return {"code": "A0300", "message": "访问权限异常"}


def ACCESS_UNAUTHORIZED():
    """
    访问未授权
    :return:
    """
    return {"code": "A0301", "message": "访问未授权"}


def FORBIDDEN_OPERATION():
    """
    演示环境禁止修改、删除重要数据，请本地部署后测试
    :return:
    """
    return {"code": "A0302", "message": "演示环境禁止修改、删除重要数据，请本地部署后测试"}


def INVALID_REQUEST_ERROR():
    """
    请求方式错误!
    :return:
    """
    return {"code": "A4003", "message": "请求方式错误!"}


def DATABASE_OPERATE_ERROR():
    """
    数据操作失败
    :return:
    """
    return {"code": "C0310", "message": "数据操作失败"}


def PARAM_ERROR():
    return {"code": "A0400", "message": "用户请求参数错误"}


def PARAM_IS_NULL():
    return {"code": "A0410", "message": "请求必填参数为空"}


def QUERY_MODE_IS_NULL():
    return {"code": "A0411", "message": "查询模式为空"}


def USER_UPLOAD_FILE_ERROR():
    return {"code": "A0700", "message": "用户上传文件异常"}


def USER_UPLOAD_FILE_TYPE_NOT_MATCH():
    return {"code": "A0701", "message": "用户上传文件类型不匹配"}


def USER_UPLOAD_FILE_SIZE_EXCEEDS():
    return {"code": "A0702", "message": "用户上传文件太大"}


def USER_UPLOAD_IMAGE_SIZE_EXCEEDS():
    return {"code": "A0703", "message": "用户上传图片太大"}



    # INVALID_REQUEST_ERROR("A4003", "请求方式 {0} 错误 ! 请使用 {1} 方式"),
    # AUTHORIZED_GRANT_ERROR("A4003", "授权失败"),
    # SYSTEM_EXECUTION_TIMEOUT("B0100", "系统执行超时"),
    # SYSTEM_ORDER_PROCESSING_TIMEOUT("B0100", "系统订单处理超时"),
    #
    # SYSTEM_DISASTER_RECOVERY_TRIGGER("B0200", "系统容灾功能被出发"),
    # FLOW_LIMITING("B0210", "系统限流"),
    # DEGRADATION("B0220", "系统功能降级"),
    #
    # SYSTEM_RESOURCE_ERROR("B0300", "系统资源异常"),
    # SYSTEM_RESOURCE_EXHAUSTION("B0310", "系统资源耗尽"),
    # SYSTEM_RESOURCE_ACCESS_ERROR("B0320", "系统资源访问异常"),
    # SYSTEM_READ_DISK_FILE_ERROR("B0321", "系统读取磁盘文件失败"),
    #
    # CALL_THIRD_PARTY_SERVICE_ERROR("C0001", "调用第三方服务出错"),
    # MIDDLEWARE_SERVICE_ERROR("C0100", "中间件服务出错"),
    # INTERFACE_NOT_EXIST("C0113", "接口不存在"),
    #
    # MESSAGE_SERVICE_ERROR("C0120", "消息服务出错"),
    # MESSAGE_DELIVERY_ERROR("C0121", "消息投递出错"),
    # MESSAGE_CONSUMPTION_ERROR("C0122", "消息消费出错"),
    # MESSAGE_SUBSCRIPTION_ERROR("C0123", "消息订阅出错"),
    # MESSAGE_GROUP_NOT_FOUND("C0124", "消息分组未查到"),
    #
    # DATABASE_ERROR("C0300", "数据库服务出错"),
    # DATABASE_TABLE_NOT_EXIST("C0311", "表不存在"),
    # DATABASE_COLUMN_NOT_EXIST("C0312", "列不存在"),
    # DATABASE_DUPLICATE_COLUMN_NAME("C0321", "多表关联中存在多个相同名称的列"),
    # DATABASE_DEADLOCK("C0331", "数据库死锁"),
    # DATABASE_PRIMARY_KEY_CONFLICT("C0341", "主键冲突");

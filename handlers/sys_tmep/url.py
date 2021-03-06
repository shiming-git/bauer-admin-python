from tornado.web import Application

from handlers.sys_tmep import sysLogin
from handlers.sys_tmep import sysNavigation
from handlers.sys_tmep import sysModel
from handlers.sys_tmep import sysRole
from handlers.sys_tmep import SysUsers
from handlers.sys_tmep import sysFile

url = Application([
    (r"/sys/login/LoginAccountPassword", sysLogin.LoginAccountPassword),  # 账号密码登陆
    (r"/sys/navigation/getList", sysNavigation.getTree),  # 获取导航栏
    (r"/sys/model/getmodelist", sysModel.getModeTree),  # 获取页面模板

    (r"/sys/role", sysRole.sysRole),  # 角色权限
    (r"/sys/role_model", sysRole.sysRoleModel),  # 角色已有权限

    (r"/sys/sys_users", SysUsers.SysSysUsers),   # 用户
    (r"/sys/sys_users/one", SysUsers.SysSysUsersOne),    # 用户

    (r"/sys/file/upload", sysFile.FileUpload),  # 文件上传
    (r"/sys/file/dowload/(\w*).(\w*)", sysFile.FileDowload),    # 文件下载
    (r"/sys/file/sys_file", sysFile.FileSysFile),
    (r"/sys/file/sys_file/one", sysFile.FileSysFileOne),
])

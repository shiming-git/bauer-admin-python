# -*- coding: utf-8 -*-
import pymysql
from pymysql.cursors import DictCursor
from dbutils.pooled_db import PooledDB
import config.configMysql as Config

""" 
Config是一些数据库的配置文件 
"""


class Paginator():
    def __init__(self, count, page=1, display=5):
        # 取总行数
        self.number = page
        if (page <= 0): self.number = 1
        self.count = count
        self.next_page_number = 0
        self.previous_page_number = 0
        if (self.number > 1):
            self.has_previous = True
            self.previous_page_number = self.number - 1
        else:
            self.has_previous = False
        if (self.number * display >= self.count):
            self.has_next = False
        else:
            self.next_page_number = self.number + 1
            self.has_next = True
        self.num_pages = int(self.count / display)
        if (self.count % display > 0):
            self.num_pages += 1
        self.DataList = []


class Row(dict):
    """A dict that allows for object-like property access syntax."""

    def __getattr__(self, name):
        try:
            return self[name]
        except KeyError:
            raise AttributeError(name)


class MysqlUtile(object):
    """
    MYSQL数据库对象，负责产生数据库连接 , 此类中的连接采用连接池实现获取连接对象：conn = Mysql.getConn()
            释放连接对象;conn.close()或del conn
    """
    # 连接池对象
    __pool = None

    def __init__(self):
        # 数据库构造函数，从连接池中取出连接，并生成操作游标
        self._conn = MysqlUtile.__getConn()
        self._cursor = self._conn.cursor()

    @staticmethod
    def __getConn():
        """
        @summary: 静态方法，从连接池中取出连接
        @return MySQLdb.connection
        """
        if MysqlUtile.__pool is None:
            __pool = PooledDB(creator=pymysql, mincached=1, maxcached=20,
                              host=Config.DBHOST, port=Config.DBPORT, user=Config.DBUSER, passwd=Config.DBPWD,
                              db=Config.DBNAME, use_unicode=False, charset=Config.DBCHAR, cursorclass=DictCursor)

        return __pool.connection()

    # 处理bytes
    def bytesToStr(self, obj):
        if not obj:
            return obj
        for key in obj:
            if type(obj[key]) == bytes:
                obj[key] = str(obj[key], encoding="utf-8")
        return obj

    def query(self, sql, param=None):
        """
        @summary: 执行查询，并取出所有结果集
        @param sql:查询ＳＱＬ，如果有查询条件，请只指定条件列表，并将条件值使用参数[param]传递进来
        @param param: 可选参数，条件列表值（元组/列表）
        @return: result list(字典对象)/boolean 查询到的结果集
        """
        if param is None:
            count = self._cursor.execute(sql)
        else:
            count = self._cursor.execute(sql, param)
        if count > 0:
            result = self._cursor.fetchall()
            for item in result:
                item = self.bytesToStr(item)

            return [Row(row) for row in result]
        else:
            result = []

        for item in result:
            item = self.bytesToStr(item)
        return result

    def get(self, sql, param=None):
        """
        @summary: 执行查询，并取出第一条
        @param sql:查询ＳＱＬ，如果有查询条件，请只指定条件列表，并将条件值使用参数[param]传递进来
        @param param: 可选参数，条件列表值（元组/列表）
        @return: result list/boolean 查询到的结果集
        """
        if param is None:
            count = self._cursor.execute(sql)
        else:
            count = self._cursor.execute(sql, param)
        if count > 0:
            result = self._cursor.fetchone()
            result = self.bytesToStr(result)
            return Row(result)
        else:
            result = None

        return self.bytesToStr(result)

    def getMany(self, sql, num, param=None):
        """
        @summary: 执行查询，并取出num条结果
        @param sql:查询ＳＱＬ，如果有查询条件，请只指定条件列表，并将条件值使用参数[param]传递进来
        @param num:取得的结果条数
        @param param: 可选参数，条件列表值（元组/列表）
        @return: result list/boolean 查询到的结果集
        """
        if param is None:
            count = self._cursor.execute(sql)
        else:
            count = self._cursor.execute(sql, param)
        if count > 0:
            result = self._cursor.fetchmany(num)
        else:
            result = None
        return result

    def insert(self, sql, value):
        """
        @summary: 向数据表插入一条记录
        @param sql:要插入的ＳＱＬ格式
        @param value:要插入的记录数据tuple/list
        @return: insertId 受影响的行数
        """
        self._cursor.execute(sql, value)
        return self.__getInsertId()

    def insertMany(self, sql, values):
        """
        @summary: 向数据表插入多条记录
        @param sql:要插入的ＳＱＬ格式
        @param values:要插入的记录数据tuple(tuple)/list[list]
        @return: count 受影响的行数
        """
        count = self._cursor.executemany(sql, values)
        return count

    def __getInsertId(self):
        """
        获取当前连接最后一次插入操作生成的id,如果没有则为０
        """
        self._cursor.execute("SELECT @@IDENTITY AS id")
        result = self._cursor.fetchall()
        return result[0]['id']

    def __execute(self, sql, param=None):
        if param is None:
            count = self._cursor.execute(sql)
        else:
            count = self._cursor.execute(sql, param)
        return count

    def update(self, sql, param=None):
        """
        @summary: 更新数据表记录
        @param sql: ＳＱＬ格式及条件，使用(%s,%s)
        @param param: 要更新的  值 tuple/list
        @return: count 受影响的行数
        """
        return self.__execute(sql, param)

    def updateMany(self, sql, values):
        count = self._cursor.executemany(sql, values)
        return count

    def delete(self, sql, param=None):
        """
        @summary: 删除数据表记录
        @param sql: ＳＱＬ格式及条件，使用(%s,%s)
        @param param: 要删除的条件 值 tuple/list
        @return: count 受影响的行数
        """
        return self.__execute(sql, param)

    def deleteMany(self, sql, values):
        """
        @summary: 删除多条数据表记录
        @param sql: ＳＱＬ格式及条件，使用(%s,%s)
        @values : 要删除的条件 值 list
        @return: count 受影响的行数
        """
        return self._cursor.executemany(sql, values)

    def begin(self):
        """
        @summary: 开启事务
        """
        self._conn.autocommit(0)

    def end(self, option='commit'):
        """
        @summary: 结束事务
        """
        if option == 'commit':
            self._conn.commit()
        else:
            self._conn.rollback()

    def dispose(self, isEnd=1):
        """
        @summary: 释放连接池资源
        """
        if isEnd == 1:
            self.end('commit')
        else:
            self.end('rollback');
        self._cursor.close()
        self._conn.close()

    def paginator(self, sql, param=None, page=1, display=5):
        # 分页器
        if param is None:
            count = self._cursor.execute(sql)
        else:
            count = self._cursor.execute(sql, param)
        if (page <= 0): page = 1
        if (display <= 0):  # 显示行数不能小于0
            return None
        paginator = Paginator(count=count, page=page, display=display)
        limit_start = (paginator.number - 1) * display
        if (limit_start > count or count <= 0):  # 起始行不能大于总行数
            return paginator

        self._cursor.scroll(limit_start, mode='absolute')  # 游标移动到指定位置

        result = self._cursor.fetchmany(display)
        paginator.DataList = [Row(row) for row in result]

        return paginator

# db = Mysql()
# sql = ""
# count = db.insert(sql, (emp_id, dept_id, emp_name, phone, identity, open_id, head_img_url, nick_name, firm_name, firm_license_url, firm_code, title))
# db.dispose()

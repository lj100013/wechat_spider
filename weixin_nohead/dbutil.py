#!/usr/bin/env python
#coding=utf-8
import pymysql

class DB():
    def __init__(self, DB_HOST, DB_PORT, DB_USER, DB_PWD, DB_NAME):
        self.DB_HOST = DB_HOST
        self.DB_PORT = DB_PORT
        self.DB_USER = DB_USER
        self.DB_PWD = DB_PWD
        self.DB_NAME = DB_NAME

        self.conn = self.getConnection()

    def getConnection(self):
        return pymysql.Connect(
            host=self.DB_HOST, #设置MYSQL地址
            port=self.DB_PORT, #设置端口号
            user=self.DB_USER, #设置用户名
            passwd=self.DB_PWD, #设置密码
            db=self.DB_NAME, #数据库名
            charset='utf8' #设置编码
        )
    def close(self):
        self.conn.close()

    def query(self, sqlString):
        cursor=self.conn.cursor()
        cursor.execute(sqlString)
        returnData=cursor.fetchall()
        cursor.close()
        return returnData

    def queryone(self, sqlString):
        cursor=self.conn.cursor()
        cursor.execute(sqlString)
        returnData=cursor.fetchone()
        cursor.close()
        return returnData

    def update(self,sqlString):
        cursor=self.conn.cursor()
        cursor.execute(sqlString)
        self.conn.commit()
        cursor.close()

    def insert(self,sqlString,data):
        cursor=self.conn.cursor()
        cursor.execute(sqlString,data)
        self.conn.commit()
        cursor.close()


if __name__=="__main__":
    db=DB("192.168.3.122",3306,"root", "dachen@123", "wordpress")
    data = []
    data.append('1')
    print(db.query("show tables;"))
    db.close()
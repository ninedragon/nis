package com.zz.common.utils;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
 
public class MyThreadDelete extends Thread{
                public void run() {
//                	 String url="jdbc:mysql://192.168.0.209:3306/test?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";
//                     String url = "jdbc:mysql://192.168.0.151:3308/test?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true"; 
             		String url = "jdbc:mysql://192.168.0.151:3308/test_thread?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";// 本地test_thread
                     String name = "com.mysql.jdbc.Driver"; 
                     String user = "root"; 
                     String password = "123456"; 
                    Connection conn = null; 
                    try {
                        Class.forName(name);
                        conn = DriverManager.getConnection(url, user, password);//获取连接 
                        conn.setAutoCommit(false);//关闭自动提交，不然conn.commit()运行到这句会报错
                    } catch (ClassNotFoundException e1) {
                        e1.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                // 开始时间
                Long begin = System.currentTimeMillis();
                // sql前缀
                String prefix = "DELETE from t_opdata limit 10000; ";
                try {
                    // 保存sql后缀
                    StringBuffer suffix = new StringBuffer();
                    // 设置事务为非自动提交
//                    conn.setAutoCommit(false);
                    // 比起st，pst会更好些
                    PreparedStatement  pst = (PreparedStatement) conn.prepareStatement("");//准备执行语句
                    // 外层循环，总提交事务次数
                    for (int i = 1; i <= 10; i++) {
                        suffix = new StringBuffer();
                        // 第j次提交步长
                        for (int j = 1; j <= 1; j++) {
                            // 构建SQL后缀
                           suffix.append("DELETE from t_opdata limit 1000;");
                        }
                        // 构建完整SQL
                        String sql = prefix + suffix;
                        // 添加执行SQL
                        pst.addBatch(sql);
                        // 执行操作
                        System.out.println("start开始执行当前线程删除100万："+currentThread());
                        pst.executeBatch();
                        System.out.println("当前线程删除100万："+currentThread());
                        // 提交事务
//                        conn.commit();
                        // 清空上一次添加的数据
                        suffix = new StringBuffer();
                    }
                    // 头等连接
                    pst.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                // 结束时间
                Long end = System.currentTimeMillis();
                // 耗时
                System.out.println("100万条数据插入花费时间 : " + (end - begin) / 1000.0000000000000000000000000000000000 + " s"+"  插入完成");
    }  
}
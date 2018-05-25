package com.zz.common.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public class MyThread extends Thread {
	private String writePath;
	public String getWritePath() {
		return writePath;
	}
	public void setWritePath(String writePath) {
		this.writePath = writePath;
	}
	public MyThread(String writePath) {
		super();
		this.writePath = writePath;
	}
	public void run() {
		// String url="jdbc:mysql://192.168.0.209:3306/test?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";//远程test
		// String url ="jdbc:mysql://192.168.0.151:3308/test?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";//本地test
		String url = "jdbc:mysql://192.168.0.151:3308/test?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";// 209test_sql
//		String url = "jdbc:mysql://192.168.0.151:3308/test_thread?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";// 本地test_thread
		String name = "com.mysql.jdbc.Driver";
		String user = "root";
		String password = "123456";
		Connection conn = null;
		try {
			Class.forName(name);
			conn = DriverManager.getConnection(url, user, password);// 获取连接
			conn.setAutoCommit(false);// 关闭自动提交，不然conn.commit()运行到这句会报错
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 开始时间
		Long begin = System.currentTimeMillis();
		// sql前缀
		String prefix = "INSERT INTO t_opdata (C_DistrictBCDId, C_AddressId, C_RecordDateBCD, C_TSegmentId, C_ChannelId, C_TKWh, C_FaultId, C_FrameCmdId, C_EEHexId, C_EESequenceId, C_EEKWh, C_EEOpenMinute, C_EECloseMinute, C_EEOpenCloseTimes, C_EEPeakW, C_RecordInsertTime, C_IsValidRecord) VALUES  ";
		try {
			// 保存sql后缀
			StringBuffer suffix = new StringBuffer();
			// 设置事务为非自动提交
			conn.setAutoCommit(false);
			// 比起st，pst会更好些
			PreparedStatement pst = (PreparedStatement) conn
					.prepareStatement("");// 准备执行语句
			// 外层循环，总提交事务次数
			for (int i = 1; i <= 10; i++) {
				suffix = new StringBuffer();
				// 第j次提交步长
				for (int j = 1; j <= 10000; j++) {
					// 构建SQL后缀
					suffix.append("("
							+ "\"0412\",\"0048\",240833,\"89\",\"10\",\"-0.001620\",\"1\",\"84\",\"ff\",\"0\",\"0.000000\",\"0\",\"0\",\"0\",\"0.000000\",\"2017-02-27 20:45:46\",\" 1\""
							+ "),");
				}
				// 构建完整SQL
				String sql = prefix + suffix.substring(0, suffix.length() - 1);
				// 添加执行SQL
				pst.addBatch(sql);
				// 执行操作
				pst.executeBatch();
				System.out.println("当前线程：" + currentThread());
				// 提交事务
				conn.commit();
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
		System.out.println("100万条数据插入花费时间 : " + (end - begin)
				/ 1000.0000000000000000000000000000000000 + " s" + "  插入完成");
	}
	public MyThread() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MyThread(Runnable target, String name) {
		super(target, name);
		// TODO Auto-generated constructor stub
	}
	public MyThread(Runnable target) {
		super(target);
		// TODO Auto-generated constructor stub
	}
	public MyThread(ThreadGroup group, Runnable target, String name,
			long stackSize) {
		super(group, target, name, stackSize);
		// TODO Auto-generated constructor stub
	}
	public MyThread(ThreadGroup group, Runnable target, String name) {
		super(group, target, name);
		// TODO Auto-generated constructor stub
	}
	public MyThread(ThreadGroup group, Runnable target) {
		super(group, target);
		// TODO Auto-generated constructor stub
	}
	public MyThread(ThreadGroup group, String name) {
		super(group, name);
		// TODO Auto-generated constructor stub
	}
}
package com.zz.common.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;
import java.util.Map;

public class Batdemo {

//	// [1]生成bat
//	Map<String, Object> msgmap = new HashMap<String, Object>();
//	File sqlFile = new File(writePath);
//	String parentPath = sqlFile.getParent();
//	String batPath = sqlFile.getParent() + "\\opdataSql.bat";
//	File batFile = new File(batPath);
//	batFile.delete();
//	try {
//		batFile.createNewFile();
//		BufferedWriter out = new BufferedWriter(new FileWriter(batFile,
//				true));
//		StringBuilder bat = new StringBuilder();
//		// @echo off
//		// set /p dbname=输入数据库名：
//		// echo 开始导入...
//		// mysql -uroot -p123456 %dbname%< D:\000test\t_opdata.sql
//		// echo 导入完毕,按任意键结束
//		// pause
//		bat.append("@echo off\r\n");
//		bat.append("for %%i in (" + parentPath + File.separator
//				+ "t_opdata*.sql" + ") do (\r\n ");
//		bat.append("echo excute %%i \r\n");
//		bat.append("mysql -uroot -p123456 " + dbname + "< %%i\r\n");
//		bat.append(") \r\n");
//		bat.append("echo success \r\n");
//		// out.write(sqladd().toString()); // \r\n即为换行
//		out.write(bat.toString());
//		out.flush(); // 把缓存区内容压入文件
//		out.close(); // 最后记得关闭文件
//	} catch (Exception e) {
//		msgmap.put("isSuccess", false);
//		return msgmap;
//	}
//
//	// [2]执行bat
//	Long startTime = System.currentTimeMillis();
//	new Cmd(batPath);
//	// Long endtime = System.currentTimeMillis();
//	// Boolean isOk = (endtime - startTime) > 5000;
//	// System.out.println(endtime - startTime);
//	// if (!isOk) {
//	// msgmap.put("isSuccess", false);
//	// return msgmap;
//	// }以前为了判断导入错误的代码
//	msgmap.put("isSuccess", true);
//	// 计算文件大小
//	File countFile = new File(parentPath);
//	double timeEst = estTime(countFile);
//	msgmap.put("timeEst", timeEst);
//	return msgmap;

}

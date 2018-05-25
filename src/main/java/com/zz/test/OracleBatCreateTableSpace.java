package com.zz.test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;

public class OracleBatCreateTableSpace {
	public static void main(String[] args) throws Exception {
//		OracleBatch();
		String path = "D:\\004NIS开发ing\\000相关\\004Oracle\\南瑞提供20180126\\luchunyan\\suanfa及程序\\存储过程部署步骤\\1、建表语句";   
        getFile(path);
	}

	// 001批量建立oracle表空间
	private static void OracleBatch() throws Exception {
		// 读取最后文件
		File fout = new File("C:\\Users\\90807\\Desktop\\批量建立表空间.sql");
		FileOutputStream fos = new FileOutputStream(fout);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
		String s = "";
		// 读取每个字符串
		File fout2 = new File("C:\\Users\\90807\\Desktop\\a.txt");
		FileInputStream fos2 = new FileInputStream(fout2);
		BufferedReader bw2 = new BufferedReader(new InputStreamReader(fos2));
		for (int i = 0; i < 35; i++) {
			s = "";
			s = bw2.readLine();
			bw.write(" create tablespace "
					+ s
					+ " datafile '/home/oracle/tools/oracle11g/oradata/orcl/"
					+ s
					+ ".dbf' size 200m autoextend on next 10m maxsize unlimited;");
			bw.newLine();
		}

		bw.close();

	}

	// 002批量執行sql语句
	private static void OracleBatchSql() throws Exception {
		// 002.1读取某个目录所有文件名
		File fout2 = new File("C:\\Users\\90807\\Desktop\\a.txt");
		FileInputStream fos2 = new FileInputStream(fout2);
		BufferedReader bw2 = new BufferedReader(new InputStreamReader(fos2));

		String s = "";
		// 002.2写入某个sql，生成脚本
		File fout = new File("C:\\Users\\90807\\Desktop\\批量建立表空间.sql");
		FileOutputStream fos = new FileOutputStream(fout);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
		for (int i = 0; i < 35; i++) {
			s = "";
			s = bw2.readLine();
			bw.write(" create tablespace "
					+ s
					+ " datafile '/home/oracle/tools/oracle11g/oradata/orcl/"
					+ s
					+ ".dbf' size 200m autoextend on next 10m maxsize unlimited;");
			bw.newLine();
		}

		bw.close();

	};

	private static void getFile(String path) throws IOException {
		//写入的
		File fout = new File("C:\\Users\\90807\\Desktop\\all.sql");
		FileOutputStream fos = new FileOutputStream(fout);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
		String s = "";
		// get file list where the path has
		File file = new File(path);
		// get the folder list
		File[] array = file.listFiles();
        
		for (int i = 0; i < array.length; i++) {
			if (array[i].isFile()) {
				// only take file name
				System.out.println("^^^^^" + array[i].getName());
				// take file path and name
				System.out.println("#####" + array[i]);
				// take file path and name
				System.out.println("*****" + array[i].getPath());
				bw.write("@ "+array[i].getPath()+"");
				bw.newLine();
			} else if (array[i].isDirectory()) {
				getFile(array[i].getPath());
			}
		}
		bw.close();
	}
}

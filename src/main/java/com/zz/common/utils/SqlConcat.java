package com.zz.common.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import com.zz.edata.bo.SqltoolBO;
import com.zz.edata.bo.SqltoolJBO;

/**
 * @author 90807 sql导入。逻辑是sqlImportOpj中 判断文件夹非空--》
 *         makeFileSqlOpjStep1（1.创建opjumodata0.sql插入insert开头
 *         ）--》makeFileSqlOpj(判断文件夹中txt文件非空)
 */
public class SqlConcat {

	private static final int DATABASE_FAIL = -1;
	private static final int FAIL_TO_DELETE = -2;
	private static final Boolean IS_LAST = true;
	private static final Boolean NOT_LAST = false;
	private static final Boolean IS_FIRST = true;
	private static final Boolean NOT_FIRST = false;

	// public static void main(String[] args) {
	// String rootPath="E:\\录波数据\\苏州冬季";
	// Integer depth=2;
	// String reg="23XXXX";
	// String writePathOp="D:\\000test\\t_opdata.sql";
	// String writePathOpj="D:\\000test\\t_opjumpdata.sql";
	// sqlImportOp(rootPath,reg,depth,writePathOp);
	// sqlImportOpj(rootPath,reg,depth,writePathOpj);
	//
	// }

	public static Boolean sqlImportOpOld(SqltoolBO sqltoolBO) {
		String rootPath = sqltoolBO.getRootPath();
		String reg = sqltoolBO.getReg();
		Integer depth = sqltoolBO.getDepth();
		String writePathOp = sqltoolBO.getWritePath();
		File writePathOpjTo = new File(writePathOp);
		deleteDir(writePathOpjTo.getParent());
		try {

			Findfile findfile = new Findfile();
			Findfile.setDirRoot(new ArrayList<String>());
			findfile.find(rootPath, depth, reg);
			List<String> listDirRoot = findfile.getDirRoot();
			List<String> listDirRootValid = new ArrayList<String>();
			// 1.判断源文件夹非空
			for (int i = 0; i < listDirRoot.size(); i++) {
				File dirRoot = new File(listDirRoot.get(i));
				if (dirRoot.list().length != 0) {
					listDirRootValid.add(listDirRoot.get(i));
				}
			}
			for (int j = 0; j < listDirRootValid.size(); j++) {
				// 挑选出非空txt文件
				makeFileSqlOpStep1(writePathOp, j);// 1.创建文件 判断文件夹中文件非空
				System.out.println("=========================="
						+ listDirRootValid.get(j));
				makeFileSqlOp(listDirRootValid.get(j), writePathOp, IS_LAST, j);// 2.导入数据同时判断非空

				System.out.println(listDirRootValid);
				System.out.println("end");
			}
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

	// public static Map<String, Object> Import(SqltoolBO sqltoolBO) {
	// Map<String, Object> msgMap = new HashMap<String, Object>();
	// List sourceFileList = new ArrayList<>();
	// String writePath = "";
	// List<String> listDirRootValid = new ArrayList<String>();
	// // 【1】生成SQL文件
	// String rootPath = sqltoolBO.getRootPath();
	// String reg = sqltoolBO.getReg();
	// Integer depth = sqltoolBO.getDepth();
	// String writePathOp = sqltoolBO.getWritePath();
	// File writePathOpjTo = new File(writePathOp);
	// deleteDir(writePathOpjTo.getParent());
	// try {
	// // 【1】得到文件路径
	// Findfile findfile = new Findfile();
	// Findfile.setDirRoot(new ArrayList<String>());
	// findfile.find(rootPath, depth, reg);
	// List<String> listDirRoot = findfile.getDirRoot();
	// // 【1.1】判断源文件夹非空
	// for (int i = 0; i < listDirRoot.size(); i++) {
	// File dirRoot = new File(listDirRoot.get(i));
	// if (dirRoot.list().length != 0) {
	// listDirRootValid.add(listDirRoot.get(i));
	// }
	// }
	// // 【1.2】将文件数据导入到指定的路径
	//
	// // return true;
	// } catch (IOException e) {
	// e.printStackTrace();
	// // return false;
	// }
	// // 【2】生成SQL文件
	// generateSQL(listDirRootValid, writePath);
	// String sourcePath = writePath;
	// String prefix = "";
	// // 【3】从txt文件中插入数据库
	// insertFromTxt(sourcePath, prefix);
	// return msgMap;
	//
	// }
	// public static Map<String, Object> Import(SqltoolJBO sqltoolJBO) {
	// Map<String, Object> msgMap = new HashMap<String, Object>();
	// List sourceFileList = new ArrayList<>();
	// String writePath = "";
	// List<String> listDirRootValid = new ArrayList<String>();
	// // 【1】生成SQL文件
	// String rootPath = sqltoolJBO.getRootPathJ();
	// String reg = sqltoolJBO.getRegJ();
	// Integer depth = sqltoolJBO.getDepthJ();
	// String writePathOp = sqltoolJBO.getWritePathJ();
	// File writePathOpjTo = new File(writePathOp);
	// deleteDir(writePathOpjTo.getParent());
	// try {
	// // 【1】得到文件路径
	// Findfile findfile = new Findfile();
	// Findfile.setDirRoot(new ArrayList<String>());
	// findfile.find(rootPath, depth, reg);
	// List<String> listDirRoot = findfile.getDirRoot();
	// // 【1.1】判断源文件夹非空
	// for (int i = 0; i < listDirRoot.size(); i++) {
	// File dirRoot = new File(listDirRoot.get(i));
	// if (dirRoot.list().length != 0) {
	// listDirRootValid.add(listDirRoot.get(i));
	// }
	// }
	// // 【1.2】将文件数据导入到指定的路径
	//
	// // return true;
	// } catch (IOException e) {
	// e.printStackTrace();
	// // return false;
	// }
	// // 【2】生成SQL文件
	// generateSQL(listDirRootValid, writePath);
	// String sourcePath = writePath;
	// String prefix = "";
	// // 【3】从txt文件中插入数据库
	// insertFromTxt(sourcePath, prefix);
	// return msgMap;
	//
	// }

	public static Map<String, Object> Import(SqltoolBO sqltoolBO) {
		Map<String, Object> msgMap = new HashMap<String, Object>();
		List<String> listDirRootValid = new ArrayList<String>();
		// 【1】找到符合条件的文件
		String rootPath = sqltoolBO.getRootPath();
		String reg = sqltoolBO.getReg();
		Integer depth = sqltoolBO.getDepth();
		String writePath = sqltoolBO.getWritePath();
		String prefix = sqltoolBO.getPrefix();
		String url = sqltoolBO.getUrl();
		File writePathOp = new File(writePath);
		if (writePathOp.exists() && !writePathOp.delete()) {
			System.out.println("fail to delete " + writePathOp);
			msgMap.put("record", FAIL_TO_DELETE);
			return msgMap;
		}

		List<String> sourceFileList = new ArrayList<String>();
		try {
			// 【2】得到文件路径
			Findfile.setDirRoot(new ArrayList<String>());
			Findfile.find(rootPath, depth, reg);
			List<String> listDirRoot = Findfile.getDirRoot();
			// 【1.1】判断源文件夹非空
			for (int i = 0; i < listDirRoot.size(); i++) {
				File dirRoot = new File(listDirRoot.get(i));
				if (dirRoot.list().length != 0) {
					listDirRootValid.add(listDirRoot.get(i));
				}
			}
			// 【2.1】得到所有包含txt文件的list
			for (int j = 0; j < listDirRootValid.size(); j++) {
				File files = new File(listDirRootValid.get(j)); // 创建File对象,指向F盘根目录
				String[] names = files.list(); // 获取F盘根目录所有文件和路径,并以字符串数组返回

				// 【1】加入sql语句的头
				// makeFileSqlOpStep1(writePath);
				// [2]加入sql语句的数据
				for (int i = 0; i < names.length; i++) {
					Boolean isOP = names[i]
							.startsWith(sqltoolBO.getTxtPrefix());
					if (isOP) {
						sourceFileList.add(listDirRootValid.get(j)
								+ File.separator + names[i]);
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			// return false;
		} finally {
		}
		// 【2】生成SQL文件
		generateSQL(sourceFileList, writePath);
		String sourcePath = writePath;
		// 【3】从txt文件中插入数据库
		int record = insertFromTxt(sourcePath, prefix, url);
		msgMap.put("record", record);
		return msgMap;

	}

	/**
	 * @param sourceFileList
	 *            源文件路径的list
	 * @param writePath
	 *            写入文件的路径
	 */
	private static void generateSQL(List<String> sourceFileList,
			String writePath) {
		// 【1】清空原文件并创建新文件
		File dataFile = new File(writePath); // 相对路径，如果没有则要建立一个新的output。txt文件
		dataFile.delete();
		InputStreamReader reader = null;
		BufferedReader br = null;
		try {
			dataFile.createNewFile();
			BufferedWriter out = new BufferedWriter(new FileWriter(dataFile,
					true));
			// 【2】读取所有文件到writepath
			for (int i = 0; i < sourceFileList.size(); i++) {
				reader = new InputStreamReader(new FileInputStream(
						sourceFileList.get(i))); // 建立一个输入流对象reader
				br = new BufferedReader(reader);
				String lineTxt = null;
				StringBuilder sql = new StringBuilder();
				br.readLine();// 第一行文件不要
				br.readLine();// 第一行空格不要
				while ((lineTxt = br.readLine()) != null) {
					lineTxt = lineTxt.replace("True", "1");// 文件中true替换为1
					lineTxt = addCo(lineTxt); // 各字段添加“”
					// System.out.println(lineTxt);
					sql.append("(" + lineTxt + "),\r\n");
					br.readLine();
				}
				out.write(sql.toString());
				System.out.println("写入文件" + sourceFileList.get(i) + "完毕");
				br.close();
				reader.close();
			}
			out.flush(); // 把缓存区内容压入文件
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (null != br) {
				try {
					br.close();
				} catch (IOException e) {
					System.out.println(br + e.getMessage());
				}
			}
			;
			if (null != reader) {
				try {
					reader.close();
				} catch (IOException e) {
					System.out.println(reader + e.getMessage());
				}
			}
		}
	}

	/**
	 * @param sourcePath
	 *            txt来源文件路径
	 * @param prefix
	 *            插入的sql前缀
	 */
	private static int insertFromTxt(String sourcePath, String prefix,
			String url) {
		// 【1】读取文件

		// String
		// url="jdbc:mysql://192.168.0.209:3306/test?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";//远程test
		// String url
		// ="jdbc:mysql://192.168.0.151:3308/test?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";//本地test
		// String url =
		// "jdbc:mysql://192.168.0.151:3308/test_thread?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";//
		// 本地test_thread
		int record = 0;
		String name = "com.mysql.jdbc.Driver";
		String user = "root";
		String password = "123456";
		Connection conn = null;
		try {
			Class.forName(name);
			conn = DriverManager.getConnection(url, user, password);// 获取连接
			conn.setAutoCommit(false);// 关闭自动提交，不然conn.commit()运行到这句会报错
		} catch (ClassNotFoundException e1) {
			record = DATABASE_FAIL;
			e1.printStackTrace();
		} catch (SQLException e) {
			record = DATABASE_FAIL;
			e.printStackTrace();
		}
		// 开始时间
		Long begin = System.currentTimeMillis();
		// sql前缀
		// String prefix =
		// "INSERT INTO t_opdata (C_DistrictBCDId, C_AddressId, C_RecordDateBCD, C_TSegmentId, C_ChannelId, C_TKWh, C_FaultId, C_FrameCmdId, C_EEHexId, C_EESequenceId, C_EEKWh, C_EEOpenMinute, C_EECloseMinute, C_EEOpenCloseTimes, C_EEPeakW, C_RecordInsertTime, C_IsValidRecord) VALUES  ";
		// 保存sql后缀
		StringBuffer suffix = new StringBuffer();
		InputStreamReader reader = null;
		BufferedReader br = null;
		// 设置事务为非自动提交
		try {
			conn.setAutoCommit(false);
			// 比起st，pst会更好些
			PreparedStatement pst = (PreparedStatement) conn
					.prepareStatement("");// 准备执行语句
			// 外层循环，总提交事务次数
			// 生成一个输入流将.sql文件中内容导入
			reader = new InputStreamReader(new FileInputStream(sourcePath)); // 建立一个输入流对象reader
			br = new BufferedReader(reader);
			String lineTxt = null;
			int count = 1;
			lineTxt = br.readLine();
			while (true) {
				if (lineTxt == null) {
					String sql = prefix
							+ suffix.substring(0, suffix.length() - 1);
					pst.addBatch(sql);
					// 执行操作
					pst.executeBatch();
					conn.commit();
					break;
				};
				// 【1】未读完就继续读叠加
				// 【1.1】读到10000行就count清零
				suffix.append(lineTxt);
				if (count == 10000) {
					// 添加执行SQL
					String sql = prefix
							+ suffix.substring(0, suffix.length() - 1);
					pst.addBatch(sql);
					// 执行操作
					pst.executeBatch();
					conn.commit();
					suffix = new StringBuffer();
					count = 1;
					lineTxt = br.readLine();
					continue;
				}
				;
				lineTxt = br.readLine();
				record++;
				count++;
			}
			// 头等连接
			Long end = System.currentTimeMillis();
			System.out
					.println(record + "条数据插入花费时间 : " + (end - begin)
							/ 1000.0000000000000000000000000000000000 + " s"
							+ "  插入完成");
			pst.close();
			conn.close();
			br.close();
			reader.close();
		} catch (Exception e) {
			System.out
					.println(("loadProperties IOException:" + e.getMessage()));
			record = DATABASE_FAIL;
			e.printStackTrace();
		} finally {
			if (null != br) {
				try {
					br.close();
				} catch (IOException e) {
					System.out.println(br + e.getMessage());
				}
			}
			if (null != reader) {
				try {
					reader.close();
				} catch (IOException e) {
					System.out.println(reader + e.getMessage());
				}
			}
		}

		return record;
	}

	// public static Boolean sqlImportOp(SqltoolBO sqltoolBO) {
	// //【1】清空文件夹
	// String rootPath = sqltoolBO.getRootPath();
	// String reg = sqltoolBO.getReg();
	// Integer depth = sqltoolBO.getDepth();
	// String writePathOp = sqltoolBO.getWritePath();
	// File writePathOpjTo = new File(writePathOp);
	// deleteDir(writePathOpjTo.getParent());
	// try {
	// //【2】筛选
	// Findfile.setDirRoot(new ArrayList<String>());
	// Findfile.find(rootPath, depth, reg);
	// List<String> listDirRoot = Findfile.getDirRoot();
	// List<String> listDirRootValid = new ArrayList<String>();
	// // 【2.1】判断源文件夹非空
	// for (int i = 0; i < listDirRoot.size(); i++) {
	// File dirRoot=new File(listDirRoot.get(i));
	// if (dirRoot.list().length!=0) {
	// listDirRootValid.add(listDirRoot.get(i));
	// }
	// }
	// //【2.2】挑选非空txt
	// for (int j = 0; j < listDirRootValid.size(); j++) {
	// // 挑选出非空txt文件
	// makeFileSqlOpStep1(writePathOp, j);// 1.创建文件 判断文件夹中文件非空
	// System.out.println("=========================="
	// + listDirRootValid.get(j));
	// makeFileSqlOp(listDirRootValid.get(j), writePathOp, IS_LAST,
	// j);// 2.导入数据同时判断非空
	//
	// System.out.println(listDirRootValid);
	// System.out.println("end");
	// }
	// return true;
	// } catch (IOException e) {
	// e.printStackTrace();
	// return false;
	// }
	// }
	public static boolean sqlImportOpj(SqltoolJBO sqltoolJBO) {
		// sqlImport(readPath);
		// [1]txt文件改写
		// [2]变成sql语句
		String rootPath = sqltoolJBO.getRootPathJ();
		String reg = sqltoolJBO.getRegJ();
		Integer depth = sqltoolJBO.getDepthJ();
		String writePathOpj = sqltoolJBO.getWritePathJ();
		File writePathOpjTo = new File(writePathOpj);
		deleteDir(writePathOpjTo.getParent());
		try {

			Findfile findfile = new Findfile();
			Findfile.setDirRoot(new ArrayList<String>());
			findfile.find(rootPath, depth, reg);
			List<String> listDirRoot = findfile.getDirRoot();
			List<String> listDirRootValid = new ArrayList<String>();
			// 1.判断源文件夹非空
			for (int i = 0; i < listDirRoot.size(); i++) {
				File dirRoot = new File(listDirRoot.get(i));
				if (dirRoot.list().length != 0) {
					listDirRootValid.add(listDirRoot.get(i));
				}
			}
			for (int j = 0; j < listDirRootValid.size(); j++) {
				// 挑选出非空txt文件
				makeFileSqlOpjStep1(writePathOpj, j);// 1.创建文件 判断文件夹中文件非空
				System.out.println("=========================="
						+ listDirRootValid.get(j));
				makeFileSqlOpj(listDirRootValid.get(j), writePathOpj, IS_LAST,
						j);// 2.导入数据同时判断非空

				System.out.println(listDirRootValid);
				System.out.println("end");
			}
			// makeFileSqlOpjStep1(writePathOpj);
			// for (int i = 0; i < listDirRoot.size(); i++) {
			// if (i == listDirRoot.size() - 1) {
			// makeFileSqlOpj(listDirRoot.get(i), writePathOpj,IS_LAST);
			// } else {
			// makeFileSqlOpj(listDirRoot.get(i), writePathOpj,NOT_LAST);
			// }
			// }
			// System.out.println(listDirRoot);
			// System.out.println("end");
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 判断文件非空
	 * 
	 * @param string
	 * @return
	 */

	private static boolean txtNotEmpty(String txt) {
		/* 读入TXT文件 */
		try {//
			String pathname = txt; // 绝对路径或相对路径都可以，这里是绝对路径，写入文件时演示相对路径
			File filename = new File(pathname); // 要读取以上路径的input。txt文件
			InputStreamReader reader = new InputStreamReader(
					new FileInputStream(filename)); // 建立一个输入流对象reader
			BufferedReader br = new BufferedReader(reader); // 建立一个对象，它把文件内容转成计算机能读懂的语言
			String lineTxt = null;
			StringBuilder sql = new StringBuilder();
			br.readLine();// 第一行文件不要
			br.readLine();// 第一行空格不要
			lineTxt = br.readLine();// 读取第二行
			if (null == lineTxt) {
				System.out.println(txt + "没有数据");
				return false;
			}
			return true;
			// System.out.println("写入完毕");
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	private static void makeFileSqlOp(String dirPath, String writePath,
			Boolean isLast) {
		File files = new File(dirPath); // 创建File对象,指向F盘根目录
		String[] names = files.list(); // 获取F盘根目录所有文件和路径,并以字符串数组返回
		List<String> namesOp = new ArrayList<String>();
		// 【1】加入sql语句的头
		// makeFileSqlOpStep1(writePath);
		// [2]加入sql语句的数据
		for (int i = 0; i < names.length; i++) {
			Boolean isOP = names[i].startsWith("T_OPData");

			if (isOP) {
				namesOp.add(dirPath + File.separator + names[i]);
			}

		}
		for (int i = 0; i < namesOp.size(); i++) {
			if (i == namesOp.size() - 1 && isLast) {
				makeSql(namesOp.get(i), writePath, IS_LAST);
			} else {
				makeSql(namesOp.get(i), writePath, NOT_LAST);
			}
		}

	}

	private static void makeFileSqlOp(String dirPath, String writePath,
			Boolean isLast, Integer fileSuffix) {
		File files = new File(dirPath); // 创建File对象,指向F盘根目录
		String[] txtReadPathRaw = files.list(); // 获取F盘根目录所有文件和路径,并以字符串数组返回
		List<String> txtReadPath = new ArrayList<String>();
		// for (int i = 0; i < txtReadPathRaw.length; i++) {
		// Boolean isOP = txtReadPathRaw[i].startsWith("T_OPData");//
		// 判断是否有opjump
		//
		// if (isOP) {
		// if (txtNotEmpty(dirPath + File.separator + txtReadPathRaw[i])) {//
		// 判断有opjump的txt是否非空
		// txtReadPath.add(dirPath + File.separator
		// + txtReadPathRaw[i]);
		// }
		// }
		//
		// }
		// 发现没有文件则清空该文件夹
		if (txtReadPath.size() == 0) {
			File file = new File(writePath.substring(0, writePath.length() - 4)
					+ fileSuffix + ".sql");
			try {
				if (!file.exists()) {
					file.createNewFile();
				}
				FileWriter fileWriter = new FileWriter(file);
				fileWriter.write("");
				fileWriter.flush();
				fileWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		for (int i = 0; i < txtReadPath.size(); i++) {
			String writePathFor = "";

			writePathFor = writePath.substring(0, writePath.length() - 4)
					+ fileSuffix + ".sql";
			if (i == txtReadPath.size() - 1 && isLast) {
				makeSql(txtReadPath.get(i), writePathFor, IS_LAST);
			} else {
				makeSql(txtReadPath.get(i), writePathFor, NOT_LAST);
			}
		}

	}

	private static void makeFileSqlOpj(String dirPath, String writePath,
			Boolean isLast, Integer fileSuffix) {
		File files = new File(dirPath); // 创建File对象,指向F盘根目录
		String[] txtReadPathRaw = files.list(); // 获取F盘根目录所有文件和路径,并以字符串数组返回
		List<String> txtReadPath = new ArrayList<String>();
		for (int i = 0; i < txtReadPathRaw.length; i++) {
			Boolean isOP = txtReadPathRaw[i].startsWith("T_OPJumpData");// 判断是否有opjump

			if (isOP) {
				if (txtNotEmpty(dirPath + File.separator + txtReadPathRaw[i])) {// 判断有opjump的txt是否非空
					txtReadPath.add(dirPath + File.separator
							+ txtReadPathRaw[i]);
				}
			}

		}
		// 发现没有文件则清空该文件夹
		if (txtReadPath.size() == 0) {
			File file = new File(writePath.substring(0, writePath.length() - 4)
					+ fileSuffix + ".sql");
			try {
				if (!file.exists()) {
					file.createNewFile();
				}
				FileWriter fileWriter = new FileWriter(file);
				fileWriter.write("");
				fileWriter.flush();
				fileWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		for (int i = 0; i < txtReadPath.size(); i++) {
			String writePathFor = "";

			writePathFor = writePath.substring(0, writePath.length() - 4)
					+ fileSuffix + ".sql";
			if (i == txtReadPath.size() - 1 && isLast) {
				makeSql(txtReadPath.get(i), writePathFor, IS_LAST);
			} else {
				makeSql(txtReadPath.get(i), writePathFor, NOT_LAST);
			}
			// if (i == namesOp.size() - 1 && isLast) {
			// makeSql(namesOp.get(i), writePathFor, IS_LAST);
			// } else {
			// makeSql(namesOp.get(i), writePathFor, NOT_LAST);
			// }
		}

	}

	/**
	 * 加入对应的SQL语句前部
	 * 
	 * @param readPath
	 * @param writePath
	 */
	private static void makeFileSqlOpStep1(String writePath) {

		/* 读入TXT文件 */
		try {//

			File writename = new File(writePath); // 相对路径，如果没有则要建立一个新的output。txt文件
			if (!writename.exists()) {
				writename.createNewFile();
			} else {
				writename.delete();
				writename.createNewFile();
			}
			// 创建新文件
			BufferedWriter out = new BufferedWriter(new FileWriter(writename,
					true));
			StringBuilder sql = new StringBuilder();

			sql.append(
					"INSERT INTO t_opdata (C_DistrictBCDId, C_AddressId, C_RecordDateBCD, C_TSegmentId, C_ChannelId, C_TKWh, C_FaultId, C_FrameCmdId, C_EEHexId, C_EESequenceId, C_EEKWh,")
					.append(" C_EEOpenMinute, C_EECloseMinute, C_EEOpenCloseTimes, C_EEPeakW, C_RecordInsertTime, C_IsValidRecord) VALUES ");
			// out.write(sqladd().toString()); // \r\n即为换行
			out.write(sql.toString());
			out.flush(); // 把缓存区内容压入文件
			out.close(); // 最后记得关闭文件
			// System.out.println("写入完毕");
		} catch (Exception e) {
			e.printStackTrace();
		}
		;

	}

	private static void makeFileSqlOpStep1(String writePath, Integer fileSuffix) {

		/* 读入TXT文件 */
		try {//
			writePath = writePath.substring(0, writePath.length() - 4)
					+ fileSuffix + ".sql";

			File writename = new File(writePath); // 相对路径，如果没有则要建立一个新的output。txt文件
			writename.delete();
			writename.createNewFile();
			// 创建新文件
			BufferedWriter out = new BufferedWriter(new FileWriter(writename,
					true));
			StringBuilder sql = new StringBuilder();
			sql.append(
					"INSERT INTO t_opdata (C_DistrictBCDId, C_AddressId, C_RecordDateBCD, C_TSegmentId, C_ChannelId, C_TKWh, C_FaultId, C_FrameCmdId, C_EEHexId, C_EESequenceId, C_EEKWh,")
					.append(" C_EEOpenMinute, C_EECloseMinute, C_EEOpenCloseTimes, C_EEPeakW, C_RecordInsertTime, C_IsValidRecord) VALUES ");
			// out.write(sqladd().toString()); // \r\n即为换行
			out.write(sql.toString());
			out.flush(); // 把缓存区内容压入文件
			out.close(); // 最后记得关闭文件
			// System.out.println("写入完毕");
		} catch (Exception e) {
			e.printStackTrace();
		}
		;

	}

	/**
	 * @param writePath
	 * @param fileSuffix
	 */
	private static void makeFileSqlOpjStep1(String writePath, Integer fileSuffix) {

		/* 读入TXT文件 */
		try {//
			writePath = writePath.substring(0, writePath.length() - 4)
					+ fileSuffix + ".sql";

			File writename = new File(writePath); // 相对路径，如果没有则要建立一个新的output。txt文件
			writename.delete();
			writename.createNewFile();
			// 创建新文件
			BufferedWriter out = new BufferedWriter(new FileWriter(writename,
					true));
			StringBuilder sql = new StringBuilder();

			sql.append("INSERT INTO t_opjumpdata (C_DistrictBCDId,C_AddressId,C_RecordDateBCD,C_TSegmentId,C_ChannelId,C_ParaId,C_EESequenceId,C_EEHexId,C_JumpSecond,C_KW,C_FrameCmdId,C_RecordInsertTime) VALUES ");

			// out.write(sqladd().toString()); // \r\n即为换行
			out.write(sql.toString());
			out.flush(); // 把缓存区内容压入文件
			out.close(); // 最后记得关闭文件
			// System.out.println("写入完毕");
		} catch (Exception e) {
			e.printStackTrace();
		}
		;

	}

	/**
	 * 将某一个文件opdata的txt变成SQL语句
	 * 
	 * @param readPath
	 *            传入路径
	 * @param writePath
	 *            保存的路径
	 * @param isLast
	 */
	private static void makeSql(String readPath, String writePath,
			Boolean isLast) {
		/* 读入TXT文件 */
		try {//
			String pathname = readPath; // 绝对路径或相对路径都可以，这里是绝对路径，写入文件时演示相对路径
			File filename = new File(pathname); // 要读取以上路径的input。txt文件
			InputStreamReader reader = new InputStreamReader(
					new FileInputStream(filename)); // 建立一个输入流对象reader
			BufferedReader br = new BufferedReader(reader); // 建立一个对象，它把文件内容转成计算机能读懂的语言

			File writename = new File(writePath); // 相对路径，如果没有则要建立一个新的output。txt文件
			if (!writename.exists()) {
				writename.createNewFile();
			}// 创建新文件
			BufferedWriter out = new BufferedWriter(new FileWriter(writename,
					true));
			String lineTxt = null;
			StringBuilder sql = new StringBuilder();
			br.readLine();// 第一行文件不要
			br.readLine();// 第一行空格不要
			// System.out.println(lineTxt);
			while ((lineTxt = br.readLine()) != null) {
				lineTxt = lineTxt.replace("True", "1");// 文件中true替换为1
				lineTxt = addCo(lineTxt); // 各字段添加“”
				// System.out.println(lineTxt);
				sql.append("(" + lineTxt + "),");
				br.readLine();
			}
			if (isLast) {
				sql = new StringBuilder(sql.substring(0, sql.length() - 1));
			}
			//
			// out.write(sqladd().toString()); // \r\n即为换行
			out.write(sql.toString());
			out.flush(); // 把缓存区内容压入文件
			out.close(); // 最后记得关闭文件
			// System.out.println("写入完毕");
		} catch (Exception e) {
			e.printStackTrace();
		}
		;
	}

	private static String addCo(String lineTxt) {
		List<String> result = Arrays.asList(lineTxt.split(","));
		for (int i = 0; i < result.size(); i++) {
			result.set(i, "\"" + result.get(i) + "\"");

		}
		return listToString(result);

	}

	public static String listToString(List<String> stringList) {
		if (stringList == null) {
			return null;
		}
		StringBuilder result = new StringBuilder();
		boolean flag = false;
		for (String string : stringList) {
			if (flag) {
				result.append(",");
			} else {
				flag = true;
			}
			result.append(string);
		}
		return result.toString();
	}

	/**
	 * 清空文件夹
	 * 
	 * @param path
	 * @return
	 */
	public static boolean deleteDir(String path) {
		File file = new File(path);
		if (!file.exists()) {// 判断是否待删除目录是否存在
			System.err.println("The dir are not exists!");
			return false;
		}

		String[] content = file.list();// 取得当前目录下所有文件和文件夹
		for (String name : content) {
			File temp = new File(path, name);
			if (temp.isDirectory()) {// 判断是否是目录
				deleteDir(temp.getAbsolutePath());// 递归调用，删除目录里的内容
				temp.delete();// 删除空目录
			} else {
				if (!temp.delete()) {// 直接删除文件
					System.err.println("Failed to delete " + name);
				}
			}
		}
		return true;
	}

	public static void main(String[] args) {
		SqltoolJBO sqltoolJBO = new SqltoolJBO("E:\\录波数据\\苏州冬季", "23XXXX", 3,
				"D:\\000test\\t_opjumpdata.sql");
		List<String> sourceFileList = new ArrayList<String>();
		sourceFileList
				.add("D:\\录波数据\\苏州夏季\\04121001-18-02-13-11-31-08\\22XXXX\\T_OPData_0.txt");
		sourceFileList
				.add("D:\\录波数据\\苏州夏季\\04121001-18-02-13-11-31-08\\22XXXX\\T_OPData_1.txt");
		String writePath = "D:\\001test\\t_opdata.sql";
		// generateSQL(sourceFileList, writePath);
		String url = "jdbc:mysql://192.168.0.151:3308/test1?useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";// 151test_sql
		String prefix = "INSERT INTO t_opdata (C_DistrictBCDId, C_AddressId, C_RecordDateBCD, C_TSegmentId, C_ChannelId, C_TKWh, C_FaultId, C_FrameCmdId, C_EEHexId, C_EESequenceId, C_EEKWh, C_EEOpenMinute, C_EECloseMinute, C_EEOpenCloseTimes, C_EEPeakW, C_RecordInsertTime, C_IsValidRecord) VALUES  ";
		insertFromTxt(writePath, prefix, url);
	}
}

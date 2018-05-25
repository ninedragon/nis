package com.zz.edata.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.zz.common.dao.DeviceinfoMapper;
import com.zz.common.dao.EeclassificationMapper;
import com.zz.common.dao.EeclassificationgrpMapper;
import com.zz.common.dao.OpdataMapper;
import com.zz.common.dao.OpjumpdataMapper;
import com.zz.common.model.Deviceinfo;
import com.zz.common.model.Eeclassification;
import com.zz.common.model.Eeclassificationgrp;
import com.zz.common.model.Opdata;
import com.zz.common.utils.CCRDFile;
import com.zz.common.utils.Cmd;
import com.zz.common.utils.FilePathShow;
import com.zz.common.utils.FileUtils;
import com.zz.common.utils.Findfile;
import com.zz.common.utils.SqlConcat;
import com.zz.core.mybatis.page.Pagination;
import com.zz.edata.bo.BaseLinkSelectBO;
import com.zz.edata.bo.EquxianBo;
import com.zz.edata.bo.FenxiangBo;
import com.zz.edata.bo.LinkSelectBO;
import com.zz.edata.bo.OpEegrpBO;
import com.zz.edata.bo.SqltoolBO;
import com.zz.edata.bo.SqltoolJBO;
import com.zz.edata.bo.SubcompareBO;
import com.zz.edata.bo.YuanshiBo;
import com.zz.edata.bo.YuanshijBo;
import com.zz.edata.bo.ZdBo;
import com.zz.edata.bo.ZongBo;

/**
 * @author 90807
 *
 */
/**
 * @author 90807
 *
 */
/**
 * @author 90807
 * 
 */
@Service
public class EdataServiceImpl implements com.zz.edata.service.EdataService {
	@Autowired
	DeviceinfoMapper deviceinfoMapper;
	@Autowired
	EeclassificationgrpMapper eeclassificationgrpMapper;
	@Autowired
	OpdataMapper opdataMapper;
	@Autowired
	OpjumpdataMapper opjumpdataMapper;
	@Autowired
	EeclassificationMapper eeclassificationMapper;


	private String rootPath = "";

	@Override
	public Pagination<ZongBo> findRoleAndPermissionPage(ModelMap modelMap,
			Integer pageNo, int pageSize) {
		return null;
	}

	@Override
	public Pagination<FenxiangBo> findFenxiangPage(ModelMap modelMap,
			Integer pageNo, int pageSize) {
		return null;
	}

	@Override
	public Pagination<ZdBo> findZdPage(ModelMap modelMap, Integer pageNo,
			int pageSize) {
		return null;
	}

	@Override
	public Pagination<EquxianBo> findEquxianPage(ModelMap modelMap,
			Integer pageNo, int pageSize) {
		return null;
	}

	@Override
	public Pagination<YuanshiBo> findYuanshiPage(ModelMap modelMap,
			Integer pageNo, int pageSize) {
		return null;
	}

	@Override
	public Pagination<YuanshijBo> findYuanshijPage(ModelMap modelMap,
			Integer pageNo, int pageSize) {
		return null;
	}

	@Override
	public List<Deviceinfo> findAllDistrict() {
		List<Deviceinfo> dlist = deviceinfoMapper.selectAllDeviceDis();
		return dlist;
	}

	@Override
	public List<Eeclassificationgrp> findAllGroup() {
		List<Eeclassificationgrp> eglist = eeclassificationgrpMapper
				.selectAllEG();
		return eglist;
	}

	@Override
	public List<Opdata> findOpdatasByGrp(OpEegrpBO opEegrpBO) {
		List<Opdata> olist = opdataMapper.selectOpdatasByGrp(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> getZongData(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectOpdatasForZong(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> getPower(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectOpdatasPower(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> findfenData(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectOpdatasForFen(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> findGrid(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectOpdatasForGrid(opEegrpBO);
		return olist;
	}

	@Override
	public Integer findGridCount(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectOpdatasForGridCount(opEegrpBO);
		return count;
	}

	@Override
	public List<HashMap<String, Object>> getPowerEE(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectOpdatasPowerEE(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> findFendataDraw(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectFendataDraw(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> findGridV22(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectGridV22(opEegrpBO);
		return olist;
	}

	@Override
	public Integer findGridCountV22(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectGridCountV22(opEegrpBO);
		return count;
	}

	@Override
	public Integer findYuanshiCountV31(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectGridCountV31(opEegrpBO);
		return count;
	}

	@Override
	public List<HashMap<String, Object>> findYuanshiV31(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectGridV31(opEegrpBO);
		return olist;
	}

	@Override
	public Integer findYuanshiCountV41(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectGridCountV41(opEegrpBO);
		return count;
	}

	@Override
	public List<HashMap<String, Object>> findYuanshiV41(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectGridV41(opEegrpBO);
		return olist;
	}

	@Override
	public Integer findSuanfaCountV51(OpEegrpBO opEegrpBO) {
		Integer count = opjumpdataMapper.selectGridCountV51(opEegrpBO);
		return count;
	}

	@Override
	public List<HashMap<String, Object>> findSuanfaV51(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opjumpdataMapper
				.selectGridV51(opEegrpBO);
		return olist;
	}

	@Override
	public List<Eeclassification> findAllEE() {
		System.out.println("findAllEE");
		List<Eeclassification> eglist = eeclassificationMapper.selectAllEE();
		return eglist;
	}

	@Override
	public HashMap<String, Object> listChartData(OpEegrpBO opEegrpBO,
			String jump) {
		Integer delta = 0;
		CCRDFile cf = new CCRDFile();
		Integer startPoint = opEegrpBO.getStartPoint();
		Integer endPoint = opEegrpBO.getEndPoint();
		System.out.println("jump是" + jump);
		InputStream in = null;
		InputStreamReader ir = null;
		BufferedReader br = null;
		FileOutputStream out = null;
		OutputStreamWriter outWriter = null;
		BufferedWriter bufWrite = null;
		HashMap<String, Object> v52map = new HashMap<String, Object>();
		Integer i = 0;// 目的：记录有多少行
		Integer j = 0;// 目的：记录从哪里开始添加进去

		try {
			// 1.拼出要找的文件：目的:为了去找到指定的txt，因为文件是在指定的文件夹里

			rootPath = opEegrpBO.getRootPath();
			// System.out.println(rootPath.replaceAll("\\","\\\\"));
			// rootPath=rootPath.replaceAll("\\","\\\\");

			// rootPath = "D:\\录波数据\\苏州夏季";

			// 1.1得到路径，抓取数据有功start
			HashMap map2 = (HashMap) getFilePath(opEegrpBO);
			String dirpath = (String) map2.get("filename");
			delta = dealDirpath(dirpath);
			System.out.println("delta是" + delta);
			String finalpath = dirpath + "P-" + (opEegrpBO.getcChannelid() - 1)
					+ ".txt";
			finalpath = rootPath + File.separator + finalpath;
			File dir = new File(finalpath);
			String dirName = rootPath + File.separator + "录波数据算法";
			String fileName = dirName + File.separator + "P-0" + ".txt";
			System.out.println(dir);
			if (!dir.exists()) {
				return null;
			} else {
				cf.createDir(dirName);
				cf.createFile(fileName);

			}
			;

			in = new BufferedInputStream(new FileInputStream(dir));
			// 如果你文件已utf-8编码的就按这个编码来读取，不然又中文会读取到乱码
			ir = new InputStreamReader(in, "utf-8");
			// 字符输入流中读取文本,这样可以一行一行读取
			br = new BufferedReader(ir);
			// 先判断是否有文件，创建文件，并写入，下一次进入则删除
			String line = "";
			// 2.读取文件并转换成json格式，目的：为了画图
			// 一行一行读取
			i = 0;
			int chazhi = (int) map2.get("chazhi");
			j = Integer.parseInt(jump) + chazhi * 864000 - delta;
			ArrayList plist = new ArrayList();
			ArrayList slist = new ArrayList();
			out = new FileOutputStream(fileName);
			outWriter = new OutputStreamWriter(out, "UTF-8");
			bufWrite = new BufferedWriter(outWriter);
			while ((line = br.readLine()) != null) {
				if (i <= (j + endPoint) && i > (j - startPoint)) {
					bufWrite.write(line + "\r\n");
					HashMap<String, Object> map = new HashMap<String, Object>();
					plist.add(line);
					slist.add(i + delta);
				}
				i++;
			}
			bufWrite.close();
			outWriter.close();
			out.close();
			// 1.1得到路径，抓取有功数据end

			// 1.2得到路径，抓取无功数据start
			i = 0;
			map2 = (HashMap) getFilePath(opEegrpBO);
			finalpath = (String) map2.get("filename");
			finalpath += "Q-" + (opEegrpBO.getcChannelid() - 1) + ".txt";
			finalpath = rootPath + File.separator + finalpath;
			dir = new File(finalpath);
			System.out.println(dir);
			if (!dir.exists()) {
				return null;
			} else {
				fileName = dirName + File.separator + "Q-0" + ".txt";
				cf.createFile(fileName);
			}
			;

			in = new BufferedInputStream(new FileInputStream(dir));
			// 如果你文件已utf-8编码的就按这个编码来读取，不然又中文会读取到乱码
			ir = new InputStreamReader(in, "utf-8");
			// 字符输入流中读取文本,这样可以一行一行读取
			br = new BufferedReader(ir);
			line = "";
			// 2.读取文件并转换成json格式，目的：为了画图
			// 一行一行读取
			chazhi = (int) map2.get("chazhi");
			j = Integer.parseInt(jump) + chazhi * 864000 - delta;
			ArrayList wugonglist = new ArrayList();
			out = new FileOutputStream(fileName);
			outWriter = new OutputStreamWriter(out, "UTF-8");
			bufWrite = new BufferedWriter(outWriter);
			while ((line = br.readLine()) != null) {
				if (i <= (j + endPoint) && i > (j - startPoint)) {
					bufWrite.write(line + "\r\n");
					HashMap<String, Object> map = new HashMap<String, Object>();
					wugonglist.add(line);
				}
				i++;
			}
			bufWrite.close();
			outWriter.close();
			out.close();
			// 1.2得到路径，抓取无功数据end

			// 1.3得到路径，抓取二次数据start
			i = 0;
			map2 = (HashMap) getFilePath(opEegrpBO);
			finalpath = (String) map2.get("filename");
			finalpath += "I_2-" + (opEegrpBO.getcChannelid() - 1) + ".txt";
			finalpath = rootPath + File.separator + finalpath;
			dir = new File(finalpath);
			System.out.println(dir);
			if (!dir.exists()) {
				return null;
			} else {
				fileName = dirName + File.separator + "I_2-0" + ".txt";
				cf.createFile(fileName);
			}
			;

			in = new BufferedInputStream(new FileInputStream(dir));
			// 如果你文件已utf-8编码的就按这个编码来读取，不然又中文会读取到乱码
			ir = new InputStreamReader(in, "utf-8");
			// 字符输入流中读取文本,这样可以一行一行读取
			br = new BufferedReader(ir);
			line = "";
			// 2.读取文件并转换成json格式，目的：为了画图
			// 一行一行读取
			chazhi = (int) map2.get("chazhi");
			j = Integer.parseInt(jump) + chazhi * 864000 - delta;
			ArrayList ercilist = new ArrayList();
			out = new FileOutputStream(fileName.replace("\\\\", "\\"));
			outWriter = new OutputStreamWriter(out, "UTF-8");
			bufWrite = new BufferedWriter(outWriter);
			while ((line = br.readLine()) != null) {
				if (i <= (j + endPoint) && i > (j - startPoint)) {
					bufWrite.write(line + "\r\n");
					HashMap<String, Object> map = new HashMap<String, Object>();
					ercilist.add(Double.parseDouble(line) * 500);
				}
				i++;
			}
			bufWrite.close();
			outWriter.close();
			out.close();
			// 1.3得到路径，抓取二次数据end

			// 1.4得到路径，抓取三次数据start
			i = 0;
			map2 = (HashMap) getFilePath(opEegrpBO);
			finalpath = (String) map2.get("filename");
			finalpath += "I_3-" + (opEegrpBO.getcChannelid() - 1) + ".txt";
			finalpath = rootPath + File.separator + finalpath;
			dir = new File(finalpath);
			System.out.println(dir);
			if (!dir.exists()) {
				return null;
			} else {

				fileName = dirName + File.separator + "I_3-0" + ".txt";
				cf.createFile(fileName);
			}
			;

			in = new BufferedInputStream(new FileInputStream(dir));
			// 如果你文件已utf-8编码的就按这个编码来读取，不然又中文会读取到乱码
			ir = new InputStreamReader(in, "utf-8");
			// 字符输入流中读取文本,这样可以一行一行读取
			br = new BufferedReader(ir);
			line = "";
			// 2.读取文件并转换成json格式，目的：为了画图
			// 一行一行读取
			chazhi = (int) map2.get("chazhi");
			j = Integer.parseInt(jump) + chazhi * 864000 - delta;
			ArrayList sancilist = new ArrayList();
			out = new FileOutputStream(fileName);
			outWriter = new OutputStreamWriter(out, "UTF-8");
			bufWrite = new BufferedWriter(outWriter);
			while ((line = br.readLine()) != null) {
				if (i <= (j + endPoint) && i > (j - startPoint)) {
					bufWrite.write(line + "\r\n");
					HashMap<String, Object> map = new HashMap<String, Object>();
					sancilist.add(Double.parseDouble(line) * 500);
				}
				i++;
			}
			bufWrite.close();
			outWriter.close();
			out.close();
			// 1.4得到路径，抓取三次数据end
			v52map.put("power", plist);
			v52map.put("wugong", wugonglist);
			v52map.put("erci", ercilist);
			v52map.put("sanci", sancilist);
			v52map.put("se", slist);
		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			// 一定要关闭流,倒序关闭
			try {

				if (br != null) {
					br.close();
				}
				if (ir != null) {
					ir.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {

			}

		}
		return v52map;
	}

	/**
	 * @param dirpath
	 *            特定的路径
	 * @return 指定的偏移量
	 */
	private int dealDirpath(String dirpath) {
		int a = Integer.parseInt(dirpath.substring(dirpath.length() - 9,
				dirpath.length() - 7)) * 3600;
		System.out.println(dirpath.substring(dirpath.length() - 9,
				dirpath.length() - 7));
		int b = Integer.parseInt(dirpath.substring(dirpath.length() - 6,
				dirpath.length() - 4)) * 60;
		System.out.println(dirpath.substring(dirpath.length() - 6,
				dirpath.length() - 4));
		int c = Integer.parseInt(dirpath.substring(dirpath.length() - 3,
				dirpath.length() - 1));
		System.out.println(dirpath.substring(dirpath.length() - 3,
				dirpath.length() - 1));
		return (a + b + c)*10;
	}

	/**
	 * 得到对应点所在文件的路径
	 * 
	 * @param opEegrpBO
	 * @return 得到对应点所在文件的路径
	 */
	private HashMap getFilePath(OpEegrpBO opEegrpBO) {
		int delta = 0;
		HashMap map = new HashMap<>();
		String cDistrictbcdid = String.format("%04d",
				Integer.parseInt(opEegrpBO.getcDistrictbcdid()));
		String cAddressid = String.format("%04d", opEegrpBO.getcAddressid());
		String str = opEegrpBO.getcRecorddatebcd().toString();
		String cRecorddatebcd = "";
		String filename = "";
		// start 得到前五天的数组
		ArrayList list = new ArrayList();
		List cRlist = new ArrayList();
		for (int j = 0; j < 10; j++) {
			filename = "";
			cRecorddatebcd = "";
			int i = 0;
			list = new ArrayList<>();
			for (i = 0; i < str.length() - 1; i += 2) {
				list.add(str.substring(i, i + 2));
			}
			list.add(str.substring(i));
			for (i = 0; i < list.size(); i++) {
				cRecorddatebcd += "-" + list.get(i);
			}
			;
			// 目的：为了使得为一的数字把月份也换了
			String start = "";
			start += cDistrictbcdid + cAddressid + cRecorddatebcd;
			filename = getFileSE(start);
			if (filename != "no") {
				filename = filename + File.separator;
				map.put("chazhi", j);
				break;
			}
			filename = filename + File.separator;
			if (str.substring(4) == "01") {
				str = str.replace(str.substring(4), "31");
				str = str.replace(str.substring(2),
						(Integer.parseInt(str.substring(2)) - 1) + "");
			} else {
				StringBuffer sb = new StringBuffer(str);
				str = sb.replace(
						4,
						6,
						String.format("%02d",
								Integer.parseInt(str.substring(4)) - 1))
						.toString();
			}
			;
		}
		// int delta =;
		map.put("filename", filename);
		// map.put("delta", delta);

		return map;
		// end 得到前五天的数组

	}

	public String getFileSE(String start) {
		File files = new File(rootPath); // 创建File对象,指向F盘根目录
		String[] names = files.list(); // 获取F盘根目录所有文件和路径,并以字符串数组返回
		String[] da = new String[] { "no" };
		for (String s : names) { // 遍历字符串数组
			boolean a = s.startsWith(start); // 文件名前缀带有ja的返回true,没有则返回false
			// boolean b = s.endsWith(end); // 文件名前缀带有ja的返回true,没有则返回false

			if (a) { // 此处条件根据需要进行修改
				da[0] = s;

			}

		}
		return da[0];
	}

	// public static boolean createFile(String fileName,String filecontent){
	// Boolean bool = false;
	// filenameTemp = path+fileName+".txt";//文件路径+名称+文件类型
	// File file = new File(filenameTemp);
	// try {
	// //如果文件不存在，则创建新的文件
	// if(!file.exists()){
	// file.createNewFile();
	// bool = true;
	// System.out.println("success create file,the file is "+filenameTemp);
	// //创建文件成功后，写入内容到文件里
	// writeFileContent(filenameTemp, filecontent);
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// return bool;
	// }
	public static boolean deleteFile(String fileName) {
		File file = new File(fileName);
		if (file.isFile() && file.exists()) {
			file.delete();
			System.out.println("删除单个文件" + fileName + "成功！");
			return true;
		} else {
			System.out.println("删除单个文件" + fileName + "失败！");
			return false;
		}
	}

	@Override
	public Integer findGridCountSQL(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectOpdatasForGridCountSQL(opEegrpBO);
		return count;
	}

	@Override
	public List<HashMap<String, Object>> findGridSQL(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectOpdatasForGridSQL(opEegrpBO);
		return olist;
	}

	@Override
	public Integer findGridCountV22SQL(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectGridCountV22SQL(opEegrpBO);
		return count;
	}

	@Override
	public List<HashMap<String, Object>> findGridV22SQL(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectGridV22SQL(opEegrpBO);
		return olist;
	}

	@Override
	public Integer findYuanshiCountV31SQL(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectGridCountV31SQL(opEegrpBO);
		return count;
	}

	@Override
	public List<HashMap<String, Object>> findYuanshiV31SQL(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectGridV31SQL(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> findQitingTable(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.selectQitingTable(opEegrpBO);
		for (int i = 0; i < olist.size(); i++) {
			Integer hour = 0;
			Integer minute = 0;

			Integer starttimeIn = Integer.parseInt(olist.get(i)
					.get("starttime") + "");
			if (starttimeIn == 255) {
			}
			hour = (int) Math.floor(starttimeIn / 60);
			minute = starttimeIn % 60;
			String starttime = String.format("%02d", hour) + ":"
					+ String.format("%02d", minute);
			olist.get(i).put("starttime", starttime);

			Integer endtimeIn = Integer.parseInt(olist.get(i).get("endtime")
					+ "");
			hour = (int) Math.floor(endtimeIn / 60);
			minute = endtimeIn % 60;
			String endtime = String.format("%02d", hour) + ":"
					+ String.format("%02d", minute);
			olist.get(i).put("endtime", endtime);
		}
		return olist;
	}

	@Override
	public Integer findQitingTableCount(OpEegrpBO opEegrpBO) {
		Integer count = opdataMapper.selectQitingTableCount(opEegrpBO);
		return count;
	}

	@Override
	public List<LinkedHashMap<String, Object>> findSuanfaV61(OpEegrpBO opEegrpBO) {
		List<LinkedHashMap<String, Object>> olist = opjumpdataMapper
				.selectBySql(opEegrpBO);
		return olist;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.zz.edata.service.EdataService#listEE()
	 */
//	@Override
//	public List listEE() {
//		// 1.获取电器大类的list以及电器小类的list
//		List<Eeclassificationgrp> listEEGrp = findAllGroup();// 所有大类
//		List<Eeclassification> listAllEE = findAllEE();// 所有小类
//		List listTest=new ArrayList<>();
//		listTest.add("1");
//		listTest.add("2");
//		List listEE = new ArrayList<>();// 返回的用于显示的表
//		for (int i = 0; i < listEEGrp.size(); i++) {
//
//			List listDQ = new ArrayList<>();// 装小类的表
//			List listDQid = new ArrayList<>();// 装id的表
//
//			for (int k = 0; k < listAllEE.size(); k++) {
//				Boolean isChild = listAllEE.get(k).getcEegrpid() == listEEGrp
//						.get(i).getcEegrpid();
//				if (isChild) {
//					listDQ.add(listAllEE.get(k).getcEeclassificationname());
//					listDQid.add(listAllEE.get(k).getcEehexid());
//				}
//				;
//
//			}
//			// 2.生成一个电器类的list
//			ArrayList shiList = new ArrayList() {
//			};
//			for (int j = 0; j < listDQ.size(); j++) {
//				Map map = new HashMap();
//				map.put("n", listDQ.get(j));
//				map.put("v", listDQid.get(j));
//				
//				shiList.add(map);
//			}
//			// 3.添加到省中
//			Eeclassificationgrp EEgrp = (Eeclassificationgrp) listEEGrp.get(i);
//			LinkSelectBO linkSelectBO = new LinkSelectBO(EEgrp.getcEegrpname(),
//					EEgrp.getcEegrpid(), shiList);// 装大类的表
//			listEE.add(linkSelectBO);
//		}
//		return listEE;
//	}
	@Override
	public List listEE() {
		// 1.获取电器大类的list以及电器小类的list
		List<Eeclassificationgrp> listEEGrp = findAllGroup();// 所有大类
		List<Eeclassification> listAllEE = findAllEE();// 所有小类
		List listTest=new ArrayList<>();
		listTest.add("1");
		listTest.add("2");
		List listEE = new ArrayList<>();// 返回的用于显示的表
		for (int i = 0; i < listEEGrp.size(); i++) {//对每个省做循环遍历

			List listDQ = new ArrayList<>();// 装小类的表
			List listDQid = new ArrayList<>();// 装id的表

			for (int k = 0; k < listAllEE.size(); k++) {
				Boolean isChild = listAllEE.get(k).getcEegrpid() == listEEGrp
						.get(i).getcEegrpid();
				if (isChild) {
					listDQ.add(listAllEE.get(k).getcEeclassificationname());
					listDQid.add(listAllEE.get(k).getcEehexid());
				}
				;

			}
			// 2.生成一个电器类的list
			ArrayList shiList = new ArrayList() {
			};
			for (int j = 0; j < listDQ.size(); j++) {
				Map map = new HashMap();
				map.put("n", listDQ.get(j));
				map.put("v", listDQid.get(j));
				
				shiList.add(map);
			}
			// 3.添加到省中
			Eeclassificationgrp EEgrp = (Eeclassificationgrp) listEEGrp.get(i);
			LinkSelectBO linkSelectBO = new LinkSelectBO(EEgrp.getcEegrpname(),
					EEgrp.getcEegrpid(), shiList);// 定义每一个省的数据
			listEE.add(linkSelectBO);//在省中添加每一个市
		}
		return listEE;
	}
	@Override
	public List<BaseLinkSelectBO> listLSDevice() {
//		
//		//【1】找到联动的数据结果的list
//		List<Deviceinfo> listDevcieInfo =listDevcieInfo();
//		List<BaseLinkSelectBO> listLS= new ArrayList<BaseLinkSelectBO>();
//		for (int i = 0; i < listDevcieInfo.size(); i++) {
//			String districtId="";
//			if(listDevcieInfo.get(i).getcDistrictbcdid()==districtId){//如果存在就放进去。不存在就 new 一个baseselectBO
//				BaseLinkSelectBO baseLinkSelectBO = new BaseLinkSelectBO(listDevcieInfo.get(i).getcDistrictbcdid(),listDevcieInfo.get(i).getcDistrictbcdid(),new ArrayList<BaseLinkSelectBO>());
//				listLS.add(baseLinkSelectBO);
//			}else {
//				districtId=listDevcieInfo.get(i).getcDistrictbcdid();
//				BaseLinkSelectBO baseLinkSelectBO = new BaseLinkSelectBO(listDevcieInfo.get(i).getcDistrictbcdid(),listDevcieInfo.get(i).getcDistrictbcdid(),new ArrayList<BaseLinkSelectBO>());
//				listLS.add(baseLinkSelectBO);
//			}
//		}
//		//【2】拼接数据到linkselectBO中
//		 for (Deviceinfo country : listDevcieInfo) {
//	            if(country.getId()==id){
//	                //获取省
//	                for(TbTree province : trees){
//	                    if(province.getpId()==country.getId()){
//	                        //获取市for
//	                        for (TbTree city : trees) {
//	                            if(city.getpId()==province.getId()){
//	                                //获取区
//	                                for (TbTree district : trees) {
//	                                    if(district.getpId()==city.getId()){
//	                                        city.getNodes().add(district);
//	                                    }
//	                                }
//	                                province.getNodes().add(city);
//	                                
//	                            }
//	                        }
//	                        country.getNodes().add(province);
//	                        
//	                    }
//	                }
//	                return country;
//	            }
//	        }
//		//【2.1】拼接n,v,s
//		// 1.获取电器大类的list以及电器小类的list
//		
//		List<Eeclassification> listAllEE = findAllEE();// 所有小类
//		List listTest=new ArrayList<>();
//		
//		listTest.add("1");
//		listTest.add("2");
//		List listEE = new ArrayList<>();// 返回的用于显示的表
//		for (int i = 0; i < listEEGrp.size(); i++) {//对每个省做循环遍历
//			List listDQ = new ArrayList<>();// 装小类的表
//			List listDQid = new ArrayList<>();// 装id的表
//
//			for (int k = 0; k < listAllEE.size(); k++) {
//				Boolean isChild = listAllEE.get(k).getcEegrpid() == listEEGrp
//						.get(i).getcEegrpid();
//				if (isChild) {
//					listDQ.add(listAllEE.get(k).getcEeclassificationname());
//					listDQid.add(listAllEE.get(k).getcEehexid());
//				}
//				;
//
//			}
//			// 2.生成一个电器类的list
//			ArrayList shiList = new ArrayList() {
//			};
//			for (int j = 0; j < listDQ.size(); j++) {
//				Map map = new HashMap();
//				map.put("n", listDQ.get(j));
//				map.put("v", listDQid.get(j));
//				
//				shiList.add(map);
//			}
//			// 3.添加到省中
//			Eeclassificationgrp EEgrp = (Eeclassificationgrp) listEEGrp.get(i);
//			LinkSelectBO linkSelectBO = new LinkSelectBO(EEgrp.getcEegrpname(),
//					EEgrp.getcEegrpid(), shiList);// 定义每一个省的数据
//			listEE.add(linkSelectBO);//在省中添加每一个市
//		}
//		return listEE;
		return new  ArrayList<BaseLinkSelectBO>();
	}

	
	// // [{
	// // "n":"湖北省",
	// "v":1,
	// // "s":[{"n":"荆州市","v":"1"},{"n":"武汉市","v":"1"}]
	// // },{"n":"湖南省",
	// // "s":[{"n":"岳阳市"},{"n":"湘潭市"}]
	// // }]

	// @Override
	// public Map<String, Object> generateSqlOp(SqltoolBO sqltoolBO) {
	// SqlConcat.sqlImportOp(sqltoolBO);
	// Map<String, Object> msgmap = new HashMap<String, Object>();
	// File sqlFile = new File(sqltoolBO.getWritePath());
	// String parentPath = sqlFile.getParent();
	// msgmap.put("isSuccess", true);
	// // 计算文件大小
	// File countFile = new File(parentPath);
	// double timeEst = estTime(countFile);
	// double filesize = FileUtils.getDirSize(countFile);
	// msgmap.put("timeEst", timeEst);
	// msgmap.put("filesize", filesize);
	// return msgmap;
	// }

	private List<Deviceinfo> listDevcieInfo() {
		return deviceinfoMapper.listDevcieInfo();
	}

	@Override
	public Map<String, Object> importTo(SqltoolBO sqltoolBO) {
		return SqlConcat.Import(sqltoolBO);
	}

	// public static Map<String, Object> importT(String dbname, String
	// writePath) {
	// // [1]生成bat
	// Map<String, Object> msgmap = new HashMap<String, Object>();
	// File sqlFile = new File(writePath);
	// String parentPath = sqlFile.getParent();
	// String batPath = "";
	// for (int i = 0; i < 3; i++) {
	// batPath = sqlFile.getParent() + "\\sub"+(i+1)+".bat";
	// File batFile = new File(batPath);
	// batFile.delete();
	// try {
	// batFile.createNewFile();
	// BufferedWriter out = new BufferedWriter(new FileWriter(batFile,
	// true));
	// StringBuilder bat = new StringBuilder();
	// // @echo off
	// // set /p dbname=输入数据库名：
	// // echo 开始导入...
	// // mysql -uroot -p123456 %dbname%< D:\000test\t_opdata.sql
	// // echo 导入完毕,按任意键结束
	// // pause
	// bat.append("@echo off\r\n");
	// bat.append("set num=0 \r\n");
	// bat.append("setlocal enabledelayedexpansion \r\n");
	// bat.append("for %%i in (" + parentPath + File.separator
	// + "t_opdata*.sql" + ") do (\r\n ");
	// bat.append("set /a num+=1 \r\n");
	// bat.append(" echo !num! \r\n");
	// bat.append("  set /a pos=num%%3 \r\n");
	// bat.append("  if !pos! ==  "+i+"  echo excute %%i \r\n");
	// bat.append("if !pos! == "+i+" mysql -uroot -p123456 " + dbname +
	// "< %%i\r\n");
	// bat.append(") \r\n");
	// bat.append("echo success \r\n");
	// // out.write(sqladd().toString()); // \r\n即为换行
	// out.write(bat.toString());
	// out.flush(); // 把缓存区内容压入文件
	// out.close(); // 最后记得关闭文件
	// } catch (Exception e) {
	// msgmap.put("isSuccess", false);
	// return msgmap;
	// }
	// }
	// // [2]执行bat
	// Long startTime = System.currentTimeMillis();
	// String batPath1=sqlFile.getParent() + "\\sub"+1+".bat";
	// String batPath2=sqlFile.getParent() + "\\sub"+2+".bat";
	// String batPath3=sqlFile.getParent() + "\\sub"+3+".bat";
	// new Cmd(batPath1);
	// new Cmd(batPath2);
	// new Cmd(batPath3);
	// // Long endtime = System.currentTimeMillis();
	// // Boolean isOk = (endtime - startTime) > 5000;
	// // System.out.println(endtime - startTime);
	// // if (!isOk) {
	// // msgmap.put("isSuccess", false);
	// // return msgmap;
	// // }以前为了判断导入错误的代码
	// msgmap.put("isSuccess", true);
	// // 计算文件大小
	// File countFile = new File(parentPath);
	// double timeEst = estTime(countFile);
	// msgmap.put("timeEst", timeEst);
	// return msgmap;
	// }

	@Override
	public Map<String, Object> importToJ(String dbname, String writePath) {
		// [1]生成bat
		Map<String, Object> msgmap = new HashMap<String, Object>();
		File sqlFile = new File(writePath);
		String parentPath = sqlFile.getParent();
		String batPath = sqlFile.getParent() + "\\opjumpdataSql.bat";
		File batFile = new File(batPath);
		batFile.delete();
		try {
			batFile.createNewFile();
			BufferedWriter out = new BufferedWriter(new FileWriter(batFile,
					true));
			StringBuilder bat = new StringBuilder();
			// @echo off
			// set /p dbname=输入数据库名：
			// echo 开始导入...
			// mysql -uroot -p123456 %dbname%< D:\000test\t_opdata.sql
			// echo 导入完毕,按任意键结束
			// pause
			bat.append("@echo off\r\n");
			bat.append("for %%i in (" + parentPath + File.separator
					+ "t_opjumpdata*.sql" + ") do (\r\n ");
			bat.append("echo excute %%i \r\n");
			bat.append("mysql -uroot -p123456 " + dbname + "< %%i\r\n");
			bat.append(") \r\n");
			bat.append("echo success \r\n");
			// out.write(sqladd().toString()); // \r\n即为换行
			out.write(bat.toString());
			out.flush(); // 把缓存区内容压入文件
			out.close(); // 最后记得关闭文件
		} catch (Exception e) {
			msgmap.put("isSuccess", false);
			return msgmap;
		}

		// [2]执行bat
		Long startTime = System.currentTimeMillis();
		new Cmd(batPath);
		// Long endtime = System.currentTimeMillis();
		// Boolean isOk = (endtime - startTime) > 5000;
		// System.out.println(endtime - startTime);
		// if (!isOk) {
		// msgmap.put("isSuccess", false);
		// return msgmap;
		// }以前为了判断导入错误的代码
		msgmap.put("isSuccess", true);
		// 计算文件大小
		File countFile = new File(parentPath);
		double timeEst = estTime(countFile);
		msgmap.put("timeEst", timeEst);
		return msgmap;
	}

	private static double estTime(File countFile) {
		double param = 10000;// 每M的数据量
		double speed = 5000;// 每秒插入数据量
		System.out.println("文件大小" + FileUtils.getDirSize(countFile));// 返回的是MB；
		double timeEst = FileUtils.getDirSize(countFile) * param / speed;
		return timeEst;
	}

	@Override
	public Map<String, Object> generateSqlOpj(SqltoolJBO sqltoolJBO) {
		SqlConcat.sqlImportOpj(sqltoolJBO);
		Map<String, Object> msgmap = new HashMap<String, Object>();
		File sqlFile = new File(sqltoolJBO.getWritePathJ());
		String parentPath = sqlFile.getParent();
		msgmap.put("isSuccess", true);
		// 计算文件大小
		File countFile = new File(parentPath);
		double timeEst = estTime(countFile);
		double filesize = FileUtils.getDirSize(countFile);
		msgmap.put("timeEst", timeEst);
		msgmap.put("filesize", filesize);
		return msgmap;
	}

	@Override
	public List<LinkedHashMap<String, Object>> listSuanfaResult(
			OpEegrpBO opEegrpBO) {
		List<LinkedHashMap<String, Object>> olist = opjumpdataMapper
				.selectBySql(opEegrpBO);
		return olist;
	}

	@Override
	public List<HashMap<String, Object>> listChannelEE() {
		return opdataMapper.listChannelEE();
	}

	@Override
	public List<LinkedHashMap<String, Object>> listSubcompareResult(
			SubcompareBO subcompareBO) {
		List<LinkedHashMap<String, Object>> olist = opjumpdataMapper
				.listSubcompareResult(subcompareBO);
		return olist;
	}

	@Override
	public Map<String, Object> generateSqlOp(SqltoolBO sqltoolBO) {
		// TODO Auto-generated method stub
		return null;
	}


//	private static List listPathShow(File ep) {
//		 List<String> listTwoGrade = new ArrayList<String>();
//		 File[] listFiles = ep.listFiles();
//		 for (int i = 0; i < listFiles.length; i++) {
//			listTwoGrade.add(listFiles.li)
//		}
//		return null;
//	}



	public static void main(String[] args) throws Exception {
//		FilePathShow.find("E:", 2);
//		List<String> dirRoot = FilePathShow.getDirRoot();
//		System.out.println(dirRoot);
		File d =new File("d:");
		String[] list = d.list();
		for (int i = 0; i < list.length; i++) {
			System.out.println(list[i]);
		}
		
	}

	@Override
	public List<String> listFilePath() {
		 
			// 【1】得到是否有J盘
			File j = new File("J:");
			File ep = new File("E:");
			File f= new File("F:");
			List<String> fileList = new ArrayList<String>();
			if (j.exists()) {
				try {
					FilePathShow.find("J:", 2);
				 fileList = FilePathShow.getDirRoot();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} 
			else if (f.exists()) {
				try {
					FilePathShow.find("f:", 2);
					fileList= FilePathShow.getDirRoot();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else if (ep.exists()) {
				try {
					FilePathShow.find("E:", 2);
					fileList= FilePathShow.getDirRoot();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			// 【2】有则开始挖掘两层
			return fileList;
	}

	@Override
	public List<HashMap<String, Object>> listRecorddate(OpEegrpBO opEegrpBO) {
		List<HashMap<String, Object>> olist = opdataMapper
				.listRecorddate(opEegrpBO);
		return olist;
	}

}

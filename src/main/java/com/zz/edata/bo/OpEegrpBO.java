package com.zz.edata.bo;

import java.io.Serializable;
/**
 * 用于用户曲线查询列表 BO
 * @author jqs
 *
 */
public class OpEegrpBO implements Serializable {
	private static final long serialVersionUID = 1L;
	//OP的district
	private String cDistrictbcdid;
	//OP的address
	private Integer cAddressid;
	//OP的记录时间
    private String cRecordinserttime;
    //OP的通道信号
    private Integer cChannelid;
	//Eegrp的电器种类编号
	private Integer cEegrpid;
	//查询的种类
	//目的：解决查询条件中的以下条件
    private Integer cParaid;
    private String cEehexid;
    private String cRecorddatebcd;
    //起始点设定
    //目的：传递需要画点的参数
    private Integer startPoint;
   
	private Integer endPoint;
    
    /**
     * 版本号
     */
    private String C_OffLineVersion;
    
    /**
     * 功率小值
     */
    private Integer minPower;
    
    /**
     * 功率大值
     */
    private Integer maxPower;
    
    /**
     * 时段小值
     */
    private Integer minTime;
    
    public Integer getMinTime() {
		return minTime;
	}

	public void setMinTime(Integer minTime) {
		this.minTime = minTime;
	}

	public Integer getMaxTime() {
		return maxTime;
	}

	public void setMaxTime(Integer maxTime) {
		this.maxTime = maxTime;
	}
	/**
     * 时段大值
     */
    private Integer maxTime;
    public Integer getMinPower() {
		return minPower;
	}

	public void setMinPower(Integer minPower) {
		this.minPower = minPower;
	}

	public Integer getMaxPower() {
		return maxPower;
	}

	public void setMaxPower(Integer maxPower) {
		this.maxPower = maxPower;
	}
	private Integer version1;
    private Integer version2;
    
  //分页，为了layui的page和limit
	private Integer limit;
  	private Integer startindex;
  	public String getPathSave() {
		return pathSave;
	}

	public void setPathSave(String pathSave) {
		this.pathSave = pathSave;
	}
	private Integer page;
  //直接查询sql语句
  	private String sql;
  //设置文件路径
  	private String rootPath;
  	private String pathSave;

    public String getSql() {
		return sql;
	}
	
	public void setSql(String sql) {
		this.sql = sql;
	}
	public String getRootPath() {
		return rootPath;
	}

	public void setRootPath(String rootPath) {
		this.rootPath = rootPath;
	}

	public Integer getVersion11() {
		return version11;
	}
	public void setVersion11(Integer version11) {
		this.version11 = version11;
	}
	public Integer getVersion21() {
		return version21;
	}
	public void setVersion21(Integer version21) {
		this.version21 = version21;
	}
	private Integer version11;
    private Integer version21;
    public Integer getVersion1() {
		return version1;
	}
	public void setVersion1(Integer version1) {
		this.version1 = version1;
	}
	public Integer getVersion2() {
		return version2;
	}
	public void setVersion2(Integer version2) {
		this.version2 = version2;
	}
	
	public Integer getStartPoint() {
		return startPoint;
	}
	public void setStartPoint(Integer startPoint) {
		this.startPoint = startPoint;
	}
	public Integer getEndPoint() {
		return endPoint;
	}
	public void setEndPoint(Integer endPoint) {
		this.endPoint = endPoint;
	}
	public String getcRecorddatebcd() {
		return cRecorddatebcd;
	}
	public void setcRecorddatebcd(String cRecorddatebcd) {
		this.cRecorddatebcd = cRecorddatebcd;
	}
	public Integer getcParaid() {
		return cParaid;
	}
	public void setcParaid(Integer cParaid) {
		this.cParaid = cParaid;
	}
	public String getcEehexid() {
		return cEehexid;
	}
	public void setcEehexid(String cEehexid) {
		this.cEehexid = cEehexid;
	}
	
	

	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getStartindex() {
		return startindex;
	}
	public void setStartindex(Integer startindex) {
		this.startindex = startindex;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public String getcDistrictbcdid() {
		return cDistrictbcdid;
	}
	public void setcDistrictbcdid(String cDistrictbcdid) {
		this.cDistrictbcdid = cDistrictbcdid;
	}
	public Integer getcAddressid() {
		return cAddressid;
	}
	public void setcAddressid(Integer cAddressid) {
		this.cAddressid = cAddressid;
	}
	public String getcRecordinserttime() {
		return cRecordinserttime;
	}
	public void setcRecordinserttime(String cRecordinserttime) {
		this.cRecordinserttime = cRecordinserttime;
	}
	public Integer getcChannelid() {
		return cChannelid;
	}
	public void setcChannelid(Integer cChannelid) {
		this.cChannelid = cChannelid;
	}
	public Integer getcEegrpid() {
		return cEegrpid;
	}
	public void setcEegrpid(Integer cEegrpid) {
		this.cEegrpid = cEegrpid;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getC_OffLineVersion() {
		return C_OffLineVersion;
	}

	public void setC_OffLineVersion(String c_OffLineVersion) {
		C_OffLineVersion = c_OffLineVersion;
	}
	
	
	
}


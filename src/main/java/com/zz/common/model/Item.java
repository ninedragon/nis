package com.zz.common.model;

import java.io.Serializable;

public class Item implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
    private String pId;
    private String pName;
    public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	private String name;
    private String cityName;
    private String epuProvince;
    private String epuDistrict;
    public String getEpuProvince() {
		return epuProvince;
	}
	public void setEpuProvince(String epuProvince) {
		this.epuProvince = epuProvince;
	}
	public String getEpuDistrict() {
		return epuDistrict;
	}
	public void setEpuDistrict(String epuDistrict) {
		this.epuDistrict = epuDistrict;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getCityCode() {
		return cityCode;
	}
	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	private String cityCode;
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getIsParent() {
		return isParent;
	}
	public void setIsParent(String isParent) {
		this.isParent = isParent;
	}
	private int type;
    private String isParent;
}
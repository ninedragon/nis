package com.zz.common.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class TSyCityInfoBean implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 7607621452350518121L;

	private String cityCode;

    private String cityNameCn;

    private String provinceId;

    private String cityTier;

    private String provincelevelFlag;

    private String districtFlag;

    private String superiorCity;

    private BigDecimal cityAvgHousingPrice;

    private String cityMap;

    private String cityinfoCode;

    private String cityNameEn;

    private String cityNameShort;
    private String countyReport;
    private String cityReport;

    public String getCountyReport() {
		return countyReport;
	}

	public void setCountyReport(String countyReport) {
		this.countyReport = countyReport;
	}

	public String getCityReport() {
		return cityReport;
	}

	public void setCityReport(String cityReport) {
		this.cityReport = cityReport;
	}

	public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode == null ? null : cityCode.trim();
    }

    public String getCityNameCn() {
        return cityNameCn;
    }

    public void setCityNameCn(String cityNameCn) {
        this.cityNameCn = cityNameCn == null ? null : cityNameCn.trim();
    }

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

    public String getCityTier() {
        return cityTier;
    }

    public void setCityTier(String cityTier) {
        this.cityTier = cityTier == null ? null : cityTier.trim();
    }

    public String getProvincelevelFlag() {
        return provincelevelFlag;
    }

    public void setProvincelevelFlag(String provincelevelFlag) {
        this.provincelevelFlag = provincelevelFlag == null ? null : provincelevelFlag.trim();
    }

    public String getDistrictFlag() {
        return districtFlag;
    }

    public void setDistrictFlag(String districtFlag) {
        this.districtFlag = districtFlag == null ? null : districtFlag.trim();
    }

    public String getSuperiorCity() {
        return superiorCity;
    }

    public void setSuperiorCity(String superiorCity) {
        this.superiorCity = superiorCity == null ? null : superiorCity.trim();
    }

    public BigDecimal getCityAvgHousingPrice() {
        return cityAvgHousingPrice;
    }

    public void setCityAvgHousingPrice(BigDecimal cityAvgHousingPrice) {
        this.cityAvgHousingPrice = cityAvgHousingPrice;
    }

    public String getCityMap() {
        return cityMap;
    }

    public void setCityMap(String cityMap) {
        this.cityMap = cityMap == null ? null : cityMap.trim();
    }

    public String getCityinfoCode() {
        return cityinfoCode;
    }

    public void setCityinfoCode(String cityinfoCode) {
        this.cityinfoCode = cityinfoCode == null ? null : cityinfoCode.trim();
    }

    public String getCityNameEn() {
        return cityNameEn;
    }

    public void setCityNameEn(String cityNameEn) {
        this.cityNameEn = cityNameEn == null ? null : cityNameEn.trim();
    }

    public String getCityNameShort() {
        return cityNameShort;
    }

    public void setCityNameShort(String cityNameShort) {
        this.cityNameShort = cityNameShort == null ? null : cityNameShort.trim();
    }
}
package com.zz.common.model;

import java.io.Serializable;

public class TSyprovincesInfoBean implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = -4477001464022776277L;

	private String provinceId;

    private String provinceNameCn;

    private String regionId;

    private String provincecode;

    private String joinprovinceFlag;

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

    public String getProvinceNameCn() {
        return provinceNameCn;
    }

    public void setProvinceNameCn(String provinceNameCn) {
        this.provinceNameCn = provinceNameCn == null ? null : provinceNameCn.trim();
    }

    public String getRegionId() {
        return regionId;
    }

    public void setRegionId(String regionId) {
        this.regionId = regionId == null ? null : regionId.trim();
    }

    public String getProvincecode() {
        return provincecode;
    }

    public void setProvincecode(String provincecode) {
        this.provincecode = provincecode == null ? null : provincecode.trim();
    }

    public String getJoinprovinceFlag() {
        return joinprovinceFlag;
    }

    public void setJoinprovinceFlag(String joinprovinceFlag) {
        this.joinprovinceFlag = joinprovinceFlag == null ? null : joinprovinceFlag.trim();
    }
}
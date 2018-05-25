package com.zz.common.model;

import java.io.Serializable;


public class TSyCodeDefimeBean implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -3738498805180517861L;

	private String code;

    private String codeName;

    private String codeType;

    private String codeTypeCn;
    private String orderNum;
    private String remark;
    private String parentCode;
    private String parentCodeName;

    public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getParentCodeName() {
		return parentCodeName;
	}

	public void setParentCodeName(String parentCodeName) {
		this.parentCodeName = parentCodeName;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
        
    }

    public String getCodeName() {
        return codeName;
    }

    public void setCodeName(String codeName) {
        this.codeName = codeName == null ? null : codeName.trim();
    }

    public String getCodeType() {
        return codeType;
    }

    public void setCodeType(String codeType) {
        this.codeType = codeType == null ? null : codeType.trim();
    }

    public String getCodeTypeCn() {
        return codeTypeCn;
    }

    public void setCodeTypeCn(String codeTypeCn) {
        this.codeTypeCn = codeTypeCn == null ? null : codeTypeCn.trim();
    }
}
package com.zz.edata.bo;

public class SqltoolJBO {
	 private String rootPathJ;
	 private String regJ;
	 private Integer depthJ;
	 private String writePathJ;
	 //rootPathJ:rootPathJ,regJ:regJ,depthJ:depthJ,writePathJ:writePathJ
	public String getRootPathJ() {
		return rootPathJ;
	}
	public void setRootPathJ(String rootPathJ) {
		this.rootPathJ = rootPathJ;
	}
	public SqltoolJBO(String rootPathJ, String regJ, Integer depthJ,
			String writePathJ) {
		super();
		this.rootPathJ = rootPathJ;
		this.regJ = regJ;
		this.depthJ = depthJ;
		this.writePathJ = writePathJ;
	}
	public String getRegJ() {
		return regJ;
	}
	public void setRegJ(String regJ) {
		this.regJ = regJ;
	}
	public Integer getDepthJ() {
		return depthJ;
	}
	public void setDepthJ(Integer depthJ) {
		this.depthJ = depthJ;
	}
	public String getWritePathJ() {
		return writePathJ;
	}
	public void setWritePathJ(String writePathJ) {
		this.writePathJ = writePathJ;
	}
	public SqltoolJBO() {
		super();
		// TODO Auto-generated constructor stub
	}
}

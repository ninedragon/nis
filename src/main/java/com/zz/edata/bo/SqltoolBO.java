package com.zz.edata.bo;

public class SqltoolBO {
 private String rootPath;
 private String reg;
 private Integer depth;
 private String writePath;
 private String prefix;
 private String url;
 private String txtPrefix;

public String getTxtPrefix() {
	return txtPrefix;
}
public void setTxtPrefix(String txtPrefix) {
	this.txtPrefix = txtPrefix;
}
public String getRootPath() {
	return rootPath;
}
public void setRootPath(String rootPath) {
	this.rootPath = rootPath;
}
public String getReg() {
	return reg;
}
public void setReg(String reg) {
	this.reg = reg;
}
public Integer getDepth() {
	return depth;
}
public void setDepth(Integer depth) {
	this.depth = depth;
}
public String getWritePath() {
	return writePath;
}
public void setWritePath(String writePath) {
	this.writePath = writePath;
}
public String getPrefix() {
	return prefix;
}
public void setPrefix(String prefix) {
	this.prefix = prefix;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}
public SqltoolBO(String rootPath, String reg, Integer depth, String writePath,
		String prefix, String url, String txtPrefix) {
	super();
	this.rootPath = rootPath;
	this.reg = reg;
	this.depth = depth;
	this.writePath = writePath;
	this.prefix = prefix;
	this.url = url;
	this.txtPrefix = txtPrefix;
}
public SqltoolBO() {
	super();
	// TODO Auto-generated constructor stub
}
}

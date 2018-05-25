package com.zz.edata.bo;

import java.util.List;

/**
 * @author 90807
 *基本的用于联动的BO
 */
public class BaseLinkSelectBO {
	/**
	 * 显示的name
	 */
	private String n;
	
	/**
	 * 子代的sub
	 */
	private List<BaseLinkSelectBO> s;
	/**
	 * 显示的value
	 */
	private String v;
	public String getN() {
		return n;
	}

	public void setN(String n) {
		this.n = n;
	}

	public List<BaseLinkSelectBO> getS() {
		return s;
	}

	public void setS(List<BaseLinkSelectBO> s) {
		this.s = s;
	}

	public String getV() {
		return v;
	}

	public void setV(String v) {
		this.v = v;
	}

	public BaseLinkSelectBO(String n, String v, List<BaseLinkSelectBO> s) {
		super();
		this.n = n;
		this.s = s;
		this.v = v;
	}

	public BaseLinkSelectBO() {
		super();
	}

}

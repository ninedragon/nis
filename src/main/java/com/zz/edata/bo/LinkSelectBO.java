package com.zz.edata.bo;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 90807
 * 
 */
public class LinkSelectBO {
	/**
	 * option显示的名字name
	 */
	private Object n;
	/**
	 * option的value值
	 */
	private Object v;
	public Object getN() {
		return n;
	}
	public void setN(Object n) {
		this.n = n;
	}
	public Object getV() {
		return v;
	}
	public void setV(Object v) {
		this.v = v;
	}
	public ArrayList<Object> getS() {
		return s;
	}
	public LinkSelectBO(Object n, Object v, ArrayList<Object> s) {
		super();
		this.n = n;
		this.v = v;
		this.s = s;
	}
	public void setS(ArrayList<Object> s) {
		this.s = s;
	}
	/**
	 * 它的下级目录sub
	 */
	private ArrayList<Object> s;

}

package com.zz.core.shiro.session;

import java.io.Serializable;

/**
 * 
 * 
 * 版权所有：© www.zz.com<p>
 * 博客地址：http://www.zz.com/blog/  <p>
 * <p>
 * 
 * Session 状态 VO
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　季清思　2016年6月2日 　<br/>
 *
 * @author zhou-baicheng
 * @email  so@zz.com
 * @version 1.0,2016年6月2日 <br/>
 * 
 */
public class SessionStatus implements Serializable {
	private static final long serialVersionUID = 1L;

	//是否踢出 true:有效，false：踢出。
	private Boolean onlineStatus = Boolean.TRUE;

	
	public Boolean isOnlineStatus(){
		return onlineStatus;
	}

	public Boolean getOnlineStatus() {
		return onlineStatus;
	}
	public void setOnlineStatus(Boolean onlineStatus) {
		this.onlineStatus = onlineStatus;
	}
	
	
}

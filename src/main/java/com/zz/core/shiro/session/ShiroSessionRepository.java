package com.zz.core.shiro.session;

import org.apache.shiro.session.Session;

import java.io.Serializable;
import java.util.Collection;

/**
 * 
 * 
 * 版权所有：© www.zz.com<p>
 * 博客地址：http://www.zz.com/blog/  <p>
 * <p>
 * 
 * Session操作
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　季清思　2017年12月29日 　<br/>季清思
 *
 * @author jqs
 * @email  so@zz.com
 * @version 1.0,2017年12月29日 <br/>
 * 
 */
public interface ShiroSessionRepository {

	/**
	 * 存储Session
	 * @param session
	 */
    void saveSession(Session session);
    /**
     * 删除session
     * @param sessionId
     */
    void deleteSession(Serializable sessionId);
    /**
     * 获取session
     * @param sessionId
     * @return
     */
    Session getSession(Serializable sessionId);
    /**
     * 获取所有sessoin
     * @return
     */
    Collection<Session> getAllSessions();
}

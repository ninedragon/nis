package com.zz.core.shiro.cache;

import org.apache.shiro.cache.Cache;

/**
 * 
 * 
 * 版权所有：© www.zz.com<p>
 * <p>
 * 
 * shiro cache manager 接口
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建人 季清思　2017年12月29日 　<br/>
 *
 * @author jqs
 * @version 1.0,2017年12月29日 <br/>
 * 
 */
public interface ShiroCacheManager {

    <K, V> Cache<K, V> getCache(String name);

    void destroy();

}

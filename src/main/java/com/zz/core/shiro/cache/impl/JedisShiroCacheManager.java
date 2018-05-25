package com.zz.core.shiro.cache.impl;

import org.apache.shiro.cache.Cache;

import com.zz.core.shiro.cache.JedisManager;
import com.zz.core.shiro.cache.JedisShiroCache;
import com.zz.core.shiro.cache.ShiroCacheManager;

/**
 * 
 * 
 * 版权所有：© www.zz.com<p>
 * 博客地址：http://www.zz.com/blog/  <p>
 * <p>
 * 
 * JRedis管理
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　季清思　2017年12月29日 　<br/>
 *
 * @author jiqingsi
 * @email  so@zz.com
 * @version 1.0,2017年12月29日 <br/>
 * 
 */
public class JedisShiroCacheManager implements ShiroCacheManager {

    private JedisManager jedisManager;

    @Override
    public <K, V> Cache<K, V> getCache(String name) {
        return new JedisShiroCache<K, V>(name, getJedisManager());
    }

    @Override
    public void destroy() {
    	//如果和其他系统，或者应用在一起就不能关闭
    	//getJedisManager().getJedis().shutdown();
    }

    public JedisManager getJedisManager() {
        return jedisManager;
    }

    public void setJedisManager(JedisManager jedisManager) {
        this.jedisManager = jedisManager;
    }
}

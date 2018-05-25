package com.zz.core.shiro.cache.impl;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.util.Destroyable;

import com.zz.core.shiro.cache.ShiroCacheManager;

/**
 * 
 * 开发公司：zz.com<br/>
 * 版权：zz.com<br/>
 * <p>
 * 
 * shiro Custom Cache
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 创建　季清思　2017年12月29日 　<br/>
 * <p>
 * *******
 * <p>
 * @author jqs
 * @email  json@zz.com
 * @version 1.0,2017年12月29日 <br/>
 * 
 */
public class CustomShiroCacheManager implements CacheManager, Destroyable {

    private ShiroCacheManager shiroCacheManager;

    @Override
    public <K, V> Cache<K, V> getCache(String name) throws CacheException {
        return getShiroCacheManager().getCache(name);
    }

    @Override
    public void destroy() throws Exception {
        shiroCacheManager.destroy();
    }

    public ShiroCacheManager getShiroCacheManager() {
        return shiroCacheManager;
    }

    public void setShiroCacheManager(ShiroCacheManager shiroCacheManager) {
        this.shiroCacheManager = shiroCacheManager;
    }

}

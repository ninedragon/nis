package com.zz.uaop;

import org.aspectj.lang.ProceedingJoinPoint;

public class MultipleDataSourceAspectAdvice {

    public void doAround(ProceedingJoinPoint jp) throws Throwable {
        if (jp.getSignature().getName().equals("findAllEE")) {
        	System.out.println("okjinru");
            MultipleDataSource.setDataSourceKey("sqlServerDataSource");
        } else {
            MultipleDataSource.setDataSourceKey("mySqlDataSource");
        }
      
         jp.proceed();
         MultipleDataSource.setDataSourceKey("mySqlDataSource");
         System.out.println("结束方法更改数据源");
    }

}

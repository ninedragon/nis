package com.zz.edata.service.impl;

import com.zz.edata.service.HelloWorld;

public class HelloWorldImpl1 implements HelloWorld {

	@Override
	public void printHelloWorld() {
        System.out.println("Enter HelloWorldImpl1.printHelloWorld()");
		
	}

	@Override
	public void doPrint() {
		System.out.println("Enter HelloWorldImpl1.doPrint()");
        return ;		
	}

}

package com.zz.common.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Cmd {
	public Cmd(String cmdline) {
		try {
			String line;
			Process p = Runtime.getRuntime().exec(cmdline);
			 StreamGobbler errorGobbler = new StreamGobbler(p.getErrorStream(), "ERROR");           
             errorGobbler.start();  
              StreamGobbler outGobbler = new StreamGobbler(p.getInputStream(), "STDOUT");  
              outGobbler.start();  
			BufferedReader input = new BufferedReader(new InputStreamReader(
					p.getInputStream()));
			while ((line = input.readLine()) != null) {
				System.out.println(line);
			}
			input.close();
		} catch (Exception err) {
			err.printStackTrace();
		}
	}
	
}

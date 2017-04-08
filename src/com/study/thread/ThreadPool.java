package com.study.thread;

import java.math.BigDecimal;
import java.util.concurrent.AbstractExecutorService;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

/***
 * 线程池测试
 * @author ScreenJxp
 *
 */
public class ThreadPool {
	public static class MyTask implements Runnable{

		public void run() {
			System.out.println(System.currentTimeMillis()+":Thread id:"+Thread.currentThread().getId());
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();//
			}
		}
		
	}
	public static void main(String[] args) {
		/*MyTask task = new MyTask();
		ExecutorService excetorService = Executors.newCachedThreadPool();
		for(int i = 0; i<10;i++){
			excetorService.submit(task);
			//excetorService.shutdown();
		}*/
		//ThreadPoolExecutor
		BigDecimal b1 = new BigDecimal("0.01");
		
		BigDecimal b2 = new BigDecimal("0.01");
		
		System.out.println(b1.compareTo(b2));
		
		
		BigDecimal b3 = new BigDecimal("0.07");
		
		BigDecimal b4 = new BigDecimal("0.10");
		
		System.out.println(b3.compareTo(b4));
		
	}
}

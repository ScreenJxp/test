package com.study.thread;

import java.util.concurrent.locks.LockSupport;

/****
 * lockSupportIntDemo  线程阻塞工具类
 * @author ScreenJxp
 *
 */
public class LockSupportIntDemo {
	public static String u = new String();
	public  static ChangeObjectThread t1 =  new ChangeObjectThread("t1");
	public  static ChangeObjectThread t2 = new ChangeObjectThread("t2");
	public static class ChangeObjectThread extends Thread{
		public ChangeObjectThread(String name){
			super.setName(name);
		}
		public void run() {
			synchronized (u) {
				System.out.println("in "+getName());
				LockSupport.park();
				if(Thread.interrupted()){
					System.out.println(getName()+" 线程被中断了！");
				}
				System.out.println(getName()+" 线程执行结束了！" );
			}
		}
	}
	public static void main(String[] args) throws InterruptedException {
		t1.start();
		Thread.sleep(100);
		t2.start();
		t1.interrupt();
		LockSupport.unpark(t2);
	}
}	

package com.study.thread;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.ForkJoinTask;
import java.util.concurrent.RecursiveTask;
/****
 * 分而治只Fork/join 可携带返回值
 * 的任务
 * @author ScreenJxp
 *
 */
public class RecursiveTaskDemo extends RecursiveTask<Long> {
	private static final int THRESHOLD =1000;
	private long start;
	private long end;
	public RecursiveTaskDemo(long start,long end) {
		this.start = start;
		this.end = end;
	}
	@Override
	protected Long compute() {
		long sum = 0;
		boolean canCompute =(end-start) < THRESHOLD;
		if(canCompute){
			for(long i = start ;i<=end;i++){
				sum += i;
			}
		}else{
			//分成100个小任务
			long step = (start+end) /100;
			ArrayList<RecursiveTaskDemo> subTasks = new ArrayList<RecursiveTaskDemo>();
			long pos = start;
			for(int i=0;i<100 ;i++){
				long lastOne = pos+step;
				if(lastOne>end) lastOne = end;
				RecursiveTaskDemo  subTask = new RecursiveTaskDemo(pos, lastOne);
				pos+= step+1;
				subTasks.add(subTask);
				subTask.fork();
			}
			for (RecursiveTaskDemo t:subTasks){
				sum+=t.join();
			}
		}
		return sum;
	}
	/****
	 * 
	 * @return
	 */
	public static  long sum(long start,long end){
		long sum = 0;
		for(long i = start ;i<=end;i++){
			sum += i;
		}
		return sum;
	}
	public static void main(String[] args) {
		ForkJoinPool forkJoinPool =new ForkJoinPool();
		RecursiveTaskDemo task = new RecursiveTaskDemo(1, 100000L);
		ForkJoinTask<Long> result = forkJoinPool.submit(task);
		long res;
		try {
			Long task_start = System.currentTimeMillis();
			res = result.get();
			long task_end =System.currentTimeMillis();
			System.out.println("多线程分发计算时间："+(task_end - task_start)+"");
			System.out.println("sum="+ res);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
		Long s_start = System.currentTimeMillis();
		Long single = RecursiveTaskDemo.sum(1, 100000);
		long s_end =System.currentTimeMillis();
		System.out.println("单线程计算时间："+(s_end - s_start)+"");
		System.out.println("单线程sum="+single);
		CopyOnWriteArrayList<String>  write = new CopyOnWriteArrayList<String>();
		//线程安全的HahsMap
		Collections.synchronizedMap(new HashMap<String, String>());
	}
}

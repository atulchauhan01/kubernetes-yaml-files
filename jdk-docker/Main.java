import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.List;


public class Main {
	public static void main(String[] args) {
		System.out.println("Inside main");
		
		RuntimeMXBean runtimeMxBean = ManagementFactory.getRuntimeMXBean();
		List<String> arguments = runtimeMxBean.getInputArguments();
		for (String vmargs : arguments) {
			System.out.println(vmargs);
		}
		try {
			Thread.sleep(100000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}



public class exTcp{
	public static void main(String[] args) throws Exception{
		TCPClient tcpcl = new TCPClient();
		TCPClient tcpcl2 = new TCPClient();
		tcpcl.imp(args[0]);
		tcpcl2.imp(args[1]);
	}
}
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.Socket;

/**
 * TCP Socket Implementation
 */
public class TCPClient
{

        public static void imp(String msg) throws Exception
        {
                System.out.println("Client Started...");

                Socket socket = new Socket("192.168.4.211", 80);
                DataInputStream is = new DataInputStream(new BufferedInputStream(socket.getInputStream()));
                DataOutputStream os = new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));

                // Create Client Request
                String request = msg;

                // Send Client Request to Server
                send(os, request.getBytes());
                System.out.println("Data sent to Server ; Message = " + request);

                try
                {
                        while (true)
                        {
                                // Receive Server Response
                                byte[] byteData = receive(is);
                                String responseData = new String(byteData);
                                System.out.println("Server Response = " + responseData.trim());
                                socket.close();
                        }
                }
                catch (Exception e)
                {
                        // System.out.println("Exception: " + e.getMessage());
                }
        }

        /**
         * Method receives the Server Response
         */
        public static byte[] receive(DataInputStream is) throws Exception
        {
                try
                {
                        byte[] inputData = new byte[1024];
                        is.read(inputData);
                        return inputData;
                }
                catch (Exception exception)
                {
                        throw exception;
                }
        }

        /**
         * Method used to Send Request to Server
         */
        public static void send(DataOutputStream os, byte[] byteData) throws Exception
        {
                try
                {
                        os.write(byteData);
                        os.flush();
                }
                catch (Exception exception)
                {
                        throw exception;
                }
        }
}
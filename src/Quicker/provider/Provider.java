package Quicker.provider;

import com.rsa.jsafe.provider.SecureRandomEx;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.client.urlconnection.HTTPSProperties;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.KeyStore;
import java.security.cert.X509Certificate;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

/**
 *
 */
public class Provider {

	private static String user = "maxim";
	private static String pass = "123";
	private static String serverURL = "https://localhost:8181/Quicker/";
	private Client client;
	private static Provider instance = null;

	private Provider(){
		File file = new File("jssecacerts");
		if (file.isFile() == false) {
			char SEP = File.separatorChar;
			File dir = new File(System.getProperty("java.home") + SEP
					+ "lib" + SEP + "security");
			file = new File(dir, "jssecacerts");
			if (file.isFile() == false) {
				file = new File(dir, "cacerts");
			}
		}

		KeyStore ks = null;
		try {
			ks = KeyStore.getInstance(KeyStore.getDefaultType());
			InputStream in;
			in = new FileInputStream(file);
			ks.load(in, "changeit".toCharArray());
			in.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		SavingTrustManager tm = null;
		try{
			TrustManagerFactory tmf =
					TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
			tmf.init(ks);
			X509TrustManager defaultTrustManager = (X509TrustManager) tmf.getTrustManagers()[0];
			 tm = new SavingTrustManager(defaultTrustManager);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		HostnameVerifier hv = new HostnameVerifier() {

			@Override
			public boolean verify(String urlHostName, SSLSession session) {
				if (urlHostName.equals(session.getPeerHost())) {
					return true;
				} else {
					return false;
				}
			}
		};
		SSLContext ssl = null;
		try{
			ssl = SSLContext.getInstance("TLSv1");
			ssl.init(null, new TrustManager[]{tm}, SecureRandomEx.getInstance("HMACDRBG"));
			HTTPSProperties https = new HTTPSProperties(hv, ssl);
			client = Client.create();
			client.getProperties().put(HTTPSProperties.PROPERTY_HTTPS_PROPERTIES, https);
			client.addFilter(new HTTPBasicAuthFilter(user, pass));
		}catch(Exception ex){
			ex.printStackTrace();
		}

		
		try {
			SSLSocketFactory factory = ssl.getSocketFactory();
			SSLSocket socket = (SSLSocket)factory.createSocket("localhost", 8181);
			socket.setSoTimeout(10000);
			System.out.println("Starting SSL handshake...");
			socket.startHandshake();
			socket.close();
			System.out.println();
			System.out.println("No errors, certificate is already trusted");
		} catch (Exception e) {
			System.out.println("certificate not trusted...");
			X509Certificate[] chain = tm.chain;
			X509Certificate cert = chain[0];
			String alias = "localhost" + "-" + (0 + 1);
			try{
				ks.setCertificateEntry(alias, cert);

				OutputStream out = new FileOutputStream(file);
				ks.store(out, "changeit".toCharArray());
				out.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			System.out.println("Certificete added.");
		}

	}

	public static Provider getInstance(){
		if(instance == null){
			instance = new Provider();
		}
		return instance;
	}

	public <T> T get(String uri,Class<T> t){
		return client.resource(serverURL + uri).get(t);
	}

	public void delete(String uri){
		client.resource(uri).delete();
	}

	public void put(String uri,Object t){
		client.resource(uri).put(t);
	}

	public void post(String uri,Object t){
		client.resource(uri).post(t);
	}
}

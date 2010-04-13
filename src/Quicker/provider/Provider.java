package Quicker.provider;

import com.rsa.jsafe.provider.SecureRandomEx;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.client.urlconnection.HTTPSProperties;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.security.KeyStore;
import java.security.cert.X509Certificate;
import java.util.logging.Level;
import java.util.logging.Logger;
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

	public static String user = "maxim";
	private static String pass = "123";
	private static URL serverURL = null;
	private Client client;
	private KeyStore ks = null;
	private SSLContext ssl = null;
	private static Provider instance = null;

	private Provider(){
		
		try {
			serverURL = new URL("HTTPS", "localhost", 8181, "/Quicker/");
		} catch (MalformedURLException ex) {
			ex.printStackTrace();
		}
		
		try {
			ks = KeyStore.getInstance(KeyStore.getDefaultType());
			InputStream in;
			in = new FileInputStream(getCacerts());
			ks.load(in, "changeit".toCharArray());
			in.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		SavingTrustManager tm = null;
		try{
			TrustManagerFactory tmf =
					TrustManagerFactory.getInstance(TrustManagerFactory.
					getDefaultAlgorithm());
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

		if(!IsCertAlreadyTrusted()){
			X509Certificate[] chain = tm.chain;
			X509Certificate cert = chain[0];
			addCertInStore(serverURL.getHost(), cert);
		}
	}

	/**
	 * Try out "Handshake"
	 * @return
	 */
	public boolean IsCertAlreadyTrusted(){
		try{
			SSLSocketFactory factory = ssl.getSocketFactory();
			SSLSocket socket = (SSLSocket)factory.createSocket(
					serverURL.getHost(), serverURL.getPort());
			socket.setSoTimeout(10000);
			socket.startHandshake();
			socket.close();
		}catch(Exception ex){
			System.out.println(ex.getMessage());
			return false;
		}
		return true;
	}

	/**
	 * Add certificate in key store
	 * @param alias - Name of host for certificate's record
	 * @param chain - Certificate
	 */
	private void addCertInStore(String alias, X509Certificate chain){
		try{
			ks.setCertificateEntry(alias, chain);
			OutputStream out = new FileOutputStream(getCacerts());
			ks.store(out, "changeit".toCharArray());
			out.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	public static Provider getInstance(){
		if(instance == null){
			instance = new Provider();
		}
		return instance;
	}

	public <T> T get(String uri,Class<T> t){
		return client.resource(serverURL.toString() + uri).get(t);
	}

	public void delete(String uri){
		client.resource(serverURL.toString()+uri).delete();
	}

	public void put(String uri,Object t){
		client.resource(serverURL.toString()+uri).put(t);
	}

	public void post(String uri,Object t){
		client.resource(serverURL.toString()+uri).post(t);
	}

	/**
	 *
	 * @return java.io.File - file contains trusted certificates
	 */
	private File getCacerts(){
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
		return file;
	}
}

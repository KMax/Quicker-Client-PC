package Quicker.provider;

import com.rsa.jsafe.provider.JsafeJCE;
import com.rsa.jsafe.provider.SecureRandomEx;
import com.rsa.jsse.JsseProvider;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.client.urlconnection.HTTPSProperties;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
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

	public String user;
	private URL serverURL;
	private Client client;
	private KeyStore ks;
	private SSLContext ssl;
	private char[] trustPass = {'c', 'h', 'a', 'n', 'g', 'e', 'i', 't'};
	private JsseProvider rsaJsseProvider = new JsseProvider();
	private JsafeJCE rsaJceProvider = new JsafeJCE();

	public Provider(URL host, String user, String pass) {
		this.user = user;
		this.serverURL = host;

		SavingTrustManager tm = null;
		try {
			TrustManagerFactory tmf = createTrustManagerFactory();
			X509TrustManager defaultTrustManager = (X509TrustManager) tmf.getTrustManagers()[0];
			tm = new SavingTrustManager(defaultTrustManager);
		} catch (Exception ex) {
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


		try {
			ssl = SSLContext.getInstance("TLSv1");
			ssl.init(null, new TrustManager[]{tm}, SecureRandomEx.getInstance("HMACDRBG"));
			HTTPSProperties https = new HTTPSProperties(hv, ssl);
			client = Client.create();
			client.getProperties().put(HTTPSProperties.PROPERTY_HTTPS_PROPERTIES, https);
			client.addFilter(new HTTPBasicAuthFilter(user, pass));
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		if (!IsCertAlreadyTrusted()) {
			X509Certificate[] chain = tm.chain;
			X509Certificate cert = chain[0];
			addCertInStore(serverURL.getHost(), cert);
		}
	}

	/**
	 * Try out "Handshake"
	 * @return
	 */
	public boolean IsCertAlreadyTrusted() {
		try {
			SSLSocketFactory factory = ssl.getSocketFactory();
			SSLSocket socket = (SSLSocket) factory.createSocket(
					serverURL.getHost(), serverURL.getPort());
			socket.setSoTimeout(10000);
			socket.startHandshake();
			socket.close();
		} catch (Exception ex) {
			return false;
		}
		return true;
	}

	/**
	 * Add certificate in key store
	 * @param alias - Name of host for certificate's record
	 * @param chain - Certificate
	 */
	private void addCertInStore(String alias, X509Certificate chain) {
		try {
			ks.setCertificateEntry(alias, chain);
			
			if(getTrustStore() == null){
				ks.store(new FileOutputStream("TrustStore.pkcs12"), trustPass);
			}else{
				OutputStream out = new FileOutputStream(getTrustStore());
				ks.store(out, trustPass);
				out.close();
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public <T> T get(String uri, Class<T> t) {
		return client.resource(serverURL.toString() + uri).get(t);
	}

	public void delete(String uri) {
		client.resource(serverURL.toString() + uri).delete();
	}

	public void put(String uri, Object t) {
		client.resource(serverURL.toString() + uri).put(t);
	}

	public void post(String uri, Object t) {
		client.resource(serverURL.toString() + uri).post(t);
	}

	/**
	 *
	 * @return - file contains trusted certificates
	 */
	private File getTrustStore() {
		char SEP = File.separatorChar;
		File file = new File("TrustStore.pkcs12");
		if (!(file.isFile())) {
			return null;
		}
		return file;
	}

	private TrustManagerFactory createTrustManagerFactory()
			throws NoSuchAlgorithmException, KeyStoreException,
			IOException, CertificateException {

		ks = KeyStore.getInstance("PKCS12", rsaJceProvider);
		
		if(getTrustStore()==null){
			ks.load(null, null);
		}else{
			InputStream in = new FileInputStream(getTrustStore());
			ks.load(in, trustPass);
			in.close();
		}
		

		TrustManagerFactory tmf =
				TrustManagerFactory.getInstance(JsseProvider.PKIX, rsaJsseProvider);
		tmf.init(ks);
		return tmf;
	}
}

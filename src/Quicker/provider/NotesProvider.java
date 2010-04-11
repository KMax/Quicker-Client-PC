package Quicker.provider;

import com.rsa.jsafe.provider.SecureRandomEx;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.client.urlconnection.HTTPSProperties;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLException;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

/**
 *
 */
public class NotesProvider {

	private static NotesProvider instance = null;
	private Client client;
	private String userName = "maxim";
	private String password = "123";
	public static String serverURL = "https://localhost:8181/Quicker/";

	private NotesProvider()
			throws NoSuchAlgorithmException, KeyManagementException,
			KeyStoreException, FileNotFoundException, IOException, CertificateException {

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

		KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
		InputStream in = new FileInputStream(file);
		ks.load(in, "changeit".toCharArray());
		in.close();

		TrustManagerFactory tmf =
				TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
		tmf.init(ks);
		X509TrustManager defaultTrustManager = (X509TrustManager) tmf.getTrustManagers()[0];
		SavingTrustManager tm = new SavingTrustManager(defaultTrustManager);

		HostnameVerifier hv = new HostnameVerifier() {

			public boolean verify(String urlHostName, SSLSession session) {
				if (urlHostName.equals(session.getPeerHost())) {
					return true;
				} else {
					return false;
				}
			}
		};

		SSLContext ssl = SSLContext.getInstance("TLSv1");
		ssl.init(null, new TrustManager[]{tm}, SecureRandomEx.getInstance("HMACDRBG"));
		HTTPSProperties https = new HTTPSProperties(hv, ssl);
		client = Client.create();
		client.getProperties().put(HTTPSProperties.PROPERTY_HTTPS_PROPERTIES, https);
		client.addFilter(new HTTPBasicAuthFilter(userName, password));
		
		//Проверка существования сертификата для данного сервера
		try {
			SSLSocketFactory factory = ssl.getSocketFactory();
			SSLSocket socket = (SSLSocket) factory.createSocket("localhost",8181);
			socket.setSoTimeout(10000);
			System.out.println("Starting SSL handshake...");
			socket.startHandshake();
			socket.close();
			System.out.println("No errors, certificate is already trusted");
		} catch (SSLException e) {
			//FIXME Добавить сертификат в хранилище
			e.printStackTrace();
		}

	}

	public static NotesProvider getInstance() {
		if (instance == null) {
			try {
				instance = new NotesProvider();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return instance;
	}

	public String getNotesList() {
		WebResource r = client.resource(serverURL + userName + "/notes");
		return r.get(String.class);
	}

	public String getNote(int id) {
        return client.resource(serverURL + userName + "/note/"+id)
				.get(String.class);
    }

	public void updateNote(String note, int id) {
        client.resource(serverURL + userName + "/note/"+id).put(note);
    }

	public void deleteNote(int id) {
        client.resource(serverURL + userName + "/note/" + id).delete();
    }

	public void createNote(String note) {
		client.resource(serverURL + userName + "/note/").post(note);
	}
}


package Quicker.provider;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import javax.net.ssl.X509TrustManager;


public class SavingTrustManager implements X509TrustManager{

	private X509TrustManager tm;
	public X509Certificate[] chain;
	SavingTrustManager(X509TrustManager trustManager) {
		this.tm = trustManager;
	}

	@Override
	public void checkClientTrusted(X509Certificate[] xcs, String string) throws CertificateException {
		throw new UnsupportedOperationException();
	}

	@Override
	public void checkServerTrusted(X509Certificate[] xcs, String authType) throws CertificateException {
		this.chain = xcs;
		tm.checkServerTrusted(xcs, authType);
	}

	@Override
	public X509Certificate[] getAcceptedIssuers() {
		throw new UnsupportedOperationException();
	}

}

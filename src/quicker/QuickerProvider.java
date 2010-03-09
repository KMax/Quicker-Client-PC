package quicker;

import java.io.IOException;

import org.restlet.Client;
import org.restlet.data.ChallengeResponse;
import org.restlet.data.ChallengeScheme;
import org.restlet.data.MediaType;
import org.restlet.data.Method;
import org.restlet.data.Protocol;
import org.restlet.data.Request;
import org.restlet.data.Response;
import org.restlet.data.Status;

//TODO add exception handling

public class QuickerProvider {

    private String _user = "User";
    private Client _client;
    private String _serverUrl = "localhost:8181/quicker";
    private static QuickerProvider _instance = null;
    private ChallengeResponse _authentication;

    public static QuickerProvider getInstance() {
        if (_instance == null) {
            _instance = new QuickerProvider();
        }
        return _instance;
    }

    private QuickerProvider() {
        _client = new Client(Protocol.HTTP);
        // configuring authentication
        ChallengeScheme _scheme = ChallengeScheme.HTTP_BASIC;
        _authentication = new ChallengeResponse(_scheme, "login", "pass");
    }

    public boolean createNote(String title, String content) {
        Request request = new Request(Method.POST, _serverUrl + "/" + _user + "/note/");
        String toSend = "<title>"+title+"</title><content>"+content+"</content>";
        request.setEntity(toSend, MediaType.APPLICATION_XML);
        String result = handleResponse(_client.handle(request));
        
        if (result == "No content"){
        	return false;
        }
        return true;
    }

    public String getNote(int id) {
        Request request = new Request(Method.GET, _serverUrl + "/" + _user + "/note/1/");
        request.setChallengeResponse(_authentication);
        String result = handleResponse(_client.handle(request));

        return result;
    }

    public boolean updateNote(int id) {
        Request request = new Request(Method.PUT, _serverUrl + "/" + _user + "/note/1/");
        request.setChallengeResponse(_authentication);
        request.setEntity("<note>That's my note updated. </note>", MediaType.APPLICATION_XML);
        String result = handleResponse(_client.handle(request));
        
        if (result == "No content"){
        	return false;
        }
        return true;
    }

    public boolean deleteNote(int id) {
        Request request = new Request(Method.DELETE, _serverUrl + "/" + _user + "/note/1/");
        request.setChallengeResponse(_authentication);
        String result = handleResponse(_client.handle(request));
        
        if (result == "No content"){
        	return false;
        }
        return true;
    }

    public String getNotesList() {
        Request request = new Request(Method.GET, _serverUrl + "/" + _user + "/notes/");
        request.setChallengeResponse(_authentication);
        String result = handleResponse(_client.handle(request));
        
        return result;
    }
    
    private String handleResponse(Response response)
    {
    	String result = "No content. ";
    	if (response.getStatus().equals(Status.CLIENT_ERROR_UNAUTHORIZED)) {
            System.out.println("Access denied by the server, " + " check your credentials. ");
        } else {
            System.out.println("An unexpected status was returned: " + response.getStatus());
        }
    	if (response.getStatus().isSuccess()) {
    		try {
    			result = response.getEntity().getText();
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
        }
    	
    	return result;
    }
}

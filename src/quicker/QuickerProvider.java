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

    public boolean createNote(String title, String content) throws IOException {
        Request request = new Request(Method.POST, _serverUrl + "/" + _user + "/note/");
        String toSend = "<title>"+title+"</title><content>"+content+"</content>";
        request.setEntity(toSend, MediaType.APPLICATION_XML);
        Response response = _client.handle(request);
        if (response.getEntity().getText() != "<error>Error!</error>") {
            return true;
        }
        return false;
    }

    public String getNote(int id) throws IOException {
        Request request = new Request(Method.GET, _serverUrl + "/" + _user + "/note/1/");
        request.setChallengeResponse(_authentication);
        Response response = _client.handle(request);

        if (response.getStatus().isSuccess()) {
            return response.getEntity().getText();
        } else if (response.getStatus().equals(Status.CLIENT_ERROR_UNAUTHORIZED)) {
            System.out.println("Access authorized by the server, " + "check your credentials");
        } else {
            System.out.println("An unexpected status was returned: " + response.getStatus());
        }
        return "Error";
    }

    public boolean updateNote(int id) throws IOException {
        Request request = new Request(Method.PUT, _serverUrl + "/" + _user + "/note/1/");
        request.setEntity("<note>That's my note updated. </note>", MediaType.APPLICATION_XML);
        Response response = _client.handle(request);
        if (response.getStatus().isSuccess()) {
            return true;
        } else if (response.getStatus().equals(Status.CLIENT_ERROR_UNAUTHORIZED)) {
            System.out.println("Access authorized by the server, " + "check your credentials");
        } else {
            System.out.println("An unexpected status was returned: " + response.getStatus());
        }
        return false;
    }

    public boolean deleteNote(int id) throws IOException {
        Request request = new Request(Method.DELETE, _serverUrl + "/" + _user + "/note/1/");
        Response response = _client.handle(request);
        if (response.getStatus().isSuccess()) {
            return true;
        } else if (response.getStatus().equals(Status.CLIENT_ERROR_UNAUTHORIZED)) {
            System.out.println("Access authorized by the server, " + "check your credentials");
        } else {
            System.out.println("An unexpected status was returned: " + response.getStatus());
        }
        return false;
    }

    public String getNotesList() throws IOException {
        Request request = new Request(Method.GET, _serverUrl + "/" + _user + "/notes/");
        Response response = _client.handle(request);
        return response.getEntity().getText();
    }
}

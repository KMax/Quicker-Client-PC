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

public class QuickerProvider {

    private String _user;
    private Client _client;
    private String _serverUrl;
    private static QuickerProvider _instance = null;
    ChallengeScheme scheme = ChallengeScheme.HTTP_BASIC;
    ChallengeResponse authentication = new ChallengeResponse(scheme,
            "login", "pass");

    public static QuickerProvider getInstance(String user, String url) {
        if (_instance == null) {
            _instance = new QuickerProvider(user, url);
        }
        return _instance;
    }

    private QuickerProvider(String user, String url) {
        _user = user;
        _serverUrl = url;
        _client = new Client(Protocol.HTTP);
    }

    public String test() throws IOException {
        Request request = new Request(Method.GET, _serverUrl);
        request.setChallengeResponse(authentication);
        Response response = _client.handle(request);

        if (response.getStatus().isSuccess()) {
           return response.getEntity().getText();
        //	client.get("http://www.restlet.org").getEntity().write(System.out);
        } else if (response.getStatus().equals(Status.CLIENT_ERROR_UNAUTHORIZED)) {
            System.out.println("Access authorized by the server, " + "check your credentials");
        } else {
            System.out.println("An unexpected status was returned: " + response.getStatus());
        }
        return "-1";

    }

    public boolean createNote(String title, String content) throws IOException {
        Request request = new Request(Method.POST, _serverUrl + "/" + _user + "/note/");
        request.setEntity(content, MediaType.APPLICATION_XML);
        Response response = _client.handle(request);
        if (response.getEntity().getText() != "<error>Error!</error>") {
            return true;
        }
        return false;
    }

    public String getNote(int id) throws IOException {
        Request request = new Request(Method.GET, _serverUrl + "/" + _user + "/note/1/");
        request.setChallengeResponse(authentication);
        Response response = _client.handle(request);

        if (response.getStatus().isSuccess()) {
            return response.getEntity().getText();
        } else if (response.getStatus().equals(Status.CLIENT_ERROR_UNAUTHORIZED)) {
            System.out.println("Access authorized by the server, " + "check your credentials");
        } else {
            System.out.println("An unexpected status was returned: " + response.getStatus());
        }
        return "-1";
    }

    public boolean updateNote(int id) throws IOException {
        Request request = new Request(Method.PUT, _serverUrl + "/" + _user + "/note/1/");
        request.setEntity("<note>That's my note updated. </note>", MediaType.APPLICATION_XML);
        Response response = _client.handle(request);
        if (response.getEntity().getText() != "<error>Error!</error>") {
            return true;
        }
        return false;
    }

    public boolean deleteNote(int id) throws IOException {
        Request request = new Request(Method.DELETE, _serverUrl + "/" + _user + "/note/1/");
        Response response = _client.handle(request);
        if (response.getEntity().getText() != "<error>Error!</error>") {
            return true;
        }
        return false;
    }

    public String getNotesList() throws IOException {
        Request request = new Request(Method.GET, _serverUrl + "/user/notes/");
        Response response = _client.handle(request);
        return response.getEntity().getText();
    }
}

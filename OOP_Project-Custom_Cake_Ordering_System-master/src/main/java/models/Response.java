package models;

public class Response {
    public boolean status = true;
    public String message;

    public Response(boolean status, String message) {
        this.status = status;
        this.message = message;
    }

    public Response(boolean status) {
        this.status = status;
    }

    public Response() {

    }
}

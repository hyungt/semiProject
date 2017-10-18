package kr.co.jtimes.profile.common.web;

import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;

public class SMTPServlet extends Authenticator {
   public SMTPServlet() {
        super();
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        String username = "qoaak0662@gmail.com";
        String password = "";
        return new PasswordAuthentication(username, password);
    }
}
package management;
/**
 *
 * @author Julian Edriel
 */

import java.io.Serializable;

public class Users implements Serializable{
    private static final long serialVersionUID = 1L;
    private String username;
    private String fullname;
    private String email;
    private String password;
    
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getFullname() {
        return fullname;
    }
    public void setFullname(String name) {
        this.fullname = name;
    }
    
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}

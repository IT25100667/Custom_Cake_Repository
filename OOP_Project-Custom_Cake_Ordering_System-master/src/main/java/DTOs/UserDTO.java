package DTOs;

import com.example.jooq.tables.records.TblUsersRecord;

public class UserDTO {
    public int id;
    private String password;
    public String username;
    public boolean employee;
    public String email;
    public String user_address;
    public String phone_number;
    
    public UserDTO() {
    }

    public UserDTO(int id, String password, String username, boolean employee, String email, String user_address, String phone_number) {
        this.id = id;
        this.password = password;
        this.username = username;
        this.employee = employee;
        this.email = email;
        this.user_address = user_address;
        this.phone_number = phone_number;
    }

    public UserDTO(TblUsersRecord tblUsersRecord, boolean includePwrd) {

        this.id =  tblUsersRecord.getId();
        this.username = tblUsersRecord.getUsername();
        this.email = tblUsersRecord.getEmail();
        this.user_address = tblUsersRecord.getUserAddress();
        this.employee = tblUsersRecord.getEmployee();
        this.phone_number = tblUsersRecord.getPhoneNumber();
        this.id = tblUsersRecord.getId();
        if(includePwrd){
            this.password = tblUsersRecord.getPassword();
        }
    }

    public TblUsersRecord getRecord(){
        return getRecord(false);
    }

    public TblUsersRecord getRecord(boolean includeID) {
        TblUsersRecord record = new TblUsersRecord();
        if(includeID) record.setId(id);
        record.setUsername(username);
        record.setPassword(password);
        record.setEmployee(employee);
        record.setEmail(email);
        record.setUserAddress(user_address);
        record.setPhoneNumber(phone_number);
        return record;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isEmployee() {
        return employee;
    }

    public void setEmployee(boolean employee) {
        this.employee = employee;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUser_address() {
        return user_address;
    }

    public void setUser_address(String user_address) {
        this.user_address = user_address;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }
}

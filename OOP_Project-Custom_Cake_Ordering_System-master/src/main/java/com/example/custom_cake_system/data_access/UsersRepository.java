package com.example.custom_cake_system.data_access;

import DTOs.UserDTO;
import com.example.jooq.tables.records.TblUsersRecord;
import models.Response;
import org.jooq.DSLContext;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static com.example.jooq.tables.TblUsers.TBL_USERS;

@Repository
public class UsersRepository {

    DSLContext _context;
    public UsersRepository(DSLContext _context) {
        this._context = _context;
    }

    public UserDTO getUserDetails(String username, boolean includePwrd) {
        Optional<TblUsersRecord> value = _context.selectFrom(TBL_USERS).where(TBL_USERS.USERNAME.eq(username)).fetchOptional();
        if(value.isEmpty()){
            return null;
        }
        TblUsersRecord usersRecord = value.get();
        return new UserDTO(usersRecord, includePwrd);
    }

    public UserDTO getUserByUsername(String username) {
        return getUserDetails(username, false);
    }

    public UserDTO getUserDetailsByEmail(String email, boolean includePwrd) {
        Optional<TblUsersRecord> value = _context.selectFrom(TBL_USERS).where(TBL_USERS.EMAIL.eq(email)).fetchOptional();
        if(value.isEmpty()){
            return null;
        }
        TblUsersRecord usersRecord = value.get();
        return new UserDTO(usersRecord, includePwrd);
    }

    public List<UserDTO> getAllUsers() {
        List<UserDTO> users = new ArrayList<>();
        for (TblUsersRecord x : _context.selectFrom(TBL_USERS).fetch()) {
            users.add(new UserDTO(x, false));
        }
        return users;
    }

    public boolean doesUserExist(int ID){
        return _context.selectFrom(TBL_USERS).where(TBL_USERS.ID.eq(ID)).stream().count()==1;
    }

    public boolean areUserCredentialsValid(String username, String password){
        return _context.selectFrom(TBL_USERS).where(TBL_USERS.USERNAME.eq(username)).and(TBL_USERS.PASSWORD.eq(password)).stream().count()==1;
    }

    public Response updateUserDetails(UserDTO user){
        try{
            _context.update(TBL_USERS).set(user.getRecord()).where(TBL_USERS.ID.eq(user.id));
            return new Response();
        } catch (Exception e) {
            return new Response(false, e.getMessage());
        }
    }

    public Response addNewUser(UserDTO user){
        try{
            _context.insertInto(TBL_USERS,
                            TBL_USERS.USERNAME,
                            TBL_USERS.PASSWORD,
                            TBL_USERS.EMAIL,
                            TBL_USERS.USER_ADDRESS,
                            TBL_USERS.PHONE_NUMBER,
                            TBL_USERS.EMPLOYEE
                    )
                    .values(user.username, user.getPassword(), user.email, user.user_address, user.phone_number, user.employee)
                    .execute();
            _context.insertInto(TBL_USERS).set(user.getRecord()).execute();
            return new Response();
        } catch (Exception e) {
            return new Response(false, e.getMessage());
        }
    }

    public Response deleteUser(int id){
        try{
            _context.delete(TBL_USERS).where(TBL_USERS.ID.eq(id));
            return new Response();
        } catch (Exception e) {
            return new Response(false, e.getMessage());
        }
    }

    public Response deleteUser(String username){
        try{
            _context.delete(TBL_USERS).where(TBL_USERS.USERNAME.eq(username));
            return new Response();
        } catch (Exception e) {
            return new Response(false, e.getMessage());
        }
    }

}

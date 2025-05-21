package com.payment.dao;

import com.payment.model.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
//DAO
public class UserDAO {
    private static final String FILE_PATH = "C:/Users/USER/Downloads/project new/payment/src/main/resources/data/users.txt";

    public void saveUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }
        
        List<User> users = getAllUsers();
        if (user.getId() == null) {
            user.setId(UUID.randomUUID().toString());
        }
        users.add(user);
        saveAllUsers(users);
    }

    public User getUserByEmail(String email) {
        if (email == null || email.isEmpty()) {
            throw new IllegalArgumentException("Email cannot be null or empty");
        }
        
        List<User> users = getAllUsers();
        return users.stream()
                .filter(u -> u.getEmail().equals(email))
                .findFirst()
                .orElse(null);
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        File file = new File(FILE_PATH);
        
        if (!file.exists()) {
            return users;
        }
        
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
            users = (List<User>) ois.readObject();
        } catch (FileNotFoundException e) {
            // File doesn't exist yet, return empty list
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return users;
    }

    private void saveAllUsers(List<User> users) {
        if (users == null) {
            throw new IllegalArgumentException("Users cannot be null");
        }
        
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                file.createNewFile();
            }
            try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file))) {
                oos.writeObject(users);
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to save users: " + e.getMessage());
        }
    }

    public void updateUser(User user) {
        if (user == null || user.getId() == null) {
            throw new IllegalArgumentException("User or user ID cannot be null");
        }
        
        List<User> users = getAllUsers();
        boolean found = false;
        
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId().equals(user.getId())) {
                users.set(i, user);
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new RuntimeException("User not found with ID: " + user.getId());
        }
        
        saveAllUsers(users);
    }

    public boolean validateCredentials(String email, String password) {
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Email and password cannot be null or empty");
        }
        
        User user = getUserByEmail(email);
        return user != null && user.getPassword().equals(password);
    }

    public void deactivateUser(String userId) {
        if (userId == null || userId.isEmpty()) {
            throw new IllegalArgumentException("User ID cannot be null or empty");
        }
        
        List<User> users = getAllUsers();
        boolean found = false;
        
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId().equals(userId)) {
                users.remove(i);
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new RuntimeException("User not found with ID: " + userId);
        }
        
        saveAllUsers(users);
    }
}

using DatabaseModelProject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAOLayer
{
    public class UserDAO
    {
        public bool insertUser(User user, UserRequest req)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var ur = db.UserRequests.Where(r => r.token == req.token && r.RequestId == req.RequestId).FirstOrDefault();
                if (ur == null)
                    return false;
                user.email = ur.Email;
                user.isActive = true;
                ur.token = Guid.NewGuid().ToString();
                db.Users.Add(user);
                try
                {
                    db.SaveChanges();                    
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }
            }
        }

        public User verify(string email, string pass)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var user = db.Users.Where(u => u.email == email && u.password == pass && u.isActive == true).FirstOrDefault();
                if (user == null)
                    return null;
                else
                    return user;
            }
        }


        public bool generateToken(UserRequest req)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var user = db.Users.Where(u => u.email == req.Email).FirstOrDefault();
                if (user != null)
                    return false;
                var ur = db.UserRequests.Where(u => u.Email == req.Email).FirstOrDefault();
                if (ur != null)
                    return false;
                req.token = "";
                try
                {
                    db.UserRequests.Add(req);
                    db.SaveChanges();
                    return true;
                }
                catch(Exception e)
                {
                    return false;
                }

            }
        }

        public List<UserRequest> getUserRequests()
        {

            using (var db = new DatabaseModelProject.Model())
            {
                return db.UserRequests.Where(u => u.active == false && (u.token == null || u.token == "")).OrderByDescending(u => u.oncreated).ToList();

            }
        }

        public UserRequest getUserRequest(int id)
        {

            using (var db = new DatabaseModelProject.Model())
            {
                var req = db.UserRequests.Where(u => u.RequestId == id).FirstOrDefault();
                if (req == null)
                    return null;
                try
                {
                    req.token = Guid.NewGuid().ToString();
                    db.SaveChanges();
                    return req;
                }
                catch (Exception e)
                {
                    return null;
                }
            }
        }

        public bool deleteUserRequest(int id)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                try
                {
                    var req = new UserRequest
                    {
                        RequestId = id
                    };
                    db.UserRequests.Attach(req);
                    db.UserRequests.Remove(req);
                    db.SaveChanges();
                    return true;
                }
                catch(Exception e)
                {
                    return false;
                }
            }
        }

        public bool SentRequest(int id)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var req = db.UserRequests.Where(u => u.RequestId == id).FirstOrDefault();
                if (req == null)
                    return false;
                try
                {
                    req.active = true;
                    db.SaveChanges();
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }

            }
        }

        public UserRequest checkRequest(string Token)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                return db.UserRequests.Where(u => u.token == Token).FirstOrDefault();                
            }
        }

        public List<User> getUsers()
        {
            using (var db = new DatabaseModelProject.Model())
            {
                return db.Users.ToList();
            }
        }

        public User userStatus(int id, int p)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var user = db.Users.Where(u => u.UserID == id && u.email != "admin@gmail.com").FirstOrDefault();
                if (user == null)
                    return null;
                user.isActive = p == 1 ? true : false;
                try
                {
                    db.SaveChanges();
                    return user;
                }
                catch(Exception e)
                {
                    return null;
                }
            }
        }

        public UserRequest generateToken(string Email)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var user = db.Users.Where(u => u.email == Email && u.isActive == true).FirstOrDefault();
                if (user == null)
                    return null;
                var req = db.UserRequests.Where(r => r.Email == Email).FirstOrDefault();
                req.token = Guid.NewGuid().ToString();
                try
                {
                    db.SaveChanges();
                    return req;
                }
                catch (Exception e)
                {
                    return null;
                }
            }
        }

        public UserRequest changePasswodTokenCheck(string token, string Email)
        {
            using(var db = new Model())
            {
                return db.UserRequests.Where(r => r.Email == Email && r.token == token).FirstOrDefault();
            }
        }

        public bool updatePassword(UserRequest request,String password)
        {
            using (var db = new Model())
            {
                var req = db.UserRequests.Where(r => r.RequestId == request.RequestId).FirstOrDefault();
                if (req == null)
                    return false;
                var user = db.Users.Where(u => u.email == req.Email).FirstOrDefault();
                if (user == null)
                    return false;
                user.password = password;
                try
                {
                    db.SaveChanges();
                    return true;
                }
                catch(Exception e)
                {
                    return false;
                }
            }
        }

        public bool updatePassword(int p, String password)
        {
            using (var db = new Model())
            {
                var user = db.Users.Where(u => u.UserID == p).FirstOrDefault();
                if (user == null)
                    return false;
                user.password = password;
                try
                {
                    db.SaveChanges();
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }
            }
        }
    }
}

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
        public bool insertUser(DatabaseModelProject.User user)
        {
            using (var db = new DatabaseModelProject.Model())
            {
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
                var user = db.Users.Where(u => u.email == email && u.password == pass).FirstOrDefault();
                if (user == null)
                    return null;
                else
                    return user;
            }
        }
    }
}

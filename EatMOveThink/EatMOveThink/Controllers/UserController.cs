using DAOLayer;
using DatabaseModelProject;
using EatMOveThink.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Configuration;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace EatMOveThink.Controllers
{
    public class UserController : Controller
    {
        // GET: User
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Login()
        {
            if (Session["user"] != null)
                return RedirectToAction("Index", "Home");

            Session["TOKEN"] = null;

            ViewBag.Message = "Login";
            return View();
        }
        [HttpPost]
        public ActionResult Login(LoginViewModel login)
        {
            ViewBag.Message = "Login";
            Session["TOKEN"] = null;
            UserDAO dao = new UserDAO();
            var user = dao.verify(login.Email, login.Password);
            if (user != null)
            {
                Session["user"] = user.username;
                Session["userId"] = user.UserID;
                if(user.username.ToLower() == "admin")
                    Session["admin"] = user.username;
                return RedirectToAction("Index", "Home");
            }
            ViewBag.error = "Email or Password is incorrect !!";
            return View();
        }
        [HttpGet]
        public ActionResult Logout()
        {
            Session["user"] = null;
            Session["userId"] = null;
            Session["admin"] = null;
            Session["TOKEN"] = null;
            return RedirectToAction("Index", "Home");
        }
        [HttpGet]
        public ActionResult ChangePassword()
        {
            UserDAO dao = new UserDAO();
            if (Request.QueryString["Token"] != null && Request.QueryString["Email"] != null && Request.QueryString.Count == 2 && Session["user"] == null)
            {
                String token = Request.QueryString["Token"];
                String Email = Request.QueryString["Email"];
                UserRequest req = dao.changePasswodTokenCheck(token, Email);
                if (req == null)
                {
                    return RedirectToAction("Login", "User");
                }
                Session["TOKEN"] = req;
            }
            return View();
        }
        [HttpPost]
        public ActionResult ChangePassword(FormCollection form)
        {
            UserDAO dao = new UserDAO();
            String pass = form["password"];
            if(Session["user"] != null)
            {
                bool res = dao.updatePassword((int)Session["userId"], pass);
                return RedirectToAction("Index", "Home");
            }
            else if(Session["TOKEN"] != null)
            {
                UserRequest req = (UserRequest)Session["TOKEN"];
                bool res = dao.updatePassword(req,pass);
            }
            return RedirectToAction("Login", "User");
        }
        public ActionResult SignUp()
        {
            String Token = Request.QueryString["Token"];
            if(Token == null)
                return RedirectToAction("Login", "User");
            UserDAO dao = new UserDAO();
            UserRequest req = dao.checkRequest(Token);
            if(req == null)
            {
                return RedirectToAction("Login", "User");
            }
            ViewBag.Message = "SignUp";
            return View(req);
        }
        [HttpGet]
        public ActionResult RequestJoin()
        {
            Session["TOKEN"] = null;
            ViewBag.Message = "SignUp";
            return View();
        }
        [HttpGet]
        public ActionResult ForgetPassword()
        {
            Session["TOKEN"] = null;
            ViewBag.Message = "ForgetPassword";
            return View();
        }
        [HttpPost]
        public ActionResult ForgetPassword(FormCollection form)
        {
            Session["TOKEN"] = null;
            ViewBag.Message = "ForgetPassword";
            String Email = form["email"];
            if (!string.IsNullOrEmpty(Email))
            {
                string emailRegex = @"^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$";
                Regex re = new Regex(emailRegex);
                if (!re.IsMatch(Email))
                {
                    ViewBag.error = "Please Enter Correct Email Address";
                    return View();
                }
            }
            UserDAO dao = new UserDAO();
            UserRequest req= dao.generateToken(Email);
            if (req != null)
            {
                string link = String.Format("http://eatmovethinkhub.com/User/ChangePassword?Token={0}&Email={1}",req.token,req.Email);
                SendEmailModel model = new SendEmailModel
                {
                    To = req.Email,
                    Subject = "Change Password Request",
                    Body = "<a href='" + link + "'>Click to Change Password for Account</a>"
                };
                if(SendMail(model) == true)
                {
                    ViewBag.error = "";
                }
                else
                {
                    ViewBag.error = "Invalid Email Address !!";
                }
            }
            else
                ViewBag.error = "Invalid Email Address !!";
            return View();
        }

        private bool SendMail(SendEmailModel model)
        {
            var smtpSection = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = new System.Net.Mail.MailAddress(smtpSection.From);

            // The important part -- configuring the SMTP client

            SmtpClient smtp = new SmtpClient();
            smtp.Port = smtpSection.Network.Port;   // [1] You can try with 465 also, I always used 587 and got success
            smtp.EnableSsl = smtpSection.Network.EnableSsl;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network; // [2] Added this
            smtp.UseDefaultCredentials = smtpSection.Network.DefaultCredentials; // [3] Changed this
            smtp.Credentials = new NetworkCredential(mail.From.ToString(), smtpSection.Network.Password);  // [4] Added this. Note, first parameter is NOT string.
            smtp.Host = smtpSection.Network.Host;

            //recipient address
            mail.To.Add(new MailAddress(model.To));

            //Formatted mail body http://students.org.pk/Classroom/Download?activityId=12  http://eatmovethinkhub.com/
            mail.IsBodyHtml = true;
            mail.Subject = model.Subject;
            mail.Body = model.Body;
            mail.BodyEncoding = Encoding.UTF8;
            mail.SubjectEncoding = Encoding.UTF8;
            AlternateView htmlView = AlternateView.CreateAlternateViewFromString(model.Body);
            htmlView.ContentType = new System.Net.Mime.ContentType("text/html");
            mail.AlternateViews.Add(htmlView);
            try
            {
                smtp.Send(mail);
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }
        [HttpPost]
        public ActionResult RequestJoin(FormCollection form)
        {
            Session["TOKEN"] = null;
            ViewBag.Message = "SignUp";
            String Email = form["email"];
            if (!string.IsNullOrEmpty(Email))
            {
                string emailRegex = @"^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$";
                Regex re = new Regex(emailRegex);
                if (!re.IsMatch(Email))
                {
                    ViewBag.error = "Please Enter Correct Email Address";
                    return View();
                }
            }
            UserDAO dao = new UserDAO();
            UserRequest req = new UserRequest();
            req.Email = Email;
            req.oncreated = DateTime.Now;
            req.active = false;
            bool res = dao.generateToken(req);
            if (res == true)
                ViewBag.error = "";
            else
                ViewBag.error = "Email is Already Registered !!";
            return View();
        }
        [HttpPost]
        public ActionResult SignUp(User user, UserRequest req)
        {
            if (Request.Form["ispublic"] != null)
            {
                user.ispublic = true;
            }
            if (Request.Form["newsletter"] != null)
            {
                user.newsletter = true;
            }
            if (Request.Form["gender"] != null)
            {
                if (Request.Form["gender"] == "1")
                    user.gender = 1;
                else if(Request.Form["gender"] == "0")
                {
                    user.gender = 0;
                }
            }
            if (user.username.Trim() == "admin")
                user.username += "2";
            UserDAO dao = new UserDAO();
            bool res = dao.insertUser(user,req);
            if (res == true)
            {
                Session["user"] = user.username;
                Session["userId"] = user.UserID;
                if (user.username == "admin")
                    Session["admin"] = user.username;
                return RedirectToAction("Index", "Home");
            }
            else
                return RedirectToAction("Login", "User");
            ViewBag.error = "Email Already Exists";
            ViewBag.Message = "SignUp";
            return View();
        }
    }
}
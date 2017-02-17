using DAOLayer;
using DatabaseModelProject;
using EatMOveThink.Models;
using System;
using System.Collections.Generic;
using System.Linq;
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

            ViewBag.Message = "Login";
            return View();
        }
        [HttpPost]
        public ActionResult Login(LoginViewModel login)
        {
            ViewBag.Message = "Login";
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
            return RedirectToAction("Index", "Home");
        }
        public ActionResult SignUp()
        {
            ViewBag.Message = "SignUp";
            return View();
        }
        [HttpPost]
        public ActionResult SignUp(User user)
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
            UserDAO dao = new UserDAO();
            bool res = dao.insertUser(user);
            if(res == true)
            {
                Session["user"] = user.username;
                Session["userId"] = user.UserID;
                if (user.username == "admin")
                    Session["admin"] = user.username;
                return RedirectToAction("Index","Home");
            }
            ViewBag.error = "Email Already Exists";
            ViewBag.Message = "SignUp";
            return View();
        }
    }
}
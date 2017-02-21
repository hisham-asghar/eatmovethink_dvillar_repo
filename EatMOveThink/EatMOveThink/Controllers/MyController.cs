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
using System.Web;
using System.Web.Mvc;

namespace EatMOveThink.Controllers
{
    public class MyController : Controller
    {
        public ActionResult Achievements()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            
            int uid = 0;
            if (Session["user"] != null)
            {
                uid = (int)Session["userId"];
            }
            ProgramDAO dao = new ProgramDAO();
            AchievmentPoints model = dao.getAchievmentPoints(uid);

            ViewBag.totalP = ((double)model.gain_totalPts) / model.totalPts * 100;
            ViewBag.dailyP = ((double)model.gain_dailyPts) / model.dailyPts * 100;
            ViewBag.programP = ((double)model.gain_programPts) / model.programPts * 100;
            return View(model);
        }
        [HttpGet]
        public ActionResult BookAnExpert()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            return View();
        }
        [HttpPost]
        public ActionResult BookAnExpert(PractitionerModel model)
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            
            String Head = "Practitioner Appointment Request";
            SendEmailModel modelEMail = new SendEmailModel
            {
                Body = "Name: " + model.Name + "<br />" + "Surname: " + model.Surname + "<br />" + "Email: " + model.Email + "<br />" + "Required Appointment: " + model.appointment_t + " - " + model.appointment_D + "<br />" + "Company: " + model.company + "<br />" + "Phone #: " + model.phone + "<br />" + "Practitioner #: " + model.Practitioner + "<br />",
                Subject = "Practitioner Appointment Request",
                To = "FRONTDESK@COMPLETECITYHEALTH.COM.AU"
            };
            bool res = SendMail(modelEMail);
            if (res == true)
                ViewBag.msg = "Your practitioner request has been received. We will contact you as soon as possible.";
            return View();
        }

        [HttpGet]
        public ActionResult Users()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            if (Session["admin"] == null)
                return RedirectToAction("Index", "Home");
            UserDAO dao = new UserDAO();
            if (Request.QueryString["token"] != null && Request.QueryString["id"] != null && Request.QueryString.Count == 2)
            {
                string token = Request.QueryString["token"];
                int id = Convert.ToInt32(Request.QueryString["id"]);
                if (token == "activate")
                {
                    User req = dao.userStatus(id,1);
                    if (req != null)
                    {
                        SendEmailModel model = new SendEmailModel{
                            To = req.email,
                            Body = "<h3>You account has been activated.</h3>",
                            Subject = "Account Information eatmovethink.com"
                        };
                        bool mailRes = SendMail(model);
                    }

                }
                else if (token == "deactivate")
                {
                    User req = dao.userStatus(id, 0);
                    if (req != null)
                    {
                        SendEmailModel model = new SendEmailModel{
                            To = req.email,
                            Body = "<h3>You account has been deactivated.</h3>",
                            Subject = "Account Information eatmovethink.com"
                        };
                        bool mailRes = SendMail(model);
                    }
                }
            }

            List<User> list = dao.getUsers();

            return View(list);
        }

        [HttpGet]
        public ActionResult UsersRequest()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            if (Session["admin"] == null)
                return RedirectToAction("Index", "Home");

            UserDAO dao = new UserDAO();
            if(Request.QueryString["token"] != null && Request.QueryString["id"] != null && Request.QueryString.Count == 2)
            {
                string token = Request.QueryString["token"];
                int id = Convert.ToInt32(Request.QueryString["id"]);
                if (token == "accept")
                {
                    UserRequest req = dao.getUserRequest(id);
                    if(req != null)
                    {
                        string link = "http://eatmovethinkhub.com/User/SignUp?Token=" + req.token;
                        SendEmailModel emailModel = new SendEmailModel();
                        emailModel.Body = "<a href='" + link + "'>Click to SignUp for Account</a>";
                        emailModel.To = req.Email;
                        emailModel.Subject = "Request Accepted for Account on eatmovethink.com";
                        bool mailRes = SendMail(emailModel);
                        bool mailSendRes = dao.SentRequest(id);
                    }

                }
                else if (token == "reject")
                {
                    bool res = dao.deleteUserRequest(id);
                }
            }

            List<UserRequest> list = dao.getUserRequests();

            return View(list);
        }

        public bool SendMail(SendEmailModel model)
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
        public ActionResult Challenges()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            
            ProgramDAO dao = new ProgramDAO();
            int uid = 0;
            if (Session["user"] != null)
            {
                uid = (int)Session["userId"];
            }
            var list = dao.getPrograms(uid).Where(p => p.isSubscribed == true).ToList();
            return View(list);
        }
        public ActionResult Day()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;



            String dateStr = Request.QueryString["day"];
            DateTime date;
            if (dateStr == null)
                date = DateTime.Now;
            else
                date = Convert.ToDateTime(dateStr);

            ViewBag.PrevDate = date.AddDays(-1).ToString("yyyy-MM-dd");
            ViewBag.Date = date.ToString("yyyy-MM-dd");
            ViewBag.DisplayDate = date.ToString("dd-MM-yyyy");
            ViewBag.LongDate = date.ToLongDateString();
            ViewBag.NextDate = date.AddDays(1).ToString("yyyy-MM-dd");

            String goalStr = Request.QueryString["goal"];
            if (goalStr == null)
                goalStr = "eat";

            int uid = (int)Session["userId"];


            DailyDAO dao = new DailyDAO();
            ViewBag.Goal = goalStr.ToLower();
            if(Request.HttpMethod == "POST")
            {
                var list = SaveModel(Request, goalStr);
                bool res = dao.updateTasks(uid, list);
            }

            List<UserDailyTasksPoints> tasks = dao.getModels(uid, date);

            if (goalStr == "eat")
            {
                EatModels model = getEatModel(tasks);
                return View("Eat",model);
            }
            else if (goalStr == "move")
            {
                return View("Move",getMoveModel(tasks));
            }
            else if (goalStr == "think")
            {
                return View("Think", getThinkModel(tasks));
            }
            else
            {
                EatModels model = getEatModel(tasks); 
                return View("Eat");
            }
        }


        private List<_UserDailyTask> SaveModel(HttpRequestBase Request, string goalStr)
        {
            List<_UserDailyTask> list = new List<_UserDailyTask>();
            if (goalStr == "think")
            {
                ThinkModels model = new ThinkModels();
                if (Request.Form["day"] != null)
                {
                    model.day = Convert.ToDateTime(Request.Form["day"]);
                }
                
                if (Request.Form["enjoy"] != null)
                    list.Add(new _UserDailyTask(model.day, "enjoy", true));
                else
                    list.Add(new _UserDailyTask(model.day, "enjoy", false));
                
                if (Request.Form["affirmation"] != null)
                    list.Add(new _UserDailyTask(model.day, "affirmation", true));
                else
                    list.Add(new _UserDailyTask(model.day, "affirmation", false));
                
                if (Request.Form["smile"] != null)
                    list.Add(new _UserDailyTask(model.day, "smile", true));
                else
                    list.Add(new _UserDailyTask(model.day, "smile", false));
                
                if (Request.Form["meditate"] != null)
                    list.Add(new _UserDailyTask(model.day, "meditate", true));
                else
                    list.Add(new _UserDailyTask(model.day, "meditate", false));
                
                if (Request.Form["breath"] != null)
                    list.Add(new _UserDailyTask(model.day, "breath", true));
                else
                    list.Add(new _UserDailyTask(model.day, "breath", false));
            }
            else if (goalStr == "move")
            {
                MoveModels model = new MoveModels();
                if (Request.Form["day"] != null)
                    model.day = Convert.ToDateTime(Request.Form["day"]);
                
                if (Request.Form["posture"] != null)
                    list.Add(new _UserDailyTask(model.day, "posture", true));
                else
                    list.Add(new _UserDailyTask(model.day, "posture", false));
                
                if (Request.Form["weight"] != null)
                    list.Add(new _UserDailyTask(model.day, "weight", true));
                else
                    list.Add(new _UserDailyTask(model.day, "weight", false));
                
                if (Request.Form["exercise"] != null)
                    list.Add(new _UserDailyTask(model.day, "exercise", true));
                else
                    list.Add(new _UserDailyTask(model.day, "exercise", false));
                
                if (Request.Form["walk"] != null)
                    list.Add(new _UserDailyTask(model.day, "walk", true));
                else
                    list.Add(new _UserDailyTask(model.day, "walk", false));
                
                if (Request.Form["stretch"] != null)
                    list.Add(new _UserDailyTask(model.day, "stretch", true));
                else
                    list.Add(new _UserDailyTask(model.day, "stretch", false));
            }
            else
            {
                DateTime day = Convert.ToDateTime(Request.Form["day"]);

                if (Request.Form["water"] != null)
                    list.Add(new _UserDailyTask(day, "water", true));
                else
                    list.Add(new _UserDailyTask(day, "water", false));

                if (Request.Form["veggies"] != null)
                    list.Add(new _UserDailyTask(day, "veggies", true));
                else
                    list.Add(new _UserDailyTask(day, "veggies", false));

                if (Request.Form["cafineIntake"] != null)
                    list.Add(new _UserDailyTask(day, "cafineIntake", true));
                else
                    list.Add(new _UserDailyTask(day, "cafineIntake", false));

                if (Request.Form["processedFood"] != null)
                    list.Add(new _UserDailyTask(day, "processedFood", true));
                else
                    list.Add(new _UserDailyTask(day, "processedFood", false));

                if (Request.Form["snack"] != null && Request.Form["snack"] == "1" )
                    list.Add(new _UserDailyTask(day, "snack", true));
                else
                    list.Add(new _UserDailyTask(day, "snack", false));

                if (Request.Form["lunch"] != null && Request.Form["lunch"] == "1")
                    list.Add(new _UserDailyTask(day, "lunch", true));
                else
                    list.Add(new _UserDailyTask(day, "lunch", false));

                if (Request.Form["dinner"] != null && Request.Form["dinner"] == "1")
                    list.Add(new _UserDailyTask(day, "dinner", true));
                else
                    list.Add(new _UserDailyTask(day, "dinner", false));

                if (Request.Form["breakfast"] != null && Request.Form["breakfast"] == "1")
                    list.Add(new _UserDailyTask(day, "breakfast", true));
                else
                    list.Add(new _UserDailyTask(day, "breakfast", false));

                if (Request.Form["alcohol"] != null && Request.Form["alcohol"] == "2")
                    list.Add(new _UserDailyTask(day, "alcohol", true));
                else
                    list.Add(new _UserDailyTask(day, "alcohol", false));
                
            }
            return list;
        }


        private EatModels getEatModel(List<UserDailyTasksPoints> tasks)
        {
            EatModels model = new EatModels();
            foreach (var t in tasks)
            {
                if (t.TaskName == "water")
                {
                    model.water = t;
                    if (t.Finish == true)
                    {
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "veggies")
                {
                    model.veggies = t;
                    if (t.Finish == true)
                    {
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "processedFood")
                {
                    model.processFood = t;
                    if (t.Finish == true)
                    {
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "cafineIntake")
                {
                    model.caffine = t;
                    if (t.Finish == true)
                    {
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "breakfast")
                {
                    model.breakfast = t;
                    if (t.Finish == true)
                    {
                        model.junk += t.Points;
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "snack")
                {
                    model.snack = t;
                    if (t.Finish == true)
                    {
                        model.junk += t.Points;
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "lunch")
                {
                    model.lunch = t;
                    if (t.Finish == true)
                    {
                        model.junk += t.Points;
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "dinner")
                {
                    model.dinner = t;
                    if (t.Finish == true)
                    {
                        model.junk += t.Points;
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "alcohol")
                {
                    model.alcohol = t;
                    if (t.Finish == true)
                    {
                        model.junk += t.Points;
                        model.eatPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if(t.Finish == true)
                {
                    if (t.TaskName == "enjoy" || t.TaskName == "affirmation" || t.TaskName == "smile" || t.TaskName == "meditate" || t.TaskName == "breath")
                        model.thinkPts += t.Points;
                    else
                        model.movePts += t.Points;
                    model.totalPts += t.Points;
                }
            }
            return model;
        }

        private ThinkModels getThinkModel(List<UserDailyTasksPoints> tasks)
        {
            ThinkModels model = new ThinkModels();
            foreach (var t in tasks)
            {
                if (t.TaskName == "enjoy")
                {
                    model.enjoy = t;
                    if (t.Finish == true)
                    {
                        model.thinkPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "affirmation")
                {
                    model.affirmation = t;
                    if (t.Finish == true)
                    {
                        model.thinkPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "smile")
                {
                    model.smile = t;
                    if (t.Finish == true)
                    {
                        model.thinkPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "meditate")
                {
                    model.meditate = t;
                    if (t.Finish == true)
                    {
                        model.thinkPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "breath")
                {
                    model.breath = t;
                    if (t.Finish == true)
                    {
                        model.thinkPts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if(t.Finish == true)
                {
                    if (t.TaskName == "posture" || t.TaskName == "weight" || t.TaskName == "exercise" || t.TaskName == "walk" || t.TaskName == "stretch")
                        model.movePts += t.Points;
                    else
                        model.eatPts += t.Points;
                    model.totalPts += t.Points;
                }
            }
            return model;
        }

        private MoveModels getMoveModel(List<UserDailyTasksPoints> tasks)
        {
            MoveModels model = new MoveModels();
            foreach (var t in tasks)
            {
                if (t.TaskName == "posture")
                {
                    model.posture = t;
                    if (t.Finish == true)
                    {
                        model.movePts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "weight")
                {
                    model.weight = t;
                    if (t.Finish == true)
                    {
                        model.movePts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "exercise")
                {
                    model.exercise = t;
                    if (t.Finish == true)
                    {
                        model.movePts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "walk")
                {
                    model.walk = t;
                    if (t.Finish == true)
                    {
                        model.movePts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if (t.TaskName == "stretch")
                {
                    model.stretch = t;
                    if (t.Finish == true)
                    {
                        model.movePts += t.Points;
                        model.totalPts += t.Points;
                    }
                }
                else if(t.Finish == true)
                {
                    if (t.TaskName == "enjoy" || t.TaskName == "affirmation" || t.TaskName == "smile" || t.TaskName == "meditate" || t.TaskName == "breath")
                        model.thinkPts += t.Points;
                    else
                        model.eatPts += t.Points;
                    model.totalPts += t.Points;
                }
            }
            return model;
        }
    }
}
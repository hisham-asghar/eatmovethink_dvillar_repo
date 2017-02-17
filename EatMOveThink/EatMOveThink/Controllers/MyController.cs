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
    public class MyController : Controller
    {
        public ActionResult Achievements()
        {
            if (Session["user"] == null)
                return RedirectToAction("Index", "Home");
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
        public ActionResult BookAnExpert()
        {
            if (Session["user"] == null)
                return RedirectToAction("Index", "Home");
            else
                ViewBag.signed = true;

            return View();
        }
        public ActionResult Challenges()
        {
            if (Session["user"] == null)
                return RedirectToAction("Index", "Home");
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
                return RedirectToAction("Index", "Home");
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
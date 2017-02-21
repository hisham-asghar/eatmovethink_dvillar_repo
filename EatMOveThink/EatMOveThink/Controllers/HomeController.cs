using DAOLayer;
using DatabaseModelProject;
using EatMOveThink.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EatMOveThink.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            ViewBag.PageName = "/";
            return View();
        }

        public ActionResult About()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult AskExpert()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            ViewBag.Message = "Experts";

            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Editor(string Title,String Content)
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            StaticDataDAO dao = new StaticDataDAO();
            var res = dao.updatePage(Title,Content);

            return RedirectToAction(Title,"Home");
        }
        public ActionResult Eat()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            String Title = "Eat";
            StaticDataDAO dao = new StaticDataDAO();
            var res = dao.getPage(Title);

            ViewBag.Title = Title;
            ViewBag.Message = Title;
            ViewBag.PageName = Title;
            ViewBag.Image = "/img/eatbanner.jpg";

            ViewBag.Html = res.Value;
            if (Request.Url.Segments.Length == 4 && Request.Url.Segments[3] == "Editor")
                return View("EditorStaticTabView");
            else
                return View("StaticTabView");
        }
        public ActionResult Move()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            String Title = "Move";
            StaticDataDAO dao = new StaticDataDAO();
            var res = dao.getPage(Title);

            ViewBag.Title = Title;
            ViewBag.Message = Title;
            ViewBag.PageName = Title;
            ViewBag.Image = "/img/movebanner.jpg";
            ViewBag.Html = res.Value;
            if (Request.Url.Segments.Length == 4 && Request.Url.Segments[3] == "Editor")
                return View("EditorStaticTabView");
            else
                return View("StaticTabView");
        }
        public ActionResult Think()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            String Title = "Think";
            StaticDataDAO dao = new StaticDataDAO();
            var res = dao.getPage(Title);

            ViewBag.Title = Title;
            ViewBag.Message = Title;
            ViewBag.PageName = Title;
            ViewBag.Image = "/img/thinkbanner.jpg";

            ViewBag.Html = res.Value;
            if (Request.Url.Segments.Length == 4 && Request.Url.Segments[3] == "Editor")
                return View("EditorStaticTabView");
            else
                return View("StaticTabView");

            return View();
        }
        public ActionResult Goals()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            int uid = 0;
            uid = (int)Session["userId"];

            ProgramDAO dao = new ProgramDAO();
            if(Request.QueryString.Count == 2 && Request.QueryString["sp"] != null && Request.QueryString["pt"] != null )
            {
                SubscribeProgramTask task = new SubscribeProgramTask();
                task.SubscribeProgramID = Convert.ToInt32(Request.QueryString["sp"]);
                task.ProgramTaskID = Convert.ToInt32(Request.QueryString["pt"]);
                bool res = dao.completeProgramTask(task);
            }

            List<DatabaseModelProject.DailySubscribedGoals> goalList = dao.getDailySubscribedGoals(uid);

            ViewBag.Message = "Goals";
            ViewBag.PageName = "Goals";

            return View(goalList);
        }

        public ActionResult WhatsNew()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            String Title = "WhatsNew";
            StaticDataDAO dao = new StaticDataDAO();
            var res = dao.getPage(Title);

            ViewBag.Title = Title;
            ViewBag.Message = Title;
            ViewBag.PageName = Title;
            ViewBag.Image = "/img/whatsnewbanner.jpg";

            ViewBag.Html = res.Value;
            if (Request.Url.Segments.Length == 4 && Request.Url.Segments[3] == "Editor")
                return View("EditorStaticTabView");
            else
                return View("StaticTabView");

            return View();
        }
        [HttpGet]
        public ActionResult Challenges()
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;

            ViewBag.Message = "Challenges";
            ViewBag.PageName = "Challenges";

            int uid = 0;
            if (Session["user"] != null)
            {
                uid = (int)Session["userId"];
            }
            ProgramDAO dao = new ProgramDAO();
            if(Request.QueryString.Count == 1 && Request.QueryString["query"] == "add")
            {
                if(Session["admin"] != null)
                {
                    var list = dao.getAllPrograms();
                    return View("AddProgram",list);
                }
            }
            if (Request.QueryString.Count == 1 && Request.QueryString["pid"] != null)
            {
                int pid = Convert.ToInt32(Request.QueryString["pid"]);
                var program = dao.getProgramDetail(pid);
                if (program != null)
                {
                    ViewBag.Program = program;
                    var tlist = dao.getProgramTasks(pid);
                    return View("ProgramDetail", tlist);
                }
            }
            if (Request.QueryString.Count == 1 && Request.QueryString["remove"] != null)
            {
                int pid = Convert.ToInt32(Request.QueryString["remove"]);
                Program res = dao.removeProgram(pid);
                if(res != null)
                {
                    try
                    {
                        System.IO.File.Delete(Server.MapPath("/") + res.pdf);
                        System.IO.File.Delete(Server.MapPath("/") + res.ImageURL);
                    }
                    catch (Exception e)
                    {
                        int x = 0;
                    }
                }
            }
            if (Request.QueryString.Count == 1 && Request.QueryString["join"] != null)
            {
                if(Session["user"] == null)
                {
                    return RedirectToAction("Login", "User");
                }
                else
                {
                    int pid = Convert.ToInt32(Request.QueryString["join"]);
                    SubscribeProgram sub = new SubscribeProgram();
                    sub.UserID = (int)Session["userId"];
                    sub.ProgramID = pid;
                    bool res = dao.subsribe(sub);
                    if (res == true)
                        return RedirectToAction("Challenges", "Home");
                }
            }
            var listSub = dao.getPrograms(uid);

            return View(listSub);
        }
        
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Challenges(HttpPostedFileBase image, HttpPostedFileBase pdfDocument, List<ProgramTask> tasks, Program program, int[] programIds)
        {
            if (Session["user"] == null)
                return RedirectToAction("Login", "User");
            else
                ViewBag.signed = true;
            string img_url = SaveImage(image);
            string pdf_url = SavePDF(pdfDocument);
            ProgramDAO dao = new ProgramDAO();
            if(Request.Form["program.Intensity"] != null)
            {
                program.Intensity = Convert.ToInt32(Request.Form["program.Intensity"]);
            }
            List<AddtionalProgram> extraP = new List<AddtionalProgram>();
            if(programIds != null)
            {

                foreach (var i in programIds)
                {
                    AddtionalProgram a = new AddtionalProgram
                    {
                        ReferencedProgram = i
                    };
                    extraP.Add(a);
                }
            }
            program.ImageURL = img_url;
            program.pdf = pdf_url;
            bool res = dao.saveProgram(tasks, program,extraP);
            int uid = 0;
            if (Session["user"] != null)
            {
                uid = (int)Session["userId"];
            }
            var list = dao.getPrograms(uid);

            return View(list);
        }

        private string SavePDF(HttpPostedFileBase pic)
        {
            if (pic != null && pic.ContentLength > 0)
            {
                try
                {
                    String filePath = Guid.NewGuid().ToString() + ".pdf";
                    string path = Path.Combine(Server.MapPath("~/docs"), Path.GetFileName(filePath));

                    pic.SaveAs(path);
                    return "/docs/" + filePath;
                }
                catch (Exception ex)
                {
                    return "";
                }
            }
            else
            {
                return "";
            }
        }

        private string SaveImage(HttpPostedFileBase pic)
        {
            if (pic != null && pic.ContentLength > 0)
            {
                try
                {
                    String filePath = Guid.NewGuid().ToString()  + ".jpg";
                    string path = Path.Combine(Server.MapPath("~/img"), Path.GetFileName(filePath));

                    pic.SaveAs(path);
                    return "/img/"+filePath;
                }
                catch (Exception ex)
                {
                    return "";
                }
            }
            else
            {
                return "";
            }
        }


        public ActionResult Download()
        {
            if (Request.Url.Segments.Count() == 3 && Request.QueryString.AllKeys.Count() > 0)
            {
                if (Request.QueryString["fileId"] != null)
                {
                    String file = Request.QueryString["fileId"];
                    if (file == null)
                        return new EmptyResult();
                    int id = Convert.ToInt32(file);
                    ProgramDAO dao = new ProgramDAO();
                    var program = dao.getProgramDetail(id);
                    file = program.pdf;
                    KeyValuePair<string, string> ofile = new KeyValuePair<string, string>(file, file);
                    if (ofile.Key == null)
                        return new EmptyResult();
                    string filename = ofile.Key + ofile.Value.Substring(ofile.Value.LastIndexOf("."));
                    string filepath = AppDomain.CurrentDomain.BaseDirectory + "/" + ofile.Value;
                    try
                    {
                        byte[] filedata = System.IO.File.ReadAllBytes(filepath);
                        string contentType = MimeMapping.GetMimeMapping(filepath);
                        return File(filedata, contentType, filename);
                    }
                    catch (Exception e)
                    {
                        return new EmptyResult();
                    }
                }
            }
            return new EmptyResult();
        }
    }
}
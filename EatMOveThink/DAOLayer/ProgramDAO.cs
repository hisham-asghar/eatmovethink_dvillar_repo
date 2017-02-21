using DatabaseModelProject;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAOLayer
{
    public class ProgramDAO
    {
        public List<DatabaseModelProject.SubscribedPrograms> getPrograms(int uid)
        {

            using (var db = new DatabaseModelProject.Model())
            {
                List<DatabaseModelProject.SubscribedPrograms> list;
                try
                {
                    list = db.Programs.Select(p => new DatabaseModelProject.SubscribedPrograms()
                    {
                        ImageURL = p.ImageURL,
                        Intensity = p.Intensity,
                        isSubscribed = p.SubscribePrograms.Where(sp => sp.UserID == uid && sp.ProgramID == p.ProgramID).Count() > 0,
                        Points = p.TotalPoints,
                        ProgramID = p.ProgramID,
                        Text = p.Text,
                        Title = p.Title
                    }).OrderByDescending(p => p.ProgramID).ToList();
                }
                catch(Exception e)
                {
                    list = new List<DatabaseModelProject.SubscribedPrograms>();
                }
                return list;
            }
        }
        public Program getProgramDetail(int pid)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                return db.Programs.Where(p => p.ProgramID == pid).FirstOrDefault();
            }
        }

        public bool saveProgram(List<DatabaseModelProject.ProgramTask> tasks, DatabaseModelProject.Program program, List<AddtionalProgram> programIds)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                using (var dbTrans = db.Database.BeginTransaction())
                {
                    try
                    {
                        program.TotalPoints = program.Points + tasks.Sum(p => p.Points);
                        db.Programs.Add(program);
                        db.SaveChanges();
                        tasks.ForEach(t => t.ProgramID = program.ProgramID);
                        tasks.ForEach(t => t.Text = (t.Text == null ? "" : t.Text));
                        programIds.ForEach(p => p.ProgramId = program.ProgramID);
                        db.ProgramTasks.AddRange(tasks);
                        db.SaveChanges();
                        db.AddtionalPrograms.AddRange(programIds);
                        db.SaveChanges();
                        dbTrans.Commit();
                        return true;
                    }
                    catch (Exception e)
                    {
                        dbTrans.Rollback();
                        return false;
                    }
                } 
            }
        }

        public List<DatabaseModelProject.ProgramTask> getProgramTasks(int pid)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                return db.ProgramTasks.Where(p => p.ProgramID == pid).OrderBy(t => t.WeekID).ThenBy(t => t.DayID).ToList();
            }
        }

        public bool subsribe(DatabaseModelProject.SubscribeProgram sub)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                try
                {
                    if(db.Programs.Where(p => p.ProgramID == sub.ProgramID).FirstOrDefault() == null)
                    {
                        return false;
                    }
                    sub.onSubscribe = DateTime.Now;
                    db.SubscribePrograms.Add(sub);
                    db.SaveChanges();
                    db.Entry(sub).Reload();
                }
                catch (Exception e)
                {
                    return false;
                }
                    var related = db.AddtionalPrograms.Where(p => p.ProgramId == sub.ProgramID).ToList();
                    foreach(var ss in related)
                    {
                        SubscribeProgram pp = new SubscribeProgram
                        {
                            UserID = sub.UserID,
                            ProgramID = ss.ReferencedProgram,
                            onSubscribe = sub.onSubscribe
                        };
                        try
                        {
                            db.SubscribePrograms.Add(pp);
                            db.SaveChanges();
                            db.Entry(pp).Reload();
                        }
                        catch(Exception e)
                        {

                        }
                    }
                return true;
                
            }
        }

        public List<DailySubscribedGoals> getDailySubscribedGoals(int uid)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var programs = db.SubscribePrograms.Where(s => s.UserID == uid);
                List<DailySubscribedGoals> list = new List<DailySubscribedGoals>();
                foreach(var p in programs)
                {
                    var subD = p.onSubscribe;
                    DateTime nowD = DateTime.Now;
                    int days = nowD.Subtract(subD).Days;
                    int weekno = (days / 7) + 1;
                    int dayno = (days % 7) + 1;
                    var goal = db.ProgramTasks.Where(t => t.WeekID == weekno && dayno == t.DayID && t.ProgramID == p.ProgramID)
                        .Select(t => new DailySubscribedGoals()
                        {
                            SubscribeProgramID = p.SubscribeProgramID,
                            isFinished = t.SubscribeProgramTasks.Where(sp => sp.ProgramTaskID == t.ProgramTaskID && sp.SubscribeProgramID == p.SubscribeProgramID).Count() > 0,
                            DayID = t.DayID,
                            Points = t.Points,
                            ProgramID = t.ProgramID,
                            ProgramTaskID = t.ProgramTaskID,
                            Text = t.Text,
                            Title = p.Program.Title,
                            WeekID = t.WeekID
                        }).FirstOrDefault();
                    if(goal != null)
                    {
                        list.Add(goal);
                    }
                }
                return list;
            }
        }

        public bool completeProgramTask(SubscribeProgramTask task)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                try
                {
                    db.SubscribeProgramTasks.Add(task);
                    db.SaveChanges();
                    return true;
                }
                catch(Exception e)
                {
                    return false;
                }
            }
        }

        public AchievmentPoints getAchievmentPoints(int uid)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var model = new AchievmentPoints();
                DateTime day = DateTime.Now;
                var fday = new DateTime(day.Year, day.Month, 1);
                var lday = fday.AddMonths(1).AddDays(-1);
                model.dailyPts = db.DailyTaskPoints.Sum(p => p.Points) * ( (lday - fday).Days + 1 );

                string dailyQ = String.Format("SELECT * FROM dbo.UserDailyTasks t , dbo.DailyTaskPoints p where t.TaskID = p.TaskID and Day >= '{0}' and Day <= '{1}' and UserID = {2}  and Finish = 1;", fday, lday, uid);
                model.gain_dailyPts = db.Database.SqlQuery<DailyTaskPoint>(dailyQ).Sum(p => p.Points);

                var prgs = db.SubscribePrograms.Where(P => P.UserID == uid).ToList();
                if(prgs.Count > 0)
                    model.programPts = prgs.Sum(p => p.Program.TotalPoints);
                else
                    model.programPts = 0;
                string subQ = String.Format("select * from dbo.ProgramTasks pt, dbo.SubscribeProgram sp, dbo .SubscribeProgramTask spt where spt.SubscribeProgramID = sp.SubscribeProgramID and spt.ProgramTaskID = pt.ProgramTaskID and UserID = {0};", uid);
                model.gain_programPts = db.Database.SqlQuery<ProgramTask>(subQ).Sum(p => p.Points);
                
                List<Program> listCompletedPrograms = new List<Program>();
                var subscribedProgamsList = db.SubscribePrograms.Where(sp => sp.UserID == uid);
                foreach (var subscribedProgam in subscribedProgamsList)
                {
                    var subPTasks = db.ProgramTasks.Where(pt => pt.ProgramID == subscribedProgam.ProgramID).Count();
                    var subPTasksCompleted = db.SubscribeProgramTasks.Where(spt => spt.SubscribeProgramID == subscribedProgam.SubscribeProgramID).Count();
                    if (subPTasks == subPTasksCompleted)
                        model.gain_programPts += subscribedProgam.Program.Points;
                }

                model.totalPts = model.programPts + model.dailyPts;
                model.gain_totalPts = model.gain_programPts + model.gain_dailyPts;

                model.totalPts_30 = (int)Math.Round(model.totalPts * 0.3);
                model.totalPts_60 = (int)Math.Round(model.totalPts * 0.65);
                return model;
            }
        }

        public Program removeProgram(int id)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                using(var trans = db.Database.BeginTransaction())
                {
                    try{                        
                        Program p = new Program
                        {
                            ProgramID = id
                        };
                        db.Programs.Attach(p);
                        var sp = db.SubscribePrograms.Where(s => s.ProgramID == id);
                        foreach(var spi in sp )
                        {
                            var sptz = db.SubscribeProgramTasks.Where(s => s.SubscribeProgramID == spi.SubscribeProgramID);
                            db.SubscribeProgramTasks.RemoveRange(sptz);
                            db.SaveChanges();
                        }
                        db.SubscribePrograms.RemoveRange(sp);
                        db.SaveChanges();
                        db.Programs.Remove(p);

                        db.SaveChanges();
                        trans.Commit();
                        return p;
                    }
                    catch(Exception e)
                    {
                        trans.Rollback();
                        return null;
                    }
                }
            }
        }

        public List<Program> getAllPrograms()
        {
            using(var db = new Model())
            {
                return db.Programs.ToList();
            }
        }
    }
}

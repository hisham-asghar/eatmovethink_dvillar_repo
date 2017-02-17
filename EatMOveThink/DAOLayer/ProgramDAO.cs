using DatabaseModelProject;
using System;
using System.Collections.Generic;
using System.Globalization;
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
                        Points = p.Points,
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

        public bool saveProgram(List<DatabaseModelProject.ProgramTask> tasks, DatabaseModelProject.Program program)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                using (var dbTrans = db.Database.BeginTransaction())
                {
                    try
                    {
                        program.Points = tasks.Sum(p => p.Points);
                        db.Programs.Add(program);
                        db.SaveChanges();
                        tasks.ForEach(t => t.ProgramID = program.ProgramID);
                        db.ProgramTasks.AddRange(tasks);
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
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }
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

                model.programPts = db.SubscribePrograms.Where(P => P.UserID == uid).Sum(p => p.Program.Points);
                string subQ = String.Format("select * from dbo.ProgramTasks pt, dbo.SubscribeProgram sp, dbo .SubscribeProgramTask spt where spt.SubscribeProgramID = sp.SubscribeProgramID and spt.ProgramTaskID = pt.ProgramTaskID and UserID = {0};", uid);
                model.gain_programPts = db.Database.SqlQuery<ProgramTask>(subQ).Sum(p => p.Points);

                model.totalPts = model.programPts + model.dailyPts;
                model.gain_totalPts = model.gain_programPts + model.gain_dailyPts;

                model.totalPts_30 = (int)Math.Round(model.totalPts * 0.3);
                model.totalPts_60 = (int)Math.Round(model.totalPts * 0.65);
                return model;
            }
        }
    }
}

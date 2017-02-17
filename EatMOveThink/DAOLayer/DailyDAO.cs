using DatabaseModelProject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAOLayer
{
    public class DailyDAO
    {
        public bool updateTasks(int uid, List<DatabaseModelProject._UserDailyTask> list)
        {
            using(var db = new Model())
            {
                foreach(var task in list)
                {
                    string utq = String.Format("select dt.* from dbo.UserDailyTasks dt join dbo.DailyTaskPoints pt on dt.TaskID = pt.TaskID where UserID = {0} and pt.TaskName = '{1}' and dt.Day = '{2}'",uid,task.Task,task.Day);
                    var ut = db.Database.SqlQuery<UserDailyTask>(utq).FirstOrDefault();

                    if (ut != null)
                    {
                        ut.Finish = task.Finish;
                        string updateQ = String.Format("UPDATE UserDailyTasks SET Finish = {0} WHERE UserDailyTaskID = {1}", task.Finish ? 1 : 0, ut.UserDailyTaskID);
                        try
                        {
                            db.Database.ExecuteSqlCommand(updateQ);
                        }
                        catch(Exception e)
                        {

                        }
                    }
                    else
                    {
                        var tt = new UserDailyTask();
                        tt.Day = task.Day;
                        tt.UserID = uid;
                        tt.TaskID = db.DailyTaskPoints.Where(pt => pt.TaskName == task.Task).Select(pt => pt.TaskID).FirstOrDefault();
                        tt.Finish = task.Finish;
                        string query = String.Format("INSERT INTO UserDailyTasks ([UserID],[Day],[TaskID],[Finish]) VALUES ({0},'{1}',{2},{3})", tt.UserID, tt.Day.Date, tt.TaskID, tt.Finish ? 1 : 0);

                        try
                        {
                            db.Database.ExecuteSqlCommand(query);
                        }
                        catch (Exception e) { }
                    }
                }
                return true;
            }
        }

        public List<UserDailyTasksPoints> getModels(int uid, DateTime date)
        {
            using (var db = new Model())
            {
                string utq = String.Format("select * from dbo.UserDailyTasks dt join dbo.DailyTaskPoints pt on dt.TaskID = pt.TaskID where UserID = {0} and dt.Day = '{1}'", uid, date);
                return db.Database.SqlQuery<UserDailyTasksPoints>(utq).ToList();
            }
        }
    }
}

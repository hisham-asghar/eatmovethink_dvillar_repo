using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseModelProject
{
    public class _UserDailyTask
    {
        private DateTime dateTime;
        private string p1;
        private bool p2;

        public DateTime Day { get; set; }

        public string Task { get; set; }

        public bool Finish { get; set; }

        public _UserDailyTask() { }

        public _UserDailyTask(DateTime day, string task, bool finish)
        {
            Day = day;
            Task = task;
            Finish = finish;
        }
    }

    public partial class MyUserDailyTask
    {
        public int UserDailyTaskID { get; set; }

        public int UserID { get; set; }

        public DateTime Day { get; set; }

        public string TaskName { get; set; }

        public int Points { get; set; }

        public bool Finish { get; set; }

    }

    public class UserDailyTasksPoints
    {
        public string TaskName { get; set; }

        public int Points { get; set; }

        public bool Finish { get; set; }

        public UserDailyTasksPoints() { }

        public UserDailyTasksPoints(string task, int pts, bool finish)
        {
            TaskName = task;
            Points = pts;
            Finish = finish;
        }

    }
}

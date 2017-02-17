using DatabaseModelProject;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EatMOveThink.Models
{
    public class DailyModel
    {
        public DateTime day { get; set; }
        public int eatPts { get; set; }
        public int thinkPts { get; set; }
        public int movePts { get; set; }
        public int totalPts { get; set; }
    }
    public class ThinkModels : DailyModel
    {
        public UserDailyTasksPoints breath { get; set; }
        public UserDailyTasksPoints meditate { get; set; }
        public UserDailyTasksPoints smile { get; set; }
        public UserDailyTasksPoints enjoy { get; set; }
        public UserDailyTasksPoints affirmation { get; set; }
    }
    public class EatModels : DailyModel
    {
        public UserDailyTasksPoints water { get; set; }
        public UserDailyTasksPoints veggies { get; set; }
        public UserDailyTasksPoints processFood { get; set; }
        public UserDailyTasksPoints caffine { get; set; }
        public UserDailyTasksPoints breakfast { get; set; }
        public UserDailyTasksPoints snack { get; set; }
        public UserDailyTasksPoints lunch { get; set; }
        public UserDailyTasksPoints dinner { get; set; }
        public UserDailyTasksPoints alcohol { get; set; }
        public int junk { get; set; }
    }
    public class MoveModels : DailyModel
    {
        public UserDailyTasksPoints walk { get; set; }
        public UserDailyTasksPoints exercise { get; set; }
        public UserDailyTasksPoints weight { get; set; }
        public UserDailyTasksPoints stretch { get; set; }
        public UserDailyTasksPoints posture { get; set; }
    }
    public class ModalProgram
    {
        public String Title { get; set; }
        public String Text { get; set; }
        public String Level { get; set; }
        public String ImageURL { get; set; }
        public int points { get; set; }
        public int ProgramID { get; set; }
    }

}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseModelProject
{
    public class SubscribedPrograms
    {
        public int ProgramID { get; set; }

        public string Title { get; set; }

        public string Text { get; set; }

        public int Intensity { get; set; }

        public int Points { get; set; }

        public string ImageURL { get; set; }

        public bool isSubscribed { get; set; }
    }
    public class DailySubscribedGoals
    {
        public int ProgramID { get; set; }

        public int SubscribeProgramID { get; set; }

        public string Title { get; set; }

        public int ProgramTaskID { get; set; }

        public int DayID { get; set; }

        public int WeekID { get; set; }

        public int Points { get; set; }

        public string Text { get; set; }

        public bool isFinished { get; set; }
    }
}

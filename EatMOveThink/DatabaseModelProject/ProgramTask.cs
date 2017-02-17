namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ProgramTask
    {
        public ProgramTask()
        {
            SubscribeProgramTasks = new HashSet<SubscribeProgramTask>();
        }

        public int ProgramTaskID { get; set; }

        public int ProgramID { get; set; }

        public int DayID { get; set; }

        public int WeekID { get; set; }

        public int Points { get; set; }

        [Column(TypeName = "ntext")]
        [Required]
        public string Text { get; set; }

        public virtual ICollection<SubscribeProgramTask> SubscribeProgramTasks { get; set; }
    }
}

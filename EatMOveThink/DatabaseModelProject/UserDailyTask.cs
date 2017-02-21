namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class UserDailyTask
    {
        public int UserDailyTaskID { get; set; }

        public int UserID { get; set; }

        [Column(TypeName = "date")]
        public DateTime Day { get; set; }

        public int TaskID { get; set; }

        public bool Finish { get; set; }

        public virtual DailyTaskPoint DailyTaskPoint { get; set; }
    }
}

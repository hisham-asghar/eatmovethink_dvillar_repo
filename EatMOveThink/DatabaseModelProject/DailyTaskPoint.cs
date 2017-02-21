namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class DailyTaskPoint
    {
        public DailyTaskPoint()
        {
            UserDailyTasks = new HashSet<UserDailyTask>();
        }

        [Key]
        public int TaskID { get; set; }

        [Required]
        [StringLength(50)]
        public string TaskName { get; set; }

        public int Points { get; set; }

        public virtual ICollection<UserDailyTask> UserDailyTasks { get; set; }
    }
}

namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SubscribeProgram")]
    public partial class SubscribeProgram
    {
        public SubscribeProgram()
        {
            SubscribeProgramTasks = new HashSet<SubscribeProgramTask>();
        }

        public int SubscribeProgramID { get; set; }

        public int ProgramID { get; set; }

        public int UserID { get; set; }

        public bool Finish { get; set; }

        [Column(TypeName = "date")]
        public DateTime onSubscribe { get; set; }

        public virtual Program Program { get; set; }

        public virtual ICollection<SubscribeProgramTask> SubscribeProgramTasks { get; set; }
    }
}

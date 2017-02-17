namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SubscribeProgramTask")]
    public partial class SubscribeProgramTask
    {
        public int SubscribeProgramTaskID { get; set; }

        public int SubscribeProgramID { get; set; }

        public int ProgramTaskID { get; set; }

        public virtual ProgramTask ProgramTask { get; set; }

        public virtual SubscribeProgram SubscribeProgram { get; set; }
    }
}

namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("AddtionalProgram")]
    public partial class AddtionalProgram
    {
        public int AddtionalProgramId { get; set; }

        public int ProgramId { get; set; }

        public int ReferencedProgram { get; set; }
    }
}

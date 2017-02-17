namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Program")]
    public partial class Program
    {
        public Program()
        {
            SubscribePrograms = new HashSet<SubscribeProgram>();
        }

        public int ProgramID { get; set; }

        [Required]
        [StringLength(200)]
        public string Title { get; set; }

        [Column(TypeName = "ntext")]
        [Required]
        public string Text { get; set; }

        public int Intensity { get; set; }

        public int Points { get; set; }

        [StringLength(50)]
        public string ImageURL { get; set; }

        [StringLength(50)]
        public string pdf { get; set; }

        public virtual ICollection<SubscribeProgram> SubscribePrograms { get; set; }
    }
}

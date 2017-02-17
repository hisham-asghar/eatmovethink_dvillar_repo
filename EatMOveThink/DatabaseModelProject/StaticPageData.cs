namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("StaticPageData")]
    public partial class StaticPageData
    {
        [Key]
        public int PageID { get; set; }

        [Required]
        [StringLength(50)]
        public string Title { get; set; }

        [Column(TypeName = "ntext")]
        [Required]
        public string Data { get; set; }
    }
}

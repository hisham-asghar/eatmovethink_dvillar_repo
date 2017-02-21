namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UserRequest")]
    public partial class UserRequest
    {
        [Key]
        public int RequestId { get; set; }

        [Required]
        [StringLength(100)]
        public string Email { get; set; }

        [StringLength(300)]
        public string token { get; set; }

        public bool active { get; set; }

        public DateTime oncreated { get; set; }
    }
}

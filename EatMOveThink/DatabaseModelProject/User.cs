namespace DatabaseModelProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("User")]
    public partial class User
    {
        public User()
        {
            SubscribePrograms = new HashSet<SubscribeProgram>();
            UserDailyTasks = new HashSet<UserDailyTask>();
        }

        public int UserID { get; set; }

        [Required]
        [StringLength(50)]
        public string username { get; set; }

        [Required]
        [StringLength(50)]
        public string email { get; set; }

        [Column(TypeName = "date")]
        public DateTime dob { get; set; }

        [StringLength(20)]
        public string mobileph { get; set; }

        [StringLength(20)]
        public string workph { get; set; }

        [StringLength(100)]
        public string company { get; set; }

        public int gender { get; set; }

        [Required]
        [StringLength(50)]
        public string password { get; set; }

        public bool ispublic { get; set; }

        public bool? newsletter { get; set; }

        [Column(TypeName = "text")]
        [Required]
        public string info { get; set; }

        public virtual ICollection<SubscribeProgram> SubscribePrograms { get; set; }

        public virtual ICollection<UserDailyTask> UserDailyTasks { get; set; }
    }
}

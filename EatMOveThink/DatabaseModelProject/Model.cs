namespace DatabaseModelProject
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Model : DbContext
    {
        public Model()
            : base("name=Model")
        {
        }

        public virtual DbSet<DailyTaskPoint> DailyTaskPoints { get; set; }
        public virtual DbSet<Program> Programs { get; set; }
        public virtual DbSet<ProgramTask> ProgramTasks { get; set; }
        public virtual DbSet<StaticPageData> StaticPageDatas { get; set; }
        public virtual DbSet<SubscribeProgram> SubscribePrograms { get; set; }
        public virtual DbSet<SubscribeProgramTask> SubscribeProgramTasks { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UserDailyTask> UserDailyTasks { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DailyTaskPoint>()
                .Property(e => e.TaskName)
                .IsUnicode(false);

            modelBuilder.Entity<DailyTaskPoint>()
                .HasOptional(e => e.UserDailyTask)
                .WithRequired(e => e.DailyTaskPoint);

            modelBuilder.Entity<Program>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<Program>()
                .Property(e => e.ImageURL)
                .IsUnicode(false);

            modelBuilder.Entity<Program>()
                .HasMany(e => e.SubscribePrograms)
                .WithRequired(e => e.Program)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<ProgramTask>()
                .HasMany(e => e.SubscribeProgramTasks)
                .WithRequired(e => e.ProgramTask)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<StaticPageData>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<SubscribeProgram>()
                .HasMany(e => e.SubscribeProgramTasks)
                .WithRequired(e => e.SubscribeProgram)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .Property(e => e.username)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.email)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.mobileph)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.workph)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.company)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.password)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.info)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.SubscribePrograms)
                .WithRequired(e => e.User)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.UserDailyTasks)
                .WithRequired(e => e.User)
                .WillCascadeOnDelete(false);
        }
    }
}

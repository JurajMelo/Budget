using Microsoft.EntityFrameworkCore;

namespace Budget.Data.Models
{
    public class BudgetDatabaseContext : DbContext
    {
        public DbSet<DatabaseVersion> DatabaseVersion { get; set; }
        
        public BudgetDatabaseContext(DbContextOptions<BudgetDatabaseContext> options)
            : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        }
    }
}

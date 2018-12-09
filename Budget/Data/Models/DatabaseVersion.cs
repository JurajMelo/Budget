using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Budget.Data.Models
{
    public class DatabaseVersion
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        public string Application { get; set; }

        public int VersionMajor { get; set; }

        public int VersionMinor { get; set; }

        public int VersionBuild { get; set; }
    }
}

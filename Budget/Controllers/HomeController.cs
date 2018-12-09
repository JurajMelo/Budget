using System.Linq;
using Microsoft.AspNetCore.Mvc;

using Budget.Data.Models;

namespace Budget.Controllers
{
    public class HomeController : Controller
    {
        private readonly BudgetDatabaseContext db;


        public HomeController(BudgetDatabaseContext db)
        {
            this.db = db;
        }

        public IActionResult Index()
        {
            ViewData["DatabaseVersion"] = db.DatabaseVersion.Select(d => d.VersionMajor + "." + d.VersionMinor + "." + d.VersionBuild).First();

            return View();
        }
    }
}

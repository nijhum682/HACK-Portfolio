using System;

namespace project1
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session != null && Session["Username"] != null && Request.Cookies["LoggedInUser"] == null)
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Auto-initialize the database on application load/page request
            try
            {
                DatabaseHelper db = new DatabaseHelper();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Database auto-init failed: " + ex.Message);
            }
        }
    }
}

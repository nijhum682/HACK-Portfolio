using System;
using System.Data;

namespace project1
{
    public partial class signin : System.Web.UI.Page
    {
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl loginForm;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtUsername;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtPassword;
        protected global::System.Web.UI.HtmlControls.HtmlButton btnSignIn;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Handle Sign Out action
            if (Request.QueryString["action"] == "signout")
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("signin.aspx");
            }

            // If already logged in, redirect to Profile
            if (Session["Username"] != null && !IsPostBack)
            {
                Response.Redirect("profile.aspx");
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Value.Trim();
            string password = txtPassword.Value.Trim();

            if (!string.IsNullOrEmpty(username) && !string.IsNullOrEmpty(password))
            {
                DatabaseHelper db = new DatabaseHelper();
                DataTable dt = db.GetUserByCredentials(username, password);

                if (dt != null && dt.Rows.Count > 0)
                {
                    // Successful login
                    Session["Username"] = username;
                    Response.Redirect("profile.aspx");
                }
                else
                {
                    // Unsuccessful login
                    Response.Write("<script>alert('Invalid username or password!');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Please fill out all fields.');</script>");
            }
        }
    }
}

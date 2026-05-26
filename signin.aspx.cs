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
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblNotification;

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

            // Clear previous notification
            lblNotification.Visible = false;

            if (!string.IsNullOrEmpty(username) && !string.IsNullOrEmpty(password))
            {
                DatabaseHelper db = new DatabaseHelper();
                DataTable dt = db.GetUserByCredentials(username, password);

                if (dt != null && dt.Rows.Count > 0)
                {
                    // Successful login
                    Session["Username"] = username;
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowSignInSuccess", "showMessageModalAndRedirect('Successfully Signing In', 'profile.aspx');", true);
                }
                else
                {
                    // Unsuccessful login
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowSignInError", "showMessageModal('Invalid username or password!');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ShowEmptyFieldsError", "showMessageModal('Please fill out all fields.');", true);
            }
        }
    }
}

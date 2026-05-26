using System;

namespace project1
{
    public partial class signup : System.Web.UI.Page
    {
        // Manually declare HTML Server Controls
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl signupForm;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtName;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtUsername;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtPassword;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtEmail;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtRoll;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtBatch;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtDept;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtUni;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtmobile;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtReason;
        protected global::System.Web.UI.HtmlControls.HtmlInputRadioButton radUser;
        protected global::System.Web.UI.HtmlControls.HtmlInputRadioButton radAdmin;
        protected global::System.Web.UI.HtmlControls.HtmlInputCheckBox agreeCheckbox;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl signupMessage;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblNotification;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            // Extract input values from HTML server controls
            string name = txtName.Value.Trim();
            string username = txtUsername.Value.Trim();
            string password = txtPassword.Value.Trim();
            string email = txtEmail.Value.Trim();
            string roll = txtRoll.Value.Trim();
            string batch = txtBatch.Value.Trim();
            string department = txtDept.Value.Trim();
            string university = txtUni.Value.Trim();
            string mobile = txtmobile.Value.Trim();
            string reason = txtReason.Value.Trim();
            string userType = radAdmin.Checked ? "Admin" : "User";

            // Clear previous notification
            lblNotification.Visible = false;

            // Simple validation
            if (!string.IsNullOrEmpty(name) && 
                !string.IsNullOrEmpty(username) && 
                !string.IsNullOrEmpty(password) && 
                !string.IsNullOrEmpty(email) && 
                !string.IsNullOrEmpty(roll) && 
                !string.IsNullOrEmpty(batch) && 
                !string.IsNullOrEmpty(department) && 
                !string.IsNullOrEmpty(university) && 
                !string.IsNullOrEmpty(mobile) && 
                !string.IsNullOrEmpty(reason) &&
                !string.IsNullOrEmpty(userType) &&
                agreeCheckbox.Checked)
            {
                DatabaseHelper db = new DatabaseHelper();

                // Check password criteria: at least 6 characters and at least one special symbol
                bool hasSpecialChar = false;
                string specialCharacters = @"!@#$%^&*()_+-=[]{}|;':"",./<>?~`";
                foreach (char c in password)
                {
                    if (specialCharacters.IndexOf(c) >= 0)
                    {
                        hasSpecialChar = true;
                        break;
                    }
                }

                if (password.Length < 6 || !hasSpecialChar)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowPassError", "showMessageModal('Password must be at least 6 characters long and contain at least one special character!');", true);
                    return;
                }

                // Check if username already exists
                if (db.CheckUsernameTaken(username))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowUserTakenError", "showMessageModal('Username is already taken!');", true);
                    return;
                }

                // Check if roll number already exists
                if (db.CheckUsernameExists(roll))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowRollTakenError", "showMessageModal('Roll number is already registered!');", true);
                    return;
                }

                // Check if email already exists
                if (db.CheckEmailExists(email))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowEmailTakenError", "showMessageModal('Email is already registered!');", true);
                    return;
                }

                // Insert new user into MySQL
                bool success = db.InsertUser(name, username, password, email, roll, batch, department, university, mobile, reason, userType);
                if (success)
                {
                    // Clear draft cookies
                    string[] draftCookies = { "draft_txtName", "draft_txtUsername", "draft_txtEmail", "draft_txtRoll", "draft_txtBatch", "draft_txtDept", "draft_txtUni", "draft_txtmobile", "draft_txtReason", "draft_userType", "draft_agreeCheckbox" };
                    foreach (string cookieName in draftCookies)
                    {
                        if (Request.Cookies[cookieName] != null)
                        {
                            System.Web.HttpCookie c = new System.Web.HttpCookie(cookieName);
                            c.Expires = DateTime.Now.AddDays(-1);
                            Response.Cookies.Add(c);
                        }
                    }

                    // Hide the form and show the success message
                    signupForm.Visible = false;
                    signupMessage.Visible = true;
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowSignUpSuccess", "showMessageModalAndRedirect('Successfully Signing Up', 'signin.aspx');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowRegError", "showMessageModal('An error occurred during registration. Please try again.');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ShowEmptyFieldsError", "showMessageModal('Please fill out all fields and check the agreement checkbox.');", true);
            }
        }
    }
}

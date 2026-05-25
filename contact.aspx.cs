using System;

namespace project1
{
    public partial class contact : System.Web.UI.Page
    {
        // Manually declare HTML Server Controls
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl contactForm;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtName;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtEmail;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtRoll;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl txtDept;
        protected global::System.Web.UI.HtmlControls.HtmlTextArea txtMessage;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl successMessage;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Extract input values from HTML server controls
            string name = txtName.Value.Trim();
            string email = txtEmail.Value.Trim();
            string roll = txtRoll.Value.Trim();
            string department = txtDept.Value.Trim();
            string message = txtMessage.Value.Trim();

            // Simple server-side validation
            if (!string.IsNullOrEmpty(name) && 
                !string.IsNullOrEmpty(email) && 
                !string.IsNullOrEmpty(roll) && 
                !string.IsNullOrEmpty(message))
            {
                DatabaseHelper db = new DatabaseHelper();
                bool success = db.InsertContact(name, email, roll, department, message);
                if (success)
                {
                    // Hide the form and show the success message
                    contactForm.Visible = false;
                    successMessage.Visible = true;
                }
            }
        }
    }
}

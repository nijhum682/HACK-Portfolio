using System;
using System.Data;
using System.Web.UI.WebControls;

namespace project1
{
    public partial class profile : System.Web.UI.Page
    {
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlProfile;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlAnonymous;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblHeroTitle;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblAvatarInitials;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblFullName;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblUserTypeBadge;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblUsername;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblEmail;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblRoll;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblBatch;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblDept;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblUni;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblPhone;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblDateRegistered;

        protected global::System.Web.UI.HtmlControls.HtmlAnchor lnkManageDb;
        protected global::System.Web.UI.WebControls.Button btnShowAnnounce;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlAnnounceSection;
        protected global::System.Web.UI.HtmlControls.HtmlTextArea txtAnnounceMessage;
        protected global::System.Web.UI.WebControls.Button btnSendAnnounce;
        protected global::System.Web.UI.WebControls.Button btnCancelAnnounce;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlNoticeBoard;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblNoNotices;
        protected global::System.Web.UI.WebControls.Repeater rptAnnouncements;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblAnnounceNotification;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlAnnounceDeleteConfirm;
        protected global::System.Web.UI.WebControls.Button btnConfirmAnnounceDeleteYes;
        protected global::System.Web.UI.WebControls.HiddenField hfDeleteAnnounceId;
 
        // Edit Profile Controls
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlEditProfile;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editName;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editEmail;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editRoll;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editBatch;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editDept;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editUni;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editPhone;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editUsername;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editPassword;
        protected global::System.Web.UI.HtmlControls.HtmlInputControl editConfirmPassword;
        protected global::System.Web.UI.WebControls.Button btnEditProfile;
        protected global::System.Web.UI.WebControls.Button btnSaveProfile;
        protected global::System.Web.UI.WebControls.Button btnCancelEditProfile;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                // User is not logged in
                pnlProfile.Visible = false;
                pnlAnonymous.Visible = true;
            }
            else
            {
                // User is logged in
                pnlProfile.Visible = true;
                pnlAnonymous.Visible = false;

                if (!IsPostBack)
                {
                    LoadUserProfile(Session["Username"].ToString());
                    BindAnnouncements();
                }

                // Keep the notice board visible at all times
                pnlNoticeBoard.Visible = true;
            }
        }

        private void LoadUserProfile(string username)
        {
            DatabaseHelper db = new DatabaseHelper();
            DataTable dt = db.GetUserByUsername(username);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                // Name & Initials
                string name = row["Name"] != DBNull.Value ? row["Name"].ToString() : "";
                lblFullName.InnerText = name;

                string initials = "";
                string[] parts = name.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                if (parts.Length > 0)
                {
                    initials += parts[0][0];
                    if (parts.Length > 1)
                    {
                        initials += parts[parts.Length - 1][0];
                    }
                }
                lblAvatarInitials.InnerText = !string.IsNullOrEmpty(initials) ? initials.ToUpper() : "U";

                // Badges and Titles
                string userType = row["UserType"] != DBNull.Value ? row["UserType"].ToString() : "User";
                lblUserTypeBadge.InnerText = userType;
                
                string titleText = "User Profile";
                if (userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    lblUserTypeBadge.Attributes["class"] = "badge-admin";
                    lnkManageDb.Visible = true;
                    btnShowAnnounce.Visible = true;
                    titleText = "Admin Profile";
                }
                else
                {
                    lblUserTypeBadge.Attributes["class"] = "badge-user";
                    lnkManageDb.Visible = false;
                    btnShowAnnounce.Visible = false;
                }
                
                // Dynamic Hero Title Spans
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                double delay = 0.05;
                foreach (char c in titleText)
                {
                    string charStr = c == ' ' ? "&nbsp;" : c.ToString();
                    sb.AppendFormat("<span style=\"animation-delay: {0:0.00}s;\">{1}</span>", delay, charStr);
                    delay += 0.05;
                }
                lblHeroTitle.InnerHtml = sb.ToString();
                Page.Title = titleText;

                // Details
                lblUsername.InnerText = row["Username"] != DBNull.Value ? row["Username"].ToString() : "";
                lblEmail.InnerText = row["Email"] != DBNull.Value ? row["Email"].ToString() : "";
                lblRoll.InnerText = row["Roll"] != DBNull.Value ? row["Roll"].ToString() : "";
                lblBatch.InnerText = row["Batch"] != DBNull.Value ? row["Batch"].ToString() : "";
                lblDept.InnerText = row["Department"] != DBNull.Value ? row["Department"].ToString() : "";
                lblUni.InnerText = row["University"] != DBNull.Value ? row["University"].ToString() : "";
                lblPhone.InnerText = row["Phone"] != DBNull.Value ? row["Phone"].ToString() : "N/A";

                // Date
                if (row["DateRegistered"] != DBNull.Value)
                {
                    DateTime regDate = Convert.ToDateTime(row["DateRegistered"]);
                    lblDateRegistered.InnerText = regDate.ToString("MMMM dd, yyyy");
                }
                else
                {
                    lblDateRegistered.InnerText = "N/A";
                }
            }
            else
            {
                // Username in session not found in database, clean session
                Session.Clear();
                Session.Abandon();
                pnlProfile.Visible = false;
                pnlAnonymous.Visible = true;
            }
        }

        protected void btnShowAnnounce_Click(object sender, EventArgs e)
        {
            pnlAnnounceSection.Visible = !pnlAnnounceSection.Visible;
            lblAnnounceNotification.Visible = false;
        }

        protected void btnCancelAnnounce_Click(object sender, EventArgs e)
        {
            pnlAnnounceSection.Visible = false;
            txtAnnounceMessage.Value = "";
            lblAnnounceNotification.Visible = false;
        }

        protected void btnSendAnnounce_Click(object sender, EventArgs e)
        {
            lblAnnounceNotification.Visible = false;
            string message = txtAnnounceMessage.Value.Trim();
            if (!string.IsNullOrEmpty(message))
            {
                DatabaseHelper db = new DatabaseHelper();
                bool success = db.InsertAnnouncement(message, Session["Username"].ToString());
                if (success)
                {
                    txtAnnounceMessage.Value = "";
                    pnlAnnounceSection.Visible = false;
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowAnnounceSuccess", "showMessageModal('Your message is sent to all Users');", true);
                    BindAnnouncements();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowAnnounceError", "showMessageModal('Failed to post announcement. Try again.');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ShowAnnounceEmpty", "showMessageModal('Announcement message cannot be empty.');", true);
            }
        }

        protected void btnConfirmAnnounceDeleteYes_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hfDeleteAnnounceId.Value))
            {
                int announcementId = Convert.ToInt32(hfDeleteAnnounceId.Value);
                DatabaseHelper db = new DatabaseHelper();
                bool success = db.DeleteAnnouncement(announcementId);
                if (success)
                {
                    BindAnnouncements();
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowAnnounceDeleteSuccess", "showMessageModal('Announcement deleted successfully!');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowAnnounceDeleteError", "showMessageModal('Failed to delete announcement.');", true);
                }
                hfDeleteAnnounceId.Value = "";
            }
        }

        private void BindAnnouncements()
        {
            DatabaseHelper db = new DatabaseHelper();
            DataTable dt = db.GetAllAnnouncements();
            if (dt != null && dt.Rows.Count > 0)
            {
                rptAnnouncements.DataSource = dt;
                rptAnnouncements.DataBind();
                rptAnnouncements.Visible = true;
                lblNoNotices.Visible = false;
            }
            else
            {
                rptAnnouncements.Visible = false;
                lblNoNotices.Visible = true;
                lblNoNotices.InnerText = "No announcements posted yet.";
            }
        }

        public bool IsUserAdmin()
        {
            if (Session["Username"] == null) return false;
            DatabaseHelper db = new DatabaseHelper();
            DataTable dt = db.GetUserByUsername(Session["Username"].ToString());
            if (dt != null && dt.Rows.Count > 0)
            {
                string userType = dt.Rows[0]["UserType"] != DBNull.Value ? dt.Rows[0]["UserType"].ToString() : "User";
                return userType.Equals("Admin", StringComparison.OrdinalIgnoreCase);
            }
            return false;
        }



        protected void btnEditProfile_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                DatabaseHelper db = new DatabaseHelper();
                DataTable dt = db.GetUserByUsername(Session["Username"].ToString());
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    editName.Value = row["Name"].ToString();
                    editEmail.Value = row["Email"].ToString();
                    editRoll.Value = row["Roll"].ToString();
                    editBatch.Value = row["Batch"].ToString();
                    editDept.Value = row["Department"].ToString();
                    editUni.Value = row["University"].ToString();
                    editPhone.Value = row["Phone"] != DBNull.Value ? row["Phone"].ToString() : "";
                    editUsername.Value = row["Username"].ToString();

                    editPassword.Value = "";
                    editConfirmPassword.Value = "";

                    pnlProfile.Visible = false;
                    pnlEditProfile.Visible = true;
                }
            }
        }

        protected void btnCancelEditProfile_Click(object sender, EventArgs e)
        {
            pnlProfile.Visible = true;
            pnlEditProfile.Visible = false;
            if (Session["Username"] != null)
            {
                LoadUserProfile(Session["Username"].ToString());
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string name = editName.Value.Trim();
                string email = editEmail.Value.Trim();
                string roll = editRoll.Value.Trim();
                string batch = editBatch.Value.Trim();
                string department = editDept.Value.Trim();
                string university = editUni.Value.Trim();
                string phone = editPhone.Value.Trim();
                string newPassword = editPassword.Value.Trim();
                string confirmPassword = editConfirmPassword.Value.Trim();

                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(roll) || 
                    string.IsNullOrEmpty(batch) || string.IsNullOrEmpty(department) || string.IsNullOrEmpty(university))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "FieldsRequired", "showMessageModal('Please fill out all required fields.');", true);
                    return;
                }

                DatabaseHelper db = new DatabaseHelper();
                DataTable dt = db.GetUserByUsername(Session["Username"].ToString());
                if (dt != null && dt.Rows.Count > 0)
                {
                    int userId = Convert.ToInt32(dt.Rows[0]["UserID"]);
                    string currentEmail = dt.Rows[0]["Email"].ToString();
                    string currentRoll = dt.Rows[0]["Roll"].ToString();
                    string currentPassword = dt.Rows[0]["Password"].ToString();
                    string currentUserType = dt.Rows[0]["UserType"].ToString();

                    // If email changed, check uniqueness
                    if (!email.Equals(currentEmail, StringComparison.OrdinalIgnoreCase))
                    {
                        if (db.CheckEmailExists(email))
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "EmailExists", "showMessageModal('Email is already registered by another user!');", true);
                            return;
                        }
                    }

                    // If roll changed, check uniqueness
                    if (!roll.Equals(currentRoll, StringComparison.OrdinalIgnoreCase))
                    {
                        if (db.CheckUsernameExists(roll))
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "RollExists", "showMessageModal('Roll number is already registered by another user!');", true);
                            return;
                        }
                    }

                    string finalPassword = currentPassword;
                    if (!string.IsNullOrEmpty(newPassword))
                    {
                        if (newPassword != confirmPassword)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "PasswordMismatch", "showMessageModal('Passwords do not match!');", true);
                            return;
                        }

                        // Validate password complexity
                        bool hasSpecialChar = false;
                        string specialCharacters = @"!@#$%^&*()_+-=[]{}|;':"",./<>?~`";
                        foreach (char c in newPassword)
                        {
                            if (specialCharacters.IndexOf(c) >= 0)
                            {
                                hasSpecialChar = true;
                                break;
                            }
                        }

                        if (newPassword.Length < 6 || !hasSpecialChar)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "PassLengthError", "showMessageModal('Password must be at least 6 characters long and contain at least one special character!');", true);
                            return;
                        }

                        finalPassword = newPassword;
                    }

                    bool success = db.UpdateUser(userId, name, email, roll, batch, department, university, phone, currentUserType, finalPassword);
                    if (success)
                    {
                        pnlEditProfile.Visible = false;
                        pnlProfile.Visible = true;
                        LoadUserProfile(Session["Username"].ToString());
                        ClientScript.RegisterStartupScript(this.GetType(), "UpdateSuccess", "showMessageModal('Profile updated successfully!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "UpdateError", "showMessageModal('An error occurred while updating profile.');", true);
                    }
                }
            }
        }
    }
}

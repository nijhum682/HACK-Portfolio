using System;
using System.Data;

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
        protected global::System.Web.UI.WebControls.Button btnSeeNotice;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlAnnounceSection;
        protected global::System.Web.UI.HtmlControls.HtmlTextArea txtAnnounceMessage;
        protected global::System.Web.UI.WebControls.Button btnSendAnnounce;
        protected global::System.Web.UI.WebControls.Button btnCancelAnnounce;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlNoticeBoard;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblNoticeMessage;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblNoticeAuthor;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblNoticeDate;

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
                }
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
                    btnSeeNotice.Visible = false;
                    titleText = "Admin Profile";
                }
                else
                {
                    lblUserTypeBadge.Attributes["class"] = "badge-user";
                    lnkManageDb.Visible = false;
                    btnShowAnnounce.Visible = false;
                    btnSeeNotice.Visible = true;
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
            pnlNoticeBoard.Visible = false; // Hide user panel if visible
        }

        protected void btnCancelAnnounce_Click(object sender, EventArgs e)
        {
            pnlAnnounceSection.Visible = false;
            txtAnnounceMessage.Value = "";
        }

        protected void btnSendAnnounce_Click(object sender, EventArgs e)
        {
            string message = txtAnnounceMessage.Value.Trim();
            if (!string.IsNullOrEmpty(message))
            {
                DatabaseHelper db = new DatabaseHelper();
                bool success = db.InsertAnnouncement(message, Session["Username"].ToString());
                if (success)
                {
                    txtAnnounceMessage.Value = "";
                    pnlAnnounceSection.Visible = false;
                    Response.Write("<script>alert('Announcement posted successfully!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Failed to post announcement. Try again.');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Announcement message cannot be empty.');</script>");
            }
        }

        protected void btnSeeNotice_Click(object sender, EventArgs e)
        {
            pnlNoticeBoard.Visible = !pnlNoticeBoard.Visible;
            pnlAnnounceSection.Visible = false; // Hide admin panel if visible

            if (pnlNoticeBoard.Visible)
            {
                DatabaseHelper db = new DatabaseHelper();
                DataTable dt = db.GetLatestAnnouncement();
                if (dt != null && dt.Rows.Count > 0)
                {
                    lblNoticeMessage.InnerText = dt.Rows[0]["Message"].ToString();
                    lblNoticeAuthor.InnerText = dt.Rows[0]["CreatedBy"].ToString();
                    
                    if (dt.Rows[0]["DateCreated"] != DBNull.Value)
                    {
                        DateTime date = Convert.ToDateTime(dt.Rows[0]["DateCreated"]);
                        lblNoticeDate.InnerText = date.ToString("MMM dd, yyyy hh:mm tt");
                    }
                    else
                    {
                        lblNoticeDate.InnerText = "";
                    }
                }
                else
                {
                    lblNoticeMessage.InnerText = "No announcements posted yet.";
                    lblNoticeAuthor.InnerText = "System";
                    lblNoticeDate.InnerText = "";
                }
            }
        }
    }
}

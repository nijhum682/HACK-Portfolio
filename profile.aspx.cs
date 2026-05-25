using System;
using System.Data;

namespace project1
{
    public partial class profile : System.Web.UI.Page
    {
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlProfile;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlAnonymous;
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

                // Badges
                string userType = row["UserType"] != DBNull.Value ? row["UserType"].ToString() : "User";
                lblUserTypeBadge.InnerText = userType;
                if (userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    lblUserTypeBadge.Attributes["class"] = "badge-admin";
                }
                else
                {
                    lblUserTypeBadge.Attributes["class"] = "badge-user";
                }

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
    }
}

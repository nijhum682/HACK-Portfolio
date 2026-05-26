using System;
using System.Data;
using System.Web.UI.WebControls;

namespace project1
{
    public partial class managedb : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.GridView gvUsers;
        protected global::System.Web.UI.WebControls.GridView gvContacts;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl lblNotification;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlDeleteConfirm;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl pnlContactDeleteConfirm;
        protected global::System.Web.UI.WebControls.Button btnConfirmDeleteYes;
        protected global::System.Web.UI.WebControls.Button btnConfirmContactDeleteYes;
        protected global::System.Web.UI.WebControls.HiddenField hfDeleteUserId;
        protected global::System.Web.UI.WebControls.HiddenField hfDeleteContactId;
        protected global::System.Web.UI.WebControls.TextBox txtSearch;
        protected global::System.Web.UI.WebControls.Button btnSearch;
        protected global::System.Web.UI.WebControls.Button btnClearSearch;


        protected void Page_Load(object sender, EventArgs e)
        {
            // Verify user is logged in
            if (Session["Username"] == null)
            {
                Response.Redirect("signin.aspx");
                return;
            }

            // Verify user is an Admin on every request (including postbacks)
            VerifyAdminAccess();

            if (!IsPostBack)
            {
                BindUsersGrid();
                BindContactsGrid();
            }
        }

        private void VerifyAdminAccess()
        {
            DatabaseHelper db = new DatabaseHelper();
            DataTable dt = db.GetUserByUsername(Session["Username"].ToString());

            if (dt == null || dt.Rows.Count == 0)
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("signin.aspx");
                return;
            }

            string userType = dt.Rows[0]["UserType"] != DBNull.Value ? dt.Rows[0]["UserType"].ToString() : "User";
            if (!userType.Equals("Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("profile.aspx");
            }
        }

        private void BindUsersGrid()
        {
            DatabaseHelper db = new DatabaseHelper();
            DataTable dt = db.GetAllUsers();
            
            if (dt != null && !string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                string searchKey = txtSearch.Text.Trim().Replace("'", "''");
                string filterExpression = string.Format(
                    "Name LIKE '%{0}%' OR Username LIKE '%{0}%' OR Email LIKE '%{0}%' OR Roll LIKE '%{0}%' OR Batch LIKE '%{0}%' OR Department LIKE '%{0}%' OR University LIKE '%{0}%' OR Phone LIKE '%{0}%' OR UserType LIKE '%{0}%'",
                    searchKey);
                
                DataView dv = new DataView(dt);
                dv.RowFilter = filterExpression;
                gvUsers.DataSource = dv;
            }
            else
            {
                gvUsers.DataSource = dt;
            }
            
            gvUsers.DataBind();
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblNotification.Visible = false;
            gvUsers.EditIndex = e.NewEditIndex;
            BindUsersGrid();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            lblNotification.Visible = false;
            gvUsers.EditIndex = -1;
            BindUsersGrid();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            lblNotification.Visible = false;
            int rowIndex = e.RowIndex;
            int userId = Convert.ToInt32(gvUsers.DataKeys[rowIndex].Value);

            // Bounds matching columns layout (Password column removed, shifting indices)
            string name = ((TextBox)gvUsers.Rows[rowIndex].Cells[1].Controls[0]).Text.Trim();
            string username = gvUsers.Rows[rowIndex].Cells[2].Text.Trim();
            string email = ((TextBox)gvUsers.Rows[rowIndex].Cells[3].Controls[0]).Text.Trim();
            string roll = ((TextBox)gvUsers.Rows[rowIndex].Cells[4].Controls[0]).Text.Trim();
            string batch = ((TextBox)gvUsers.Rows[rowIndex].Cells[5].Controls[0]).Text.Trim();
            string department = ((TextBox)gvUsers.Rows[rowIndex].Cells[6].Controls[0]).Text.Trim();
            string university = ((TextBox)gvUsers.Rows[rowIndex].Cells[7].Controls[0]).Text.Trim();
            string phone = ((TextBox)gvUsers.Rows[rowIndex].Cells[8].Controls[0]).Text.Trim();

            DropDownList ddlUserType = (DropDownList)gvUsers.Rows[rowIndex].FindControl("ddlUserType");
            string userType = ddlUserType != null ? ddlUserType.SelectedValue : "User";

            if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(roll))
            {
                DatabaseHelper db = new DatabaseHelper();
                
                // Fetch the current password from database since it is no longer shown in the grid
                string password = "";
                DataTable dtUser = db.GetUserByUsername(username);
                if (dtUser != null && dtUser.Rows.Count > 0)
                {
                    password = dtUser.Rows[0]["Password"].ToString();
                }

                bool success = db.UpdateUser(userId, name, email, roll, batch, department, university, phone, userType, password);
                if (success)
                {
                    gvUsers.EditIndex = -1;
                    BindUsersGrid();
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowEditSuccess", "showMessageModal('Edit Successful');", true);
                }
                else
                {
                    lblNotification.InnerText = "Error updating member. Please verify unique constraint fields (Email, Roll, Username).";
                    lblNotification.Attributes["class"] = "error-message";
                    lblNotification.Visible = true;
                }
            }
            else
            {
                lblNotification.InnerText = "Please fill out Name, Email, and Roll fields.";
                lblNotification.Attributes["class"] = "error-message";
                lblNotification.Visible = true;
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Fired conditionally if default delete commands occur (we bypass this normally via return false)
        }

        protected void btnConfirmDeleteYes_Click(object sender, EventArgs e)
        {
            // Hide confirmation panel
            pnlDeleteConfirm.Style["display"] = "none";
            lblNotification.Visible = false;

            if (!string.IsNullOrEmpty(hfDeleteUserId.Value))
            {
                int userId = Convert.ToInt32(hfDeleteUserId.Value);
                DatabaseHelper db = new DatabaseHelper();

                // Prevent Admin from deleting themselves
                DataTable dt = db.GetUserByUsername(Session["Username"].ToString());
                if (dt != null && dt.Rows.Count > 0)
                {
                    int currentUserId = Convert.ToInt32(dt.Rows[0]["UserID"]);
                    if (userId == currentUserId)
                    {
                        lblNotification.InnerText = "You cannot delete your own account from the database manager!";
                        lblNotification.Attributes["class"] = "error-message";
                        lblNotification.Visible = true;
                        return;
                    }
                }

                bool success = db.DeleteUser(userId);
                if (success)
                {
                    BindUsersGrid();
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowDeleteSuccess", "showMessageModal('Delete succesfully!');", true);
                }
                else
                {
                    lblNotification.InnerText = "Failed to delete member.";
                    lblNotification.Attributes["class"] = "error-message";
                    lblNotification.Visible = true;
                }
            }
        }

        private void BindContactsGrid()
        {
            DatabaseHelper db = new DatabaseHelper();
            DataTable dt = db.GetAllContacts();
            gvContacts.DataSource = dt;
            gvContacts.DataBind();
        }

        protected void gvContacts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Handled via custom confirmation modal client-side bypass
        }

        protected void btnConfirmContactDeleteYes_Click(object sender, EventArgs e)
        {
            pnlContactDeleteConfirm.Style["display"] = "none";
            lblNotification.Visible = false;

            if (!string.IsNullOrEmpty(hfDeleteContactId.Value))
            {
                int contactId = Convert.ToInt32(hfDeleteContactId.Value);
                DatabaseHelper db = new DatabaseHelper();
                bool success = db.DeleteContact(contactId);
                if (success)
                {
                    BindContactsGrid();
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowContactDeleteSuccess", "showMessageModal('Contact message deleted successfully!');", true);
                }
                else
                {
                    lblNotification.InnerText = "Failed to delete contact message.";
                    lblNotification.Attributes["class"] = "error-message";
                    lblNotification.Visible = true;
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblNotification.Visible = false;
            gvUsers.EditIndex = -1;
            BindUsersGrid();
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            lblNotification.Visible = false;
            txtSearch.Text = "";
            gvUsers.EditIndex = -1;
            BindUsersGrid();
        }


    }
}

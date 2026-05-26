using System;
using System.Data;
using System.Web.UI.WebControls;

namespace project1
{
    public partial class managedb : System.Web.UI.Page
    {
        protected global::System.Web.UI.WebControls.GridView gvUsers;


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
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            BindUsersGrid();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            BindUsersGrid();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            int userId = Convert.ToInt32(gvUsers.DataKeys[rowIndex].Value);

            // Bounds matching columns layout
            string name = ((TextBox)gvUsers.Rows[rowIndex].Cells[1].Controls[0]).Text.Trim();
            string password = ((TextBox)gvUsers.Rows[rowIndex].Cells[3].Controls[0]).Text.Trim();
            string email = ((TextBox)gvUsers.Rows[rowIndex].Cells[4].Controls[0]).Text.Trim();
            string roll = ((TextBox)gvUsers.Rows[rowIndex].Cells[5].Controls[0]).Text.Trim();
            string batch = ((TextBox)gvUsers.Rows[rowIndex].Cells[6].Controls[0]).Text.Trim();
            string department = ((TextBox)gvUsers.Rows[rowIndex].Cells[7].Controls[0]).Text.Trim();
            string university = ((TextBox)gvUsers.Rows[rowIndex].Cells[8].Controls[0]).Text.Trim();
            string phone = ((TextBox)gvUsers.Rows[rowIndex].Cells[9].Controls[0]).Text.Trim();

            DropDownList ddlUserType = (DropDownList)gvUsers.Rows[rowIndex].FindControl("ddlUserType");
            string userType = ddlUserType != null ? ddlUserType.SelectedValue : "User";

            if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(roll))
            {
                DatabaseHelper db = new DatabaseHelper();
                bool success = db.UpdateUser(userId, name, email, roll, batch, department, university, phone, userType, password);
                if (success)
                {
                    gvUsers.EditIndex = -1;
                    BindUsersGrid();
                    Response.Write("<script>alert('Member updated successfully!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Error updating member. Please verify unique constraint fields (Email, Roll, Username).');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Please fill out Name, Email, and Roll fields.');</script>");
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            DatabaseHelper db = new DatabaseHelper();
            
            // Prevent Admin from deleting themselves
            DataTable dt = db.GetUserByUsername(Session["Username"].ToString());
            if (dt != null && dt.Rows.Count > 0)
            {
                int currentUserId = Convert.ToInt32(dt.Rows[0]["UserID"]);
                if (userId == currentUserId)
                {
                    Response.Write("<script>alert('You cannot delete your own account from the database manager!');</script>");
                    return;
                }
            }

            bool success = db.DeleteUser(userId);
            if (success)
            {
                BindUsersGrid();
                Response.Write("<script>alert('Member deleted successfully!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Failed to delete member.');</script>");
            }
        }


    }
}

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="managedb.aspx.cs" Inherits="project1.managedb" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <section id="managedb" class="hero">
            <div class="hero-content">
                <h1 class="hero-title">
                    <span style="animation-delay: 0.05s;">M</span>
                    <span style="animation-delay: 0.1s;">a</span>
                    <span style="animation-delay: 0.15s;">n</span>
                    <span style="animation-delay: 0.2s;">a</span>
                    <span style="animation-delay: 0.25s;">g</span>
                    <span style="animation-delay: 0.3s;">e</span>
                    <span style="animation-delay: 0.35s;">&nbsp;</span>
                    <span style="animation-delay: 0.4s;">D</span>
                    <span style="animation-delay: 0.45s;">a</span>
                    <span style="animation-delay: 0.5s;">t</span>
                    <span style="animation-delay: 0.55s;">a</span>
                    <span style="animation-delay: 0.6s;">b</span>
                    <span style="animation-delay: 0.65s;">a</span>
                    <span style="animation-delay: 0.7s;">s</span>
                    <span style="animation-delay: 0.75s;">e</span>
                </h1>
                <p class="hero-tagline">Club Member Database Control Panel</p>
            </div>
            <div class="hero-background">
                <div class="circle circle-1"></div>
                <div class="circle circle-2"></div>
                <div class="circle circle-3"></div>
            </div>
        </section>

        <section class="content-section" style="max-width: 1200px;">
            
            <div class="profile-card" style="max-width: 100%; overflow-x: auto; margin-bottom: 2rem;">
                <h2 style="text-align: left; margin-bottom: 1.5rem; color: var(--primary);">Registered Members</h2>
                
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="UserID"
                    OnRowEditing="gvUsers_RowEditing"
                    OnRowCancelingEdit="gvUsers_RowCancelingEdit"
                    OnRowUpdating="gvUsers_RowUpdating"
                    OnRowDeleting="gvUsers_RowDeleting"
                    CssClass="db-grid" 
                    GridLines="None" 
                    Width="100%">
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" SortExpression="UserID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="True" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Roll" HeaderText="Roll" />
                        <asp:BoundField DataField="Batch" HeaderText="Batch" />
                        <asp:BoundField DataField="Department" HeaderText="Dept" />
                        <asp:BoundField DataField="University" HeaderText="University" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" />
                        <asp:TemplateField HeaderText="Type">
                            <ItemTemplate>
                                <span class='<%# Eval("UserType").ToString().Equals("Admin", StringComparison.OrdinalIgnoreCase) ? "badge-admin" : "badge-user" %>'>
                                    <%# Eval("UserType") %>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlUserType" runat="server" SelectedValue='<%# Bind("UserType") %>' CssClass="grid-dropdown">
                                    <asp:ListItem Value="User">User</asp:ListItem>
                                    <asp:ListItem Value="Admin">Admin</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="grid-btn" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="grid-btn" 
                                    OnClientClick='<%# "showDeleteConfirm(" + Eval("UserID") + "); return false;" %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Save" CssClass="grid-btn" />
                                <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="grid-btn" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div id="lblNotification" runat="server" visible="false" ClientIDMode="Static"></div>
            </div>

            <!-- Custom Delete Confirmation Box (Placed outside profile-card to prevent layout/transform issues) -->
            <div id="pnlDeleteConfirm" runat="server" ClientIDMode="Static" style="display:none; position: fixed; top: 40%; left: 50%; transform: translate(-50%, -50%); z-index: 1000; width: 90%; max-width: 400px; background: #0a0a0a; border: 2px solid var(--accent); box-shadow: 0 10px 40px rgba(255, 0, 110, 0.4); border-radius: 10px; padding: 2rem; text-align: center;">
                <p style="margin-bottom: 1.5rem; font-weight: 600; color: #fff; font-size: 1.1rem;">Do you want to delete this record?</p>
                <div style="display: flex; gap: 1.5rem; justify-content: center;">
                    <asp:Button ID="btnConfirmDeleteYes" runat="server" Text="Yes" CssClass="grid-btn" OnClick="btnConfirmDeleteYes_Click" style="padding: 8px 25px; border-radius: 20px;" />
                    <button type="button" class="grid-btn" onclick="closeDeleteConfirm();" style="padding: 8px 25px; border-radius: 20px; border-color: var(--light); color: #fff;">No</button>
                </div>
                <asp:HiddenField ID="hfDeleteUserId" runat="server" ClientIDMode="Static" />
            </div>

            <!-- Custom Message Modal Box (Placed outside profile-card to prevent layout/transform issues) -->
            <div id="pnlMessageModal" ClientIDMode="Static" style="display:none; position: fixed; top: 40%; left: 50%; transform: translate(-50%, -50%); z-index: 1000; width: 90%; max-width: 400px; background: #0a0a0a; border: 2px solid var(--primary); box-shadow: 0 10px 40px rgba(0, 212, 255, 0.4); border-radius: 10px; padding: 2rem; text-align: center;">
                <p id="lblMessageModalText" style="margin-bottom: 0; font-weight: 600; color: #fff; font-size: 1.1rem;"></p>
            </div>
 
            <div style="text-align: center; margin-bottom: 2rem;">
                <a href="profile.aspx" class="btn btn-secondary">Back to Profile</a>
            </div>
 
            <script>
                function showDeleteConfirm(userId) {
                    // Clear any other notifications
                    const notification = document.getElementById('lblNotification');
                    if (notification) notification.style.display = 'none';
                    const msgBox = document.getElementById('pnlMessageModal');
                    if (msgBox) msgBox.style.display = 'none';
 
                    const confirmBox = document.getElementById('pnlDeleteConfirm');
                    const hiddenField = document.getElementById('hfDeleteUserId');
                    if (confirmBox && hiddenField) {
                        hiddenField.value = userId;
                        confirmBox.style.display = 'block';
                    }
                }
 
                function closeDeleteConfirm() {
                    const confirmBox = document.getElementById('pnlDeleteConfirm');
                    if (confirmBox) {
                        confirmBox.style.display = 'none';
                    }
                }

                function showMessageModal(msg) {
                    // Hide delete confirmation box if visible
                    const confirmBox = document.getElementById('pnlDeleteConfirm');
                    if (confirmBox) confirmBox.style.display = 'none';
                    const notification = document.getElementById('lblNotification');
                    if (notification) notification.style.display = 'none';

                    const msgBox = document.getElementById('pnlMessageModal');
                    const msgText = document.getElementById('lblMessageModalText');
                    if (msgBox && msgText) {
                        msgText.innerText = msg;
                        msgBox.style.display = 'block';
                        setTimeout(function() {
                            msgBox.style.display = 'none';
                        }, 2000);
                    }
                }
 
                document.addEventListener('DOMContentLoaded', function() {
                    const notification = document.getElementById('lblNotification');
                    if (notification && notification.innerText.trim() !== '') {
                        if (notification.innerText.includes('updated') || notification.innerText.includes('Successful') || notification.innerText.includes('Edit') || notification.innerText.includes('Delete')) {
                            setTimeout(function() {
                                notification.style.display = 'none';
                            }, 2000);
                        }
                    }
                });
            </script>
 
        </section>
</asp:Content>

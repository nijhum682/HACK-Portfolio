<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="managedb.aspx.cs" Inherits="project1.managedb" MasterPageFile="~/Site.Master" %>
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
                        <asp:BoundField DataField="Password" HeaderText="Password" />
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
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" 
                            ButtonType="Button" 
                            EditText="Edit" UpdateText="Save" CancelText="Cancel" DeleteText="Delete"
                            ControlStyle-CssClass="grid-btn" />
                    </Columns>
                </asp:GridView>
            </div>


            <div style="text-align: center; margin-bottom: 2rem;">
                <a href="profile.aspx" class="btn btn-secondary">Back to Profile</a>
            </div>

        </section>
</asp:Content>

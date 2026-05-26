<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="project1.profile" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <section id="profile" class="hero">
            <div class="hero-content">
                <h1 class="hero-title">
                    <span style="animation-delay: 0.05s;">U</span>
                    <span style="animation-delay: 0.1s;">s</span>
                    <span style="animation-delay: 0.15s;">e</span>
                    <span style="animation-delay: 0.2s;">r</span>
                    <span style="animation-delay: 0.25s;">&nbsp;</span>
                    <span style="animation-delay: 0.3s;">P</span>
                    <span style="animation-delay: 0.35s;">r</span>
                    <span style="animation-delay: 0.4s;">o</span>
                    <span style="animation-delay: 0.45s;">f</span>
                    <span style="animation-delay: 0.5s;">i</span>
                    <span style="animation-delay: 0.55s;">l</span>
                    <span style="animation-delay: 0.6s;">e</span>
                </h1>
                <p class="hero-tagline">Manage Your Club Account</p>
            </div>
            <div class="hero-background">
                <div class="circle circle-1"></div>
                <div class="circle circle-2"></div>
                <div class="circle circle-3"></div>
            </div>
        </section>

        <section class="content-section">
            
            <!-- When the user is logged in -->
            <div id="pnlProfile" runat="server" class="profile-card">
                <div class="profile-header">
                    <div class="avatar-container">
                        <div class="avatar-circle">
                            <span id="lblAvatarInitials" runat="server">JD</span>
                        </div>
                    </div>
                    <div class="profile-title-group">
                        <h2 id="lblFullName" runat="server" class="profile-name">John Doe</h2>
                        <span id="lblUserTypeBadge" runat="server" class="badge-user">User</span>
                    </div>
                </div>

                <div class="profile-details-grid">
                    <div class="detail-item">
                        <label>Username</label>
                        <span id="lblUsername" runat="server">johndoe</span>
                    </div>
                    <div class="detail-item">
                        <label>Email Address</label>
                        <span id="lblEmail" runat="server">johndoe@example.com</span>
                    </div>
                    <div class="detail-item">
                        <label>Roll Number</label>
                        <span id="lblRoll" runat="server">1803001</span>
                    </div>
                    <div class="detail-item">
                        <label>Batch</label>
                        <span id="lblBatch" runat="server">2k18</span>
                    </div>
                    <div class="detail-item">
                        <label>Department</label>
                        <span id="lblDept" runat="server">CSE</span>
                    </div>
                    <div class="detail-item">
                        <label>University</label>
                        <span id="lblUni" runat="server">KUET</span>
                    </div>
                    <div class="detail-item">
                        <label>Phone Number</label>
                        <span id="lblPhone" runat="server">+8801234567890</span>
                    </div>
                    <div class="detail-item">
                        <label>Member Since</label>
                        <span id="lblDateRegistered" runat="server">May 25, 2026</span>
                    </div>
                </div>
                
                <!-- Admin Announcement Section -->
                <div id="pnlAnnounceSection" runat="server" class="admin-announce-section" visible="false" style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.1);">
                    <h3 style="color: var(--primary); margin-bottom: 1rem; text-align: left;">Post New Announcement</h3>
                    <div class="custom-form" style="max-width: 100%;">
                        <textarea id="txtAnnounceMessage" runat="server" rows="4" placeholder="Type your notice or announcement here... (sent to all club users)" required style="width: 100%; box-sizing: border-box; padding: 1rem; border: 1px solid #1a1a1a; background: rgba(255, 255, 255, 0.05); color: #fff; border-radius: 5px; font-family: inherit; font-size: 1rem; margin-bottom: 1rem;"></textarea>
                        <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                            <asp:Button ID="btnSendAnnounce" runat="server" Text="Send Announcement" CssClass="btn btn-primary" OnClick="btnSendAnnounce_Click" style="padding: 10px 25px; border-radius: 50px; font-size: 0.95rem;" />
                            <asp:Button ID="btnCancelAnnounce" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancelAnnounce_Click" style="padding: 10px 25px; border-radius: 50px; font-size: 0.95rem;" UseSubmitBehavior="false" />
                        </div>
                    </div>
                </div>

                <!-- User Notice Board Section -->
                <div id="pnlNoticeBoard" runat="server" class="user-notice-section" visible="false" style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.1);">
                    <h3 style="color: var(--primary); margin-bottom: 1rem; text-align: left;">Announcement from Admin</h3>
                    <div style="background: rgba(0, 212, 255, 0.05); border: 1px solid rgba(0, 212, 255, 0.2); padding: 1.5rem; border-radius: 10px; text-align: left;">
                        <p id="lblNoticeMessage" runat="server" style="font-size: 1.1rem; color: #fff; line-height: 1.6; margin-bottom: 1rem; white-space: pre-wrap;">No announcements posted yet.</p>
                        <div style="display: flex; justify-content: space-between; font-size: 0.85rem; color: var(--light);">
                            <span>Posted by: <strong id="lblNoticeAuthor" runat="server" style="color: var(--primary);">Admin</strong></span>
                            <span id="lblNoticeDate" runat="server">May 25, 2026</span>
                        </div>
                    </div>
                </div>

                <div class="profile-actions" style="display: flex; gap: 1rem; justify-content: flex-end; flex-wrap: wrap; margin-top: 2rem;">
                    <a href="managedb.aspx" id="lnkManageDb" runat="server" class="btn btn-primary" visible="false" style="padding: 10px 25px; border-radius: 50px; font-size: 0.95rem;">Manage Database</a>
                    <asp:Button ID="btnShowAnnounce" runat="server" Text="Announce" CssClass="btn btn-secondary" OnClick="btnShowAnnounce_Click" Visible="false" style="padding: 10px 25px; border-radius: 50px; font-size: 0.95rem;" />
                    <asp:Button ID="btnSeeNotice" runat="server" Text="See Notice" CssClass="btn btn-secondary" OnClick="btnSeeNotice_Click" Visible="false" style="padding: 10px 25px; border-radius: 50px; font-size: 0.95rem;" />
                    <a href="signin.aspx?action=signout" class="btn btn-secondary" style="padding: 10px 25px; border-radius: 50px; font-size: 0.95rem;">Sign Out</a>
                </div>
            </div>

            <!-- When the user is NOT logged in -->
            <div id="pnlAnonymous" runat="server" class="profile-card anonymous-card" visible="false">
                <div class="anonymous-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                </div>
                <h2>Access Denied</h2>
                <p style="margin-bottom: 2rem; color: var(--light);">You must be signed in to view your profile details.</p>
                <div class="profile-actions" style="display: flex; gap: 1.5rem; justify-content: center;">
                    <a href="signin.aspx" class="btn btn-primary">Sign In</a>
                    <a href="signup.aspx" class="btn btn-secondary">Create Account</a>
                </div>
            </div>

        </section>
</asp:Content>

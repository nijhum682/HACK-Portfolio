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

                <div class="profile-actions">
                    <a href="signin.aspx?action=signout" class="btn btn-secondary">Sign Out</a>
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

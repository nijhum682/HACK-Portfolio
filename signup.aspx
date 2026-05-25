<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="project1.signup" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <section id="signup" class="hero">
            <div class="hero-content">
                                <h1 class="hero-title">
                    <span style="animation-delay: 0.05s;">J</span>
                    <span style="animation-delay: 0.1s;">o</span>
                    <span style="animation-delay: 0.15s;">i</span>
                    <span style="animation-delay: 0.2s;">n</span>
                    <span style="animation-delay: 0.25s;">&nbsp;</span>
                    <span style="animation-delay: 0.3s;">H</span>
                    <span style="animation-delay: 0.35s;">A</span>
                    <span style="animation-delay: 0.4s;">C</span>
                    <span style="animation-delay: 0.45s;">K</span>
                </h1>
                <p class="hero-tagline">Be Part of Our Community</p>
            </div>
            <div class="hero-background">
                <div class="circle circle-1"></div>
                <div class="circle circle-2"></div>
                <div class="circle circle-3"></div>
            </div>
        </section>

        <section class="content-section">
            <h2>Sign Up for Updates</h2>
            <div id="signupForm" class="custom-form" runat="server">
                <input type="text" id="txtName" runat="server" placeholder="Your name" required>
                <input type="email" id="txtEmail" runat="server" placeholder="Your email" required>
                <input type="text" id="txtRoll" runat="server" placeholder="Your Roll" required>
                <input type="text" id="txtBatch" runat="server" placeholder="Batch" required>
                <input type="text" id="txtDept" runat="server" placeholder="Department" required>
                <input type="text" id="txtUni" runat="server" placeholder="University" required>
                <input type="text" id="txtmobile" runat="server" placeholder="Phone Number" required>
                <input type="text" id="txtReason" runat="server" placeholder="Why are you joining with HACK?" required>
                <label class="checkbox-label">
                    <input type="checkbox" id="agreeCheckbox" runat="server" required>
                    <span>I must agree with the rules and policies of this club ensuring all the information that I have provided is correct.</span>
                </label>
                <button type="submit" id="btnSignUp" runat="server" onserverclick="btnSignUp_Click">Sign Up</button>
            </div>
            <div id="signupMessage" class="success-message" runat="server" visible="false">
                Successfully signed up! 
            </div>
        </section>
    
</asp:Content>

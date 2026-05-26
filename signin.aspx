<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="project1.signin" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <section id="signin" class="hero">
            <div class="hero-content">
                <h1 class="hero-title">
                    <span style="animation-delay: 0.05s;">S</span>
                    <span style="animation-delay: 0.1s;">i</span>
                    <span style="animation-delay: 0.15s;">g</span>
                    <span style="animation-delay: 0.2s;">n</span>
                    <span style="animation-delay: 0.25s;">&nbsp;</span>
                    <span style="animation-delay: 0.3s;">I</span>
                    <span style="animation-delay: 0.35s;">n</span>
                </h1>
                <p class="hero-tagline">Access Your Account</p>
            </div>
            <div class="hero-background">
                <div class="circle circle-1"></div>
                <div class="circle circle-2"></div>
                <div class="circle circle-3"></div>
            </div>
        </section>

        <section class="content-section">
            <h2>Welcome Back</h2>
            <div id="loginForm" class="custom-form" runat="server">
                <input type="text" id="txtUsername" runat="server" placeholder="Username" required ClientIDMode="Static">
                <div class="password-container">
                    <input type="password" id="txtPassword" runat="server" placeholder="Password" required ClientIDMode="Static">
                    <button type="button" id="btnTogglePassword" class="password-toggle">
                        <svg class="eye-open-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                        <svg class="eye-close-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display:none;">
                            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                            <line x1="1" y1="1" x2="23" y2="23"></line>
                        </svg>
                    </button>
                </div>
                <button type="submit" id="btnSignIn" runat="server" onserverclick="btnSignIn_Click" ClientIDMode="Static">Sign In</button>
                <div id="lblNotification" runat="server" visible="false"></div>
                <div style="margin-top: 1.5rem; text-align: center;">
                    <p style="color: var(--light); font-size: 1rem;">
                        Don't have an Account? <a href="signup.aspx" style="color: var(--primary); text-decoration: none; font-weight: 600;">Sign Up</a>
                    </p>
                </div>
            </div>
            <!-- Custom Message Modal Box -->
            <div id="pnlMessageModal" ClientIDMode="Static" style="display:none; position: fixed; top: 40%; left: 50%; transform: translate(-50%, -50%); z-index: 1000; width: 90%; max-width: 400px; background: #0a0a0a; border: 2px solid var(--primary); box-shadow: 0 10px 40px rgba(0, 212, 255, 0.4); border-radius: 10px; padding: 2rem; text-align: center;">
                <p id="lblMessageModalText" style="margin-bottom: 0; font-weight: 600; color: #fff; font-size: 1.1rem;"></p>
            </div>
        </section>

        <script>
            function showMessageModal(msg) {
                const msgBox = document.getElementById('pnlMessageModal');
                const msgText = document.getElementById('lblMessageModalText');
                if (msgBox && msgText) {
                    msgBox.style.borderColor = 'var(--accent)';
                    msgBox.style.boxShadow = '0 10px 40px rgba(255, 0, 110, 0.4)';
                    msgText.innerText = msg;
                    msgBox.style.display = 'block';
                    setTimeout(function() {
                        msgBox.style.display = 'none';
                    }, 5000);
                }
            }

            function showMessageModalAndRedirect(msg, redirectUrl) {
                const msgBox = document.getElementById('pnlMessageModal');
                const msgText = document.getElementById('lblMessageModalText');
                if (msgBox && msgText) {
                    msgBox.style.borderColor = 'var(--primary)';
                    msgBox.style.boxShadow = '0 10px 40px rgba(0, 212, 255, 0.4)';
                    msgText.innerText = msg;
                    msgBox.style.display = 'block';
                    setTimeout(function() {
                        msgBox.style.display = 'none';
                        window.location.href = redirectUrl;
                    }, 2000);
                } else {
                    window.location.href = redirectUrl;
                }
            }

            document.addEventListener('DOMContentLoaded', () => {
                const toggleBtn = document.getElementById('btnTogglePassword');
                const passwordInput = document.getElementById('txtPassword');
                const eyeOpen = toggleBtn.querySelector('.eye-open-icon');
                const eyeClose = toggleBtn.querySelector('.eye-close-icon');

                // Toggle password visibility
                toggleBtn.addEventListener('click', (e) => {
                    e.preventDefault(); // Prevent postback/form submission
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    
                    if (type === 'password') {
                        eyeOpen.style.display = 'block';
                        eyeClose.style.display = 'none';
                    } else {
                        eyeOpen.style.display = 'none';
                        eyeClose.style.display = 'block';
                    }
                });
            });
        </script>
</asp:Content>

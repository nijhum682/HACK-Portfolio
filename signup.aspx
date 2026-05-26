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
                <p style="color: var(--light); font-size: 1.1rem; margin-top: 0.5rem; position: relative; z-index: 10;">
                    Already have an account? <a href="signin.aspx" style="color: var(--primary); text-decoration: none; font-weight: 600;">Sign In</a>
                </p>
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
                <input type="text" id="txtName" runat="server" placeholder="Your name" required ClientIDMode="Static">
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
                <input type="email" id="txtEmail" runat="server" placeholder="Your email" required ClientIDMode="Static">
                <input type="text" id="txtRoll" runat="server" placeholder="Your Roll" required ClientIDMode="Static">
                <input type="text" id="txtBatch" runat="server" placeholder="Batch" required ClientIDMode="Static">
                <input type="text" id="txtDept" runat="server" placeholder="Department" required ClientIDMode="Static">
                <input type="text" id="txtUni" runat="server" placeholder="University" required ClientIDMode="Static">
                <input type="text" id="txtmobile" runat="server" placeholder="Phone Number" required ClientIDMode="Static">
                <input type="text" id="txtReason" runat="server" placeholder="Why are you joining with HACK?" required ClientIDMode="Static">
                <div class="radio-group">
                    <label class="form-question">User Type</label>
                    <div class="radio-options">
                        <label class="radio-option-label">
                            <input type="radio" id="radUser" name="userTypeGroup" value="User" runat="server" checked ClientIDMode="Static">
                            <span>User</span>
                        </label>
                        <label class="radio-option-label">
                            <input type="radio" id="radAdmin" name="userTypeGroup" value="Admin" runat="server" ClientIDMode="Static">
                            <span>Admin</span>
                        </label>
                    </div>
                </div>
                <label class="checkbox-label">
                    <input type="checkbox" id="agreeCheckbox" runat="server" required ClientIDMode="Static">
                    <span>I must agree with the rules and policies of this club ensuring all the information that I have provided is correct.</span>
                </label>
                <button type="submit" id="btnSignUp" runat="server" onserverclick="btnSignUp_Click" ClientIDMode="Static">Sign Up</button>
                <div id="lblNotification" runat="server" visible="false" ClientIDMode="Static"></div>
            </div>
            <div id="signupMessage" class="success-message" runat="server" visible="false">
                Successfully signed up! 
            </div>

            <!-- Custom Message Modal Box -->
            <div id="pnlMessageModal" ClientIDMode="Static" style="display:none; position: fixed; top: 40%; left: 50%; transform: translate(-50%, -50%); z-index: 1000; width: 90%; max-width: 400px; background: #0a0a0a; border: 2px solid var(--accent); box-shadow: 0 10px 40px rgba(255, 0, 110, 0.4); border-radius: 10px; padding: 2rem; text-align: center;">
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
                    }, 2000);
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

            // Cookie helpers
            function getCookie(name) {
                const value = `; ${document.cookie}`;
                const parts = value.split(`; ${name}=`);
                if (parts.length === 2) return decodeURIComponent(parts.pop().split(';').shift());
                return null;
            }

            function setCookie(name, value) {
                document.cookie = `${name}=${encodeURIComponent(value)}; path=/; SameSite=Lax`;
            }

            document.addEventListener('DOMContentLoaded', () => {
                const toggleBtn = document.getElementById('btnTogglePassword');
                const passwordInput = document.getElementById('txtPassword');
                const btnSignUp = document.getElementById('btnSignUp');
                const form = document.getElementById('form1');
                const eyeOpen = toggleBtn.querySelector('.eye-open-icon');
                const eyeClose = toggleBtn.querySelector('.eye-close-icon');

                // Restore draft values from cookies
                const textFields = ['txtName', 'txtUsername', 'txtEmail', 'txtRoll', 'txtBatch', 'txtDept', 'txtUni', 'txtmobile', 'txtReason'];
                textFields.forEach(id => {
                    const el = document.getElementById(id);
                    if (el) {
                        const val = getCookie('draft_' + id);
                        if (val !== null) el.value = val;
                        el.addEventListener('input', () => {
                            setCookie('draft_' + id, el.value);
                        });
                    }
                });

                const radUser = document.getElementById('radUser');
                const radAdmin = document.getElementById('radAdmin');
                if (radUser && radAdmin) {
                    const savedUserType = getCookie('draft_userType');
                    if (savedUserType === 'Admin') {
                        radAdmin.checked = true;
                    } else if (savedUserType === 'User') {
                        radUser.checked = true;
                    }
                    radUser.addEventListener('change', () => {
                        if (radUser.checked) setCookie('draft_userType', 'User');
                    });
                    radAdmin.addEventListener('change', () => {
                        if (radAdmin.checked) setCookie('draft_userType', 'Admin');
                    });
                }

                const agreeCheckbox = document.getElementById('agreeCheckbox');
                if (agreeCheckbox) {
                    const savedAgree = getCookie('draft_agreeCheckbox');
                    if (savedAgree === 'true') {
                        agreeCheckbox.checked = true;
                    }
                    agreeCheckbox.addEventListener('change', () => {
                        setCookie('draft_agreeCheckbox', agreeCheckbox.checked ? 'true' : 'false');
                    });
                }

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

                // Helper validation function
                const validatePassword = () => {
                    const pwd = passwordInput.value;
                    const specialCharRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~`]/;
                    if (pwd.length < 6 || !specialCharRegex.test(pwd)) {
                        showMessageModal("Password must be at least 6 characters long and contain at least one special character!");
                        return false;
                    }
                    return true;
                };

                // Validate on click
                if (btnSignUp) {
                    btnSignUp.addEventListener('click', (e) => {
                        if (!validatePassword()) {
                            e.preventDefault();
                            return false;
                        }
                    });
                }

                // Validate on form submit (e.g. Enter key)
                if (form) {
                    form.addEventListener('submit', (e) => {
                        // Only validate password if the submit was triggered by signupForm or btnSignUp
                        // In ASP.NET, there is a single page form, so let's verify if the password input exists and is visible
                        if (passwordInput && passwordInput.offsetParent !== null) {
                            if (!validatePassword()) {
                                    e.preventDefault();
                                    return false;
                            }
                        }
                    });
                }
            });
        </script>
</asp:Content>

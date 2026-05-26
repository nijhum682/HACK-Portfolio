<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="project1.contact" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <section id="contact" class="hero">
            <div class="hero-content">
                                <h1 class="hero-title">
                    <span style="animation-delay: 0.05s;">C</span>
                    <span style="animation-delay: 0.1s;">o</span>
                    <span style="animation-delay: 0.15s;">n</span>
                    <span style="animation-delay: 0.2s;">t</span>
                    <span style="animation-delay: 0.25s;">a</span>
                    <span style="animation-delay: 0.3s;">c</span>
                    <span style="animation-delay: 0.35s;">t</span>
                    <span style="animation-delay: 0.4s;">&nbsp;</span>
                    <span style="animation-delay: 0.45s;">U</span>
                    <span style="animation-delay: 0.5s;">s</span>
                </h1>
                <p class="hero-tagline">Get in Touch with HACK</p>
            </div>
            <div class="hero-background">
                <div class="circle circle-1"></div>
                <div class="circle circle-2"></div>
                <div class="circle circle-3"></div>
            </div>
        </section>

        <section class="content-section">
            <h2>Contact Form</h2>
            <div id="contactForm" class="custom-form" runat="server">
                <input type="text" id="txtName" runat="server" placeholder="Your name" required ClientIDMode="Static">
                <input type="email" id="txtEmail" runat="server" placeholder="Your email" required ClientIDMode="Static">
                <input type="text" id="txtRoll" runat="server" placeholder="Your Roll" required ClientIDMode="Static">
                <input type="text" id="txtDept" runat="server" placeholder="Department" ClientIDMode="Static">
                <textarea id="txtMessage" runat="server" rows="4" placeholder="Your message" required ClientIDMode="Static"></textarea>
                <button type="submit" id="btnSubmit" runat="server" onserverclick="btnSubmit_Click" ClientIDMode="Static">Send Message</button>
            </div>
            <div id="successMessage" class="success-message" runat="server" visible="false">
                Your message is sent to our admin 
            </div>
        </section>

        <section class="content-section">
            <h2>Quick Contact</h2>
            <div class="quick-contacts-container">
                <div class="quick-contact">
                    <img src="img/Tahmid.jpeg" alt="Tahmid Hossain Mahin" class="quick-contact-image">
                    <h3>Tahmid Chowdhury Mahin</h3>
                    <p><strong>Gmail:</strong> tahmidchowdhury109@gmail.com</p>
                    <p><strong>Contact No:</strong> 01770776155</p>
                    <p>Computer Science and Engineering, KUET</p>
                </div>
                <div class="quick-contact">
                    <img src="img/Hirobi.jpeg" alt="Hirobi Chakma" class="quick-contact-image">
                    <h3>Hirobi Chakma</h3>
                    <p><strong>Gmail:</strong> hirobichakma121@gmail.com</p>
                    <p><strong>Contact No:</strong> 01533397576</p>
                    <p>Computer Science and Engineering, KUET</p>
                </div>
                <div class="quick-contact">
                    <img src="img/Shahriar.jpeg" alt="Munem Shahriar Nijhum" class="quick-contact-image">
                    <h3>Munem Shahriar Nijhum</h3>
                    <p><strong>Gmail:</strong> munemshahriar526@gmail.com</p>
                    <p><strong>Contact No:</strong> 01753027682</p>
                    <p>Computer Science and Engineering, KUET</p>
                </div>
                <div class="quick-contact">
                    <img src="img/Sadid.jpeg" alt="Saleh Sadid Mir" class="quick-contact-image">
                    <h3>Saleh Sadid Mir</h3>
                    <p><strong>Gmail:</strong> salehsadid24@gmail.com</p>
                    <p><strong>Contact No:</strong> 01401001606</p>
                    <p>Computer Science and Engineering, KUET</p>
                </div>
            </div>
        </section>
        
        <script>
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
                const fields = ['txtName', 'txtEmail', 'txtRoll', 'txtDept', 'txtMessage'];
                fields.forEach(id => {
                    const el = document.getElementById(id);
                    if (el) {
                        const val = getCookie('draft_contact_' + id);
                        if (val !== null) el.value = val;
                        el.addEventListener('input', () => {
                            setCookie('draft_contact_' + id, el.value);
                        });
                    }
                });
            });
        </script>
    
</asp:Content>

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
            <div id="contactForm" class="custom-form">
                <input type="text" placeholder="Your name" required>
                <input type="email" placeholder="Your email" required>
                <input type="text" placeholder="Your Roll" required>
                <input type="text" placeholder="Department">
                <textarea rows="4" placeholder="Your message" required></textarea>
                <button type="submit">Send Message</button>
            </div>
            <div id="successMessage" class="success-message" style="display: none;">
                Your message is sent to our admin ✅
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
    
</asp:Content>

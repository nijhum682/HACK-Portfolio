<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="resources.aspx.cs" Inherits="project1.resources" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <section id="resources" class="hero">
            <div class="hero-content">
                                <h1 class="hero-title">
                    <div class="word">
                        <span style="animation-delay: 0.05s;">R</span><span style="animation-delay: 0.1s;">e</span><span style="animation-delay: 0.15s;">s</span><span style="animation-delay: 0.2s;">o</span><span style="animation-delay: 0.25s;">u</span><span style="animation-delay: 0.3s;">r</span><span style="animation-delay: 0.35s;">c</span><span style="animation-delay: 0.4s;">e</span><span style="animation-delay: 0.45s;">s</span>
                    </div>
                </h1>
                <p class="hero-tagline">Tools and Materials for Learning</p>
            </div>
            <div class="hero-background">
                <div class="circle circle-1"></div>
                <div class="circle circle-2"></div>
                <div class="circle circle-3"></div>
            </div>
        </section>

        <section class="content-section">
            <h2>Learning Resources</h2>
            
        <div class="resource-tabs" style="display: flex; gap: 1rem; justify-content: center; margin-bottom: 2rem;">
            <button class="btn btn-secondary" id="btn-books" onclick="showBooks(); return false;" style="background: #00d4ff; color: #0a0a0a; cursor: pointer; border: none; padding: 0.5rem 2rem; border-radius: 25px; font-weight: 600;">Books</button>
            <button class="btn btn-secondary" id="btn-tutorials" onclick="showTutorials(); return false;" style="background: transparent; color: #fff; cursor: pointer; border: 2px solid #00d4ff; padding: 0.5rem 2rem; border-radius: 25px; font-weight: 600;">Tutorials</button>
        </div>

        <div id="books-section" class="resource-content">
            <div class="books-list" style="display: flex; flex-direction: column; gap: 1rem; text-align: left; max-width: 600px; margin: 1.5rem auto;">
                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">The Art of Electronics</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By Paul Horowitz and Winfield Hill. The gold standard and a comprehensive reference for hardware design and electronics.</p>
                    <a href="https://archive.org/details/artofelectronics0000horo" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>
                
                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Practical Electronics for Inventors</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By Paul Scherz and Simon Monk. A thorough, highly visual guide perfect for enthusiasts, tinkerers, and hardware inventors.</p>
                    <a href="https://archive.org/details/practicalelectro0000sche" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Make: Electronics</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By Charles Platt. An excellent "learning by discovery" book designed for beginners looking to get their hands dirty with hardware immediately.</p>
                    <a href="https://archive.org/details/makeelectronics00plat" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>
            </div>
        </div>

        <div id="tutorials-section" class="resource-content" style="display: none;">
            <div class="video-list" style="display: flex; flex-wrap: wrap; gap: 1.5rem; justify-content: center; margin-top: 1.5rem;">

                <div class="video-card" style="background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2); width: 100%; max-width: 400px; text-align: left;">
                    <div class="video-wrapper" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 4px; margin-bottom: 1rem;">
                        <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/lNFrFuzBGyo" title="কীবোর্ড শর্টকাট" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </div>
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">কীবোর্ড শর্টকাট</h4>
                    <p style="font-size: 0.9rem; color: #ddd;">Learn essential keyboard shortcuts to accelerate your workflow.</p>
                </div>

                <div class="video-card" style="background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2); width: 100%; max-width: 400px; text-align: left;">
                    <div class="video-wrapper" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 4px; margin-bottom: 1rem;">
                        <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/72md10-BBG0" title="HACK Hardware Tutorial" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </div>
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">HACK Hardware Tutorial</h4>
                    <p style="font-size: 0.9rem; color: #ddd;">Learn about hardware and project building from the HACK team.</p>
                </div>

            </div>
        </div>

        <script>
            function showBooks() {
                document.getElementById('books-section').style.display = 'block';
                document.getElementById('tutorials-section').style.display = 'none';

                document.getElementById('btn-books').style.background = '#00d4ff';
                document.getElementById('btn-books').style.color = '#0a0a0a';
                document.getElementById('btn-books').style.border = 'none';

                document.getElementById('btn-tutorials').style.background = 'transparent';
                document.getElementById('btn-tutorials').style.color = '#fff';
                document.getElementById('btn-tutorials').style.border = '2px solid #00d4ff';
            }

            function showTutorials() {
                document.getElementById('books-section').style.display = 'none';
                document.getElementById('tutorials-section').style.display = 'block';

                document.getElementById('btn-tutorials').style.background = '#00d4ff';
                document.getElementById('btn-tutorials').style.color = '#0a0a0a';
                document.getElementById('btn-tutorials').style.border = 'none';

                document.getElementById('btn-books').style.background = 'transparent';
                document.getElementById('btn-books').style.color = '#fff';
                document.getElementById('btn-books').style.border = '2px solid #00d4ff';
            }
        </script>
        </section>
    
</asp:Content>

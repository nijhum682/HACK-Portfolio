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
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Digital Logic &amp; Computer Design</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By M. Morris Mano. A foundational textbook covering digital systems, binary logic gates, boolean algebra, and computer design principles.</p>
                    <a href="https://drive.google.com/file/d/1ZNgWByS8qJ_sZ3rbXeCbtLFIU5jWLfyx/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Computer Organization and Architecture Designing for Performance</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By William Stallings (8th Edition). A comprehensive guide detailing the layout, instruction sets, pipelining, and performance-driven design of computer architectures.</p>
                    <a href="https://drive.google.com/file/d/1ADkDxEbm1kQY_P6RwzbwJ_Sfy44EXpPy/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Alternating Current Circuits</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By Russell M. Kerchner and George F. Corcoran. An essential reference covering the theory and practical calculations of alternating current circuit analysis.</p>
                    <a href="https://drive.google.com/file/d/19ggAJQTiFXySBmTSN_IfziBSl8eHuL3X/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Textbook of Electrical Technology (Volume II)</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By B.L. Theraja and A.K. Theraja. Provides detailed multi-colored coverage of AC/DC machines, transformers, and electrical tech theories.</p>
                    <a href="https://drive.google.com/file/d/1ccpE0QffCXo3XHM8ExJJhqCR6uO6Nw5d/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Introductory Circuit Analysis</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By Robert L. Boylestad (11th Edition). The industry-leading textbook introducing fundamentals of DC/AC circuit network analysis and theorems.</p>
                    <a href="https://drive.google.com/file/d/1aTN76aHd0CrMDKVPTq1iDemEyhGpcT5J/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Electrical Machines</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By S. K. Bhattacharya. Explains the operating principles, characteristics, and applications of generators, motors, and transformers.</p>
                    <a href="https://drive.google.com/file/d/1mdvDHy5RMeZIDQ0NXHYqQTNzUqq-a-vo/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Fundamentals of Electric Circuits</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By Charles K. Alexander and Matthew N. O. Sadiku (5th Edition). A highly accessible introduction to linear circuit design, analysis methods, and applications.</p>
                    <a href="https://drive.google.com/file/d/1qpbuezmSsg4XmbBYD9nJ-G-dCpsW89Qg/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Principles of Electronics</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By V.K. Mehta and Rohit Mehta. A textbook with clear conceptual explanations of basic electronics, semiconductor devices, and circuits.</p>
                    <a href="https://drive.google.com/file/d/1C_Xc3G-xwSpMuP-7n5A8A-GI2Netxg_W/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Digital Electronics: Principles and Integrated Circuits (Chapters 5 &amp; 9)</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By Anil K. Maini. Specialized chapters focusing on logic gate circuits, logic families, and Programmable Logic Devices (PLDs).</p>
                    <a href="https://drive.google.com/file/d/1QYbox1PCIdVpHEyFxgFlLE1ZMgyk3P3M/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Digital Electronics - Question Bank &amp; Practice</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">A compilation of practice questions, problem sets, and solutions designed to test and refine understanding of digital electronic circuits.</p>
                    <a href="https://drive.google.com/file/d/1P35eFJFqCMr4pY5twIVfRbGlkcRIKkYz/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>

                <div class="book-card" style="background: rgba(255, 255, 255, 0.05); padding: 1.5rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2);">
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Principles of Electronics (Alternative Source)</h4>
                    <p style="font-size: 0.95rem; margin-bottom: 1rem; line-height: 1.5;">By V.K. Mehta and Rohit Mehta. An alternative digital copy of the widely used Principles of Electronics textbook.</p>
                    <a href="https://drive.google.com/file/d/16Cy5JhDs4voAHDOAC2EaBtkCbfGjalPD/view?usp=drive_link" target="_blank" class="btn btn-secondary" style="font-size: 0.85rem; padding: 0.5rem 1rem;">View Book Online</a>
                </div>
            </div>
        </div>

        <div id="tutorials-section" class="resource-content" style="display: none;">
            <div class="video-list" style="display: flex; flex-wrap: wrap; gap: 1.5rem; justify-content: center; margin-top: 1.5rem;">

                <div class="video-card" style="background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2); width: 100%; max-width: 400px; text-align: left;">
    <div class="video-wrapper" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 4px; margin-bottom: 1rem;">
        <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/72md10-BBG0" title="HACK Hardware Tutorial" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">HACK Hardware Tutorial</h4>
    <p style="font-size: 0.9rem; color: #ddd;">Learn about hardware and project building from the HACK team.</p>
</div>

               <div class="video-card" style="background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2); width: 100%; max-width: 400px; text-align: left;">
     <div class="video-wrapper" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 4px; margin-bottom: 1rem;">
         <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/4dT63l0RknQ" title="Arduino Library Setup in Proteus" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
     </div>
     <h4 style="color: var(--primary); margin-bottom: 0.5rem;">HACK Hardware Tutorial</h4>
     <p style="font-size: 0.9rem; color: #ddd;">Learn about hardware and project building from the HACK team.</p>
 </div>  

                 <div class="video-card" style="background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2); width: 100%; max-width: 400px; text-align: left;">
     <div class="video-wrapper" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 4px; margin-bottom: 1rem;">
         <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/GUT74Mu8xzY" title="Simple LED Project" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
     </div>
     <h4 style="color: var(--primary); margin-bottom: 0.5rem;">HACK Hardware Tutorial</h4>
     <p style="font-size: 0.9rem; color: #ddd;">Learn about hardware and project building from the HACK team.</p>
 </div>

                <div class="video-card" style="background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2); width: 100%; max-width: 400px; text-align: left;">
                    <div class="video-wrapper" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 4px; margin-bottom: 1rem;">
                        <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/lNFrFuzBGyo" title="Basic Input Output Operations" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </div>
                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Keyboard Shortcuts</h4>
                    <p style="font-size: 0.9rem; color: #ddd;">Learn essential keyboard shortcuts to accelerate your workflow.</p>
                </div>

                <div class="video-card" style="background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 8px; border: 1px solid rgba(0, 255, 204, 0.2); width: 100%; max-width: 400px; text-align: left;">
                    <div class="video-wrapper" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 4px; margin-bottom: 1rem;">
                        <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" src="https://www.youtube.com/embed/iNa6NW8YiK0" title="LFR from HACK" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
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

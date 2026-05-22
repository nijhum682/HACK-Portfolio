$dir = "c:\web_ass\project1"
Set-Location $dir

$oldScript = @"
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const filterBtns = document.querySelectorAll('.filter-btn');
        const teamMembers = document.querySelectorAll('.team-member');
        const contentSections = document.querySelectorAll('.content-section:not(#designation-filter-section)');

        filterBtns.forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                
                filterBtns.forEach(b => b.classList.remove('filter-btn-active'));
                btn.classList.add('filter-btn-active');
                
                const filterValue = btn.getAttribute('data-designation');
                
                if (filterValue === 'all') {
                    contentSections.forEach(section => section.style.display = 'block');
                    teamMembers.forEach(member => member.style.display = 'block');
                } else {
                    contentSections.forEach(section => section.style.display = 'none');
                    teamMembers.forEach(member => {
                        if (member.getAttribute('data-designation') === filterValue) {
                            member.style.display = 'block';
                            member.closest('.content-section').style.display = 'block';
                        } else {
                            member.style.display = 'none';
                        }
                    });
                }
            });
        });
    });
</script>
"@

$newScript = @"
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const filterBtns = document.querySelectorAll('.filter-btn');
        const teamMembers = document.querySelectorAll('.team-member');
        const contentSections = document.querySelectorAll('.content-section:not(#designation-filter-section)');

        filterBtns.forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                
                filterBtns.forEach(b => b.classList.remove('filter-btn-active'));
                btn.classList.add('filter-btn-active');
                
                const filterValue = btn.getAttribute('data-designation');
                let targetSection = null;
                
                if (filterValue === 'all') {
                    contentSections.forEach(section => section.style.display = 'block');
                    teamMembers.forEach(member => member.style.display = 'block');
                    // Scroll to the first team section, offset slightly for fixed header
                    targetSection = contentSections[0];
                } else {
                    contentSections.forEach(section => section.style.display = 'none');
                    teamMembers.forEach(member => {
                        if (member.getAttribute('data-designation') === filterValue) {
                            member.style.display = 'block';
                            let parentSection = member.closest('.content-section');
                            parentSection.style.display = 'block';
                            if (!targetSection) targetSection = parentSection;
                        } else {
                            member.style.display = 'none';
                        }
                    });
                }

                // Scroll to target
                if (targetSection) {
                    const headerOffset = 100; // Account for sticky header
                    const elementPosition = targetSection.getBoundingClientRect().top;
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                    
                    window.scrollTo({
                         top: offsetPosition,
                         behavior: "smooth"
                    });
                }
            });
        });
    });
</script>
"@

Get-ChildItem -Filter "team*.aspx" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    
    if ($content.Contains($oldScript)) {
        $content = $content.Replace($oldScript, $newScript)
        Set-Content -Path $_.FullName -Value $content
        Write-Host "Updated scrolling logic in $($_.Name)"
    }
}

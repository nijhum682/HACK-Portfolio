$dir = "c:\web_ass\project1"
Set-Location $dir

$scriptContent = @"
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
</asp:Content>
"@

Get-ChildItem -Filter "team*.aspx" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw

    # Prevent button submit
    $content = $content -replace '<button class="filter-btn"', '<button type="button" class="filter-btn"'
    
    # Check if script already exists to avoid duplication
    if (-not ($content -match 'const filterBtns = document\.querySelectorAll')) {
        # Inject script before </asp:Content>
        $content = $content -replace '</asp:Content>', $scriptContent
        Set-Content -Path $_.FullName -Value $content
        Write-Host "Fixed $($_.Name)"
    }
}

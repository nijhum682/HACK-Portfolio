$dir = "c:\web_ass\project1"
Set-Location $dir

Get-ChildItem -Filter "*.aspx" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw

    # Extract Page Directive
    if ($content -match '(?i)(<%@ Page [^>]+ %>)') {
        $pageDirective = $matches[1]
        if (-not ($pageDirective -match 'MasterPageFile')) {
            $pageDirective = $pageDirective -replace '%>', 'MasterPageFile="~/Site.Master" %>'
        }
    } else {
        return
    }

    # Extract Main Content
    if ($content -match '(?is)<main>(.*?)</main>') {
        $mainContent = $matches[1]
        
        # Build new content
        $newContent = "$pageDirective`r`n<asp:Content ID=`"Content1`" ContentPlaceHolderID=`"MainContent`" runat=`"server`">`r`n$mainContent`r`n</asp:Content>"
        
        Set-Content -Path $_.FullName -Value $newContent
        Write-Host "Refactored $($_.Name)"
    } else {
        Write-Host "No <main> tag found in $($_.Name)"
    }
}

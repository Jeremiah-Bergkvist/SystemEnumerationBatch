Add-Type -AssemblyName System.Windows.Forms

## Event handler
function SortListView
{
    param([parameter(Position=0)][UInt32]$Column)
 
    $Numeric = $true # determine how to sort
 
    # if the user clicked the same column that was clicked last time, reverse its sort order. otherwise, reset for normal ascending sort
    if($Script:LastColumnClicked -eq $Column)
    {
        $Script:LastColumnAscending = -not $Script:LastColumnAscending
    }
    else
    {
        $Script:LastColumnAscending = $true
    }
    $Script:LastColumnClicked = $Column
    $ListItems = @(@(@())) # three-dimensional array; column 1 indexes the other columns, column 2 is the value to be sorted on, and column 3 is the System.Windows.Forms.ListViewItem object
 
    foreach($ListItem in $ListView.Items)
    {
        # if all items are numeric, can use a numeric sort
        if($Numeric -ne $false) # nothing can set this back to true, so don't process unnecessarily
        {
            try
            {
                $Test = [Double]$ListItem.SubItems[[int]$Column].Text
            }
            catch
            {
                $Numeric = $false # a non-numeric item was found, so sort will occur as a string
            }
        }
        $ListItems += ,@($ListItem.SubItems[[int]$Column].Text,$ListItem)
    }
 
    # create the expression that will be evaluated for sorting
    $EvalExpression = {
        if($Numeric)
        { 
            return [Double]$_[0]
        }
        else
        {
            return [String]$_[0]
        }
    }
 
    # all information is gathered; perform the sort
    $ListItems = $ListItems | Sort-Object -Property @{Expression=$EvalExpression; Ascending=$Script:LastColumnAscending}
 
    ## the list is sorted; display it in the listview
    $ListView.BeginUpdate()
    $ListView.Items.Clear()
    foreach($ListItem in $ListItems)
    {
        $ListView.Items.Add($ListItem[1])
    }
    $ListView.EndUpdate()
}

[xml]$XAML  = @"
 <Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
xmlns:local="clr-namespace:Enumeration"
Title="PowerShell Enumeration Utility" Height="300"  Width="190">

<Grid>
    <StackPanel HorizontalAlignment="Left" VerticalAlignment="Top" Margin="10,10,10,10" Width="150">
        <Button  x:Name="Accounts_btn" Content="Accounts"/>
        <Label />
        <Button  x:Name="Services_btn" Content="Services"/>
        <Label />
        <Button  x:Name="Processes_btn" Content="Processes"/>
        <Label />
        <Button  x:Name="Drives_btn" Content="Drives"/>
        <Label />
        <Button  x:Name="NetAdapters_btn" Content="Net Adapters"/>
        <Label />
        <Button  x:Name="NetTCPConnections_btn" Content="TCP Connections"/>
        <Label />
        <Button  x:Name="NetUDPEndpoints_btn" Content="UDP Endpoints"/>
        <Label />
        <Button  x:Name="Hotfixess_btn" Content="Installed Hotfixes"/>
    </StackPanel>
</Grid>
</Window>
"@

#Add DisplayMemberBindings for all columns
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$Window=[Windows.Markup.XamlReader]::Load($reader)

#region Events
$Accounts_btn = $Window.FindName("Accounts_btn")
$Accounts_btn.Add_Click({
    Get-WmiObject -Class Win32_UserAccount | Out-GridView -PassThru
}) 
$Services_btn = $Window.FindName("Services_btn")
$Services_btn.Add_Click({
    Get-Service | Out-GridView -PassThru
})
$Processes_btn = $Window.FindName("Processes_btn")
$Processes_btn.Add_Click({
    Get-Process | Out-GridView -PassThru
})
$Drives_btn = $Window.FindName("Drives_btn")
$Drives_btn.Add_Click({
    Get-Service | Out-GridView
})
$NetAdapters_btn = $Window.FindName("NetAdapters_btn")
$NetAdapters_btn.Add_Click({
    Get-NetAdapter | Out-GridView -PassThru
})
$NetTCPConnections_btn = $Window.FindName("NetTCPConnections_btn")
$NetTCPConnections_btn.Add_Click({
    Get-NetTCPConnection | Out-GridView -PassThru
})
$NetUDPEndpoints_btn = $Window.FindName("NetUDPEndpoints_btn")
$NetUDPEndpoints_btn.Add_Click({
    Get-NetUDPEndpoint | Out-GridView -PassThru
})
$Hotfixess_btn = $Window.FindName("Hotfixess_btn")
$Hotfixess_btn.Add_Click({
    Get-HotFix | Out-GridView -PassThru
})

$Null = $Window.ShowDialog()

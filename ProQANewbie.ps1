$Search = Read-Host 'What is the CAD ID?'
$Server = "<SQL Server>"
$Database = "<SQL Database>"
$Query = "SELECT TOP 1000 * FROM <SQL Table> WHERE Field LIKE '%" + $Search + "%' ORDER BY ID DESC"
$QueryTimeout = 120
$ConnectionTimeout = 30
$SQLConnection = New-Object System.Data.SqlClient.SQLConnection
$SQLConnection.ConnectionString = "Server={0}; Database={1}; Integrated Security=False; User ID = <User>; Password = <Password>; Connect Timeout = {2}" -f $Server, $Database, $ConnectionTimeout
$SQLConnection.Open()
$SQLCommand = New-Object system.Data.SqlClient.SqlCommand($Query,$SQLConnection)
$SQLCommand.CommandTimeout = $QueryTimeout
$DataSet = New-Object system.Data.DataSet
$DataAdapter = New-Object system.Data.SqlClient.SqlDataAdapter($SQLCommand)
[void]$DataAdapter.fill($DataSet)
$SQLConnection.Close()
$DataSet.Tables | Out-Host
Write-Host
pause
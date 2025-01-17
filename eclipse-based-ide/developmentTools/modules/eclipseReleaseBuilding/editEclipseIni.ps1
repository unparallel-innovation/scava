param (
    [Parameter(Mandatory=$true)][string]$Path
)

(Get-Content $Path) | ForEach-Object {
    if( $_ -eq "-Dosgi.instance.area.default=@user.home/eclipse-workspace" ) {
        "-Dosgi.instance.area.default=./eclipse-workspace";
    }else{
        $_;
    }
} | Set-Content $Path;
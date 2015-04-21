HA$PBExportHeader$n_cst_platform_privileges.sru
forward
global type n_cst_platform_privileges from nonvisualobject
end type
type shellexecuteinfo from structure within n_cst_platform_privileges
end type
type sididentifierauthority from structure within n_cst_platform_privileges
end type
type tokenelevation from structure within n_cst_platform_privileges
end type
type sidandattributes from structure within n_cst_platform_privileges
end type
type tokenmandatorylabel from structure within n_cst_platform_privileges
end type
type longreturn from structure within n_cst_platform_privileges
end type
end forward

type shellexecuteinfo from structure
	long		cbsize
	long		fmask
	long		hwnd
	string		lpverb
	string		lpfile
	string		lpparameters
	string		lpdirectory
	long		nshow
	long		hinstapp
	long		lpidlist
	string		lpclass
	long		hkeyclass
	long		dwhotkey
	long		hicon
	long		hprocess
end type

type sididentifierauthority from structure
	byte		value[]
end type

type tokenelevation from structure
	long		tokeniselevated
end type

type sidandattributes from structure
	unsignedlong		sid
	unsignedlong		attributes
end type

type tokenmandatorylabel from structure
	sidandattributes		label
end type

type longreturn from structure
	long		returnvalue
end type

global type n_cst_platform_privileges from nonvisualobject
end type
global n_cst_platform_privileges n_cst_platform_privileges

type prototypes
function boolean IsUserAnAdmin ( ) library "shell32.dll"
function ulong GetModuleFileName (ulong hinstModule, ref string lpszPath, ulong cchPath ) library "KERNEL32.DLL" alias for "GetModuleFileNameW"
function long ShellExecuteEx(ref shellexecuteinfo lpExecInfo) library "shell32.dll" alias for "ShellExecuteExW"
function long GetLastError() library "kernel32" alias for "GetLastError"

// Handle this call with Byte array or pointer
function boolean CheckTokenMembership(ulong TokenHandle, ulong SidToCheck, ref boolean IsMember) library "advapi32.dll"
function boolean CheckTokenMembership(ulong TokenHandle, byte SidToCheck[], ref boolean IsMember) library "advapi32.dll"

function ulong AllocateAndInitializeSid(sididentifierauthority pIdentifierAuthority, long nSubAuthorityCount, ulong nSubAuthority0, ulong nSubAuthority1, ulong nSubAuthority2, ulong nSubAuthority3, ulong nSubAuthority4, ulong nSubAuthority5, ulong nSubAuthority6, ulong nSubAuthority7, ref ulong lpPSid) LIBRARY "advapi32.dll"
subroutine FreeSid (ulong pSid ) LIBRARY "advapi32.dll"
function long OpenProcessToken (long ProcessHandle, long DesiredAccess, ref long TokenHandle) Library "advapi32.dll"
function long GetCurrentProcess () Library "kernel32"

// GetTokenInformation could have different argument types 
function boolean GetTokenElevation(long TokenHandle,long TokenInformationClass,ref tokenelevation tTokenInformation,ulong TokenInformationLength, ref ulong ReturnLength) library "advapi32.dll" alias for "GetTokenInformation";
function boolean GetTokenElevationType(long TokenHandle,long TokenInformationClass,ref long tElevationType,ulong TokenInformationLength, ref ulong ReturnLength) library "advapi32.dll" alias for "GetTokenInformation";
function boolean GetTokenLinkedToken(long TokenHandle,long TokenInformationClass,ref long tTokenHandle,ulong TokenInformationLength, ref ulong ReturnLength) library "advapi32.dll" alias for "GetTokenInformation";
function boolean GetTokenIntegrityLevel(long TokenHandle,long TokenInformationClass,ref tokenmandatorylabel tLabel,ulong TokenInformationLength, ref ulong ReturnLength) library "advapi32.dll" alias for "GetTokenInformation";

function ulong DuplicateToken(long TokenHandle,long ImpersonationLevel,ref long DuplicateTokenHandle) LIBRARY "advapi32.dll"
function boolean CreateWellKnownSid(long WellKnownSidType, long DomainSid, ref byte pSid[],ref ulong cbSid) library "advapi32.dll"
function ulong GetSidSubAuthority(ulong sid, ulong subAuthorityIndex) library "advapi32.dll"
subroutine CopyMemoryLong (ref ulong destination, long source, ulong size) LIBRARY "kernel32" ALIAS FOR "RtlMoveMemory"
Function long LocalFree (long MemHandle) library "kernel32.dll"


end prototypes
type variables
protected:

// http://www.pinvoke.net/default.aspx/user32/ShowState.html
constant long SW_NORMAL = 1

// http://www.pinvoke.net/default.aspx/Constants/WINERROR.html
constant long ERROR_CANCELLED = 1223;

// http://www.pinvoke.net/default.aspx/advapi32/AllocateAndInitializeSid.html
constant long NtSecurityAuthority = 5;
constant long BuiltInDomainRid = 32
constant long DomainAliasRidAdmins = 544
constant long AuthenticatedUser = 11;

// http://www.pinvoke.net/default.aspx/Constants/WINNT.html
constant ulong TOKEN_DUPLICATE = 2;
constant ulong TOKEN_QUERY = 8;

// http://www.pinvoke.net/default.aspx/Enums/TOKEN_INFORMATION_CLASS.html
constant long TokenElevationType = 18
constant long TokenLinkedToken = 19
constant long TokenElevation = 20
constant long TokenIntegrityLevel = 25

// http://www.pinvoke.net/default.aspx/Enums/TOKEN_ELEVATION_TYPE.html
constant long TokenElevationTypeDefault = 1
constant long TokenElevationTypeFull = 2
constant long TokenElevationTypeLimited = 3

// http://www.pinvoke.net/default.aspx/Enums/SECURITY_IMPERSONATION_LEVEL.html
constant long SecurityAnonymous = 0
constant long SecurityIdentification = 1
constant long SecurityImpersonation = 2
constant long SecurityDelegation = 3

// http://www.pinvoke.net/default.aspx/Enums/WELL_KNOWN_SID_TYPE.html
constant long WinBuiltinAdministratorsSid = 26

// http://www.pinvoke.net/default.aspx/Constants/SECURITY_MANDATORY.html
constant long SECURITY_MANDATORY_UNTRUSTED_RID = 0;
constant long SECURITY_MANDATORY_LOW_RID = 4096;
constant long SECURITY_MANDATORY_MEDIUM_RID = 8192;
constant long SECURITY_MANDATORY_HIGH_RID = 12288;
constant long SECURITY_MANDATORY_SYSTEM_RID = 16384;
 
end variables
forward prototypes
protected function string of_getcurrentexe ()
public function boolean of_isuserinadmingroup ()
public function boolean of_isrunasadmin ()
public function boolean of_isprocesselevated ()
public function boolean of_isuseranadmin ()
public function long of_runwithhighprivileges (string as_path)
public function long of_selfelevation ()
public function string of_getprocessintegritylevel ()
end prototypes

protected function string of_getcurrentexe ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is to get the current EXE.
// Thanks to: http://www.rgagnon.com/pbdetails/pb-0265.html
// 
// Author: 
// B.Kemner, 20.04.2015 
//

ClassDefinition  lcd

String ls_fullpath 
ulong lul_handle, lul_length = 512

IF handle(getapplication()) = 0 THEN
    // running from the IDE
    lcd=getapplication().classdefinition
    ls_fullpath = lcd.libraryname
ELSE
    // running from EXE
    lul_handle = handle( getapplication() )
    ls_fullpath=space(lul_length) 
    GetModuleFilename( lul_handle, ls_fullpath, lul_length )
END IF

return ls_fullpath
end function

public function boolean of_isuserinadmingroup ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Checks if the current user is in admin group
// 
// Author: 
// B.Kemner, 20.04.2015 
// 
//	Return:
//		NULL if an error occured
//

long			ll_process, ll_token, ll_tokenType, ll_tokenChecked, lul_tokenToCheck, ll_duplicatedToken, ll_null
ulong			lul_elevationTypeSize, lul_size = 4, lul_plinkedSize, lul_sidSize = 68
boolean		lb_isInGroup, lb_null
byte			lbta_adminsid[]
environment	lnv_environment

setNull(lb_null)
setNull(ll_null)

if GetEnvironment(ref lnv_environment) < 0 then
	return lb_null
end if

ll_process = GetCurrentProcess()
if OpenProcessToken(ll_process, TOKEN_QUERY + TOKEN_DUPLICATE, ref ll_token) < 0 then
	return lb_null
end if

if lnv_environment.OSMajorRevision >= 6 then
	if not GetTokenElevationType(ll_token, TokenElevationType, ref ll_tokenType, lul_size, ref lul_elevationTypeSize) then
		return lb_null
	end if
	
	if ll_tokenType = TokenElevationTypeLimited then
		if not GetTokenLinkedToken(ll_token, TokenLinkedToken, ref lul_tokenToCheck, lul_size, ref lul_plinkedSize) then
			return lb_null
		end if
	end if	
end if

if lul_tokenToCheck = 0 then
	DuplicateToken(ll_token, SecurityIdentification, ref lul_tokenToCheck)
end if

lbta_adminsid[lul_sidSize] = 0

if not CreateWellKnownSid(WinBuiltinAdministratorsSid, ll_null, ref lbta_adminsid, ref lul_sidSize) then
	return lb_null
end if

if not CheckTokenMembership(lul_tokenToCheck, lbta_adminsid, ref lb_isInGroup) then
	return lb_null
end if

return lb_isInGroup = true
end function

public function boolean of_isrunasadmin ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Checks if the application was started by "Run as Admin"
// 
// Author: 
// B.Kemner, 20.04.2015 
//
//	Return:
//		NULL if an error occured
//

ulong							lul_AuthenticatedUsersSid
ulong							lul_handle
boolean						lb_runAsAdmin, lb_null
sididentifierauthority 	lstr_ntAuhtority

setNull(lb_null)

lstr_ntAuhtority.value[1] = 0
lstr_ntAuhtority.value[2] = 0
lstr_ntAuhtority.value[3] = 0
lstr_ntAuhtority.value[4] = 0
lstr_ntAuhtority.value[5] = 0
lstr_ntAuhtority.value[6] = NtSecurityAuthority

lul_AuthenticatedUsersSid = 0

AllocateAndInitializeSid(ref lstr_ntAuhtority, 2, BuiltInDomainRid, DomainAliasRidAdmins, 0, 0, 0, 0, 0, 0, ref lul_AuthenticatedUsersSid)

setNull(lul_handle)

if not CheckTokenMembership(lul_handle, lul_AuthenticatedUsersSid, ref lb_runAsAdmin) then
	return lb_null
end if

FreeSid(lul_AuthenticatedUsersSid)

return lb_runAsAdmin = true
end function

public function boolean of_isprocesselevated ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Checks if the process was elevated
// 
// Author: 
// B.Kemner, 20.04.2015 
//
//	Return:
//		NULL if an error occured
// 

long				ll_process, ll_token
ulong				lul_tokenElevationSize = 4, lul_size
boolean 			lb_null
tokenelevation	lstr_tokenelevation

setNull(lb_null)

ll_process = GetCurrentProcess ( )
if OpenProcessToken(ll_process, TOKEN_QUERY, ref ll_token) < 0 then
	return lb_null
end if

if not GetTokenElevation(ll_token, TokenElevation, ref lstr_tokenelevation, lul_tokenElevationSize, ref lul_size) then
	return lb_null
end if

return lstr_tokenelevation.TokenIsElevated = 1
end function

public function boolean of_isuseranadmin ();/////////////////////////////////////////////////////////////////////////////
// Description: 
// This is a simple wrapper method to check if the application runs as admin
// 
// Author: 
// B.Kemner, 21.04.2015 
// 

return IsUserAnAdmin ( )
end function

public function long of_runwithhighprivileges (string as_path);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Checks if the current user is in admin group
// 
// Author: 
// B.Kemner, 20.04.2015 
// 
//	Return:
//		0  = Is already elevated
//		-1	= Unknown error
//		-2 = Canceled by user
//		1 = OK
//

shellexecuteinfo lstr_shellexecuteinfo

if this.of_isRunAsAdmin() then
	return 0
end if

lstr_shellexecuteinfo.cbsize = 60
lstr_shellexecuteinfo.lpVerb = "runas"
lstr_shellexecuteinfo.lpFile = as_path
lstr_shellexecuteinfo.hwnd = handle(this)
lstr_shellexecuteinfo.nShow = SW_NORMAL

if ShellExecuteEx(ref lstr_shellexecuteinfo) <> 1 then
	if GetLastError() = ERROR_CANCELLED then
		return -2
	else
		return -1
	end if
end if

return 1
end function

public function long of_selfelevation ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Run current EXE with High Privileges
// 
// Author: 
// B.Kemner, 20.04.2015 
// 

return of_runWithHighPrivileges(of_getCurrentExe ( ) )

end function

public function string of_getprocessintegritylevel ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is to retrieve the integrity level
// 
// Author: 
// B.Kemner, 21.04.2015 
// 
//	Return:
//		untrusted
//		low
//		medium
//		high
//		system
//		unknown
//
//		OR null if an error occured
//		

string					ls_null
long 						ll_process, ll_token
ulong						lul_level
ulong 					lul_size = 0, lul_integritySize = 72, lul_sidSize = 68, lul_zero = 0, lul_levelSize = 4
ulong						lul_levelPointer, lul_labelPtr, lul_cbSize
tokenmandatorylabel	lstr_label, lstr_empty

setNull(ls_null)

ll_process = GetCurrentProcess ( )
if OpenProcessToken(ll_process, TOKEN_QUERY, ref ll_token) < 0 then
	return ls_null
end if

// Initialize Structure
lstr_label.label.sid = 0
lstr_label.label.attributes = 0

if GetTokenIntegrityLevel(ll_token, TokenIntegrityLevel, ref lstr_label, lul_integritySize, ref lul_cbSize) = false then
	LocalFree(ll_token)
	return ls_null
end if

lul_levelPointer = GetSidSubAuthority(lstr_label.label.sid, 0)
CopyMemoryLong(ref lul_level, lul_levelPointer, 4)

LocalFree(ll_token)

choose case lul_level
	case SECURITY_MANDATORY_UNTRUSTED_RID
		return "untrusted"
	case SECURITY_MANDATORY_LOW_RID
		return "low"
	case SECURITY_MANDATORY_MEDIUM_RID
		return "medium"
	case SECURITY_MANDATORY_HIGH_RID
		return "high"
	case SECURITY_MANDATORY_SYSTEM_RID
		return "system"
end choose

return "unknown"
end function

on n_cst_platform_privileges.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_platform_privileges.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


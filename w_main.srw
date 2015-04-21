HA$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_isanadmin from statictext within w_main
end type
type st_4 from statictext within w_main
end type
type st_5 from statictext within w_main
end type
type st_integritylevel from statictext within w_main
end type
type st_isprocesselevated from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_3 from statictext within w_main
end type
type st_isrunasadmin from statictext within w_main
end type
type st_userinadmingroup from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type p_shield from picture within w_main
end type
type cb_1 from commandbutton within w_main
end type
type luid from structure within w_main
end type
type token_privileges from structure within w_main
end type
type luid_and_attributes from structure within w_main
end type
end forward

type luid from structure
	unsignedlong		lowpart
	unsignedlong		highpart
end type

type token_privileges from structure
	long		privilegecount
	luid_and_attributes		privileges
end type

type luid_and_attributes from structure
	luid		pluid
	long		attributes
end type

global type w_main from window
integer width = 1083
integer height = 956
boolean titlebar = true
string title = "Self-Elevating"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_isanadmin st_isanadmin
st_4 st_4
st_5 st_5
st_integritylevel st_integritylevel
st_isprocesselevated st_isprocesselevated
st_2 st_2
st_3 st_3
st_isrunasadmin st_isrunasadmin
st_userinadmingroup st_userinadmingroup
st_1 st_1
p_shield p_shield
cb_1 cb_1
end type
global w_main w_main

type prototypes

end prototypes

type variables
protected:

n_cst_platform_privileges	inv_privileges
end variables

on w_main.create
this.st_isanadmin=create st_isanadmin
this.st_4=create st_4
this.st_5=create st_5
this.st_integritylevel=create st_integritylevel
this.st_isprocesselevated=create st_isprocesselevated
this.st_2=create st_2
this.st_3=create st_3
this.st_isrunasadmin=create st_isrunasadmin
this.st_userinadmingroup=create st_userinadmingroup
this.st_1=create st_1
this.p_shield=create p_shield
this.cb_1=create cb_1
this.Control[]={this.st_isanadmin,&
this.st_4,&
this.st_5,&
this.st_integritylevel,&
this.st_isprocesselevated,&
this.st_2,&
this.st_3,&
this.st_isrunasadmin,&
this.st_userinadmingroup,&
this.st_1,&
this.p_shield,&
this.cb_1}
end on

on w_main.destroy
destroy(this.st_isanadmin)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_integritylevel)
destroy(this.st_isprocesselevated)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_isrunasadmin)
destroy(this.st_userinadmingroup)
destroy(this.st_1)
destroy(this.p_shield)
destroy(this.cb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Open
// 
// Author: 
// B.Kemner, 20.04.2015 
//

inv_privileges = create n_cst_platform_privileges

st_userinadmingroup.text = string(inv_privileges.of_isuserinadmingroup( ))
st_isrunasadmin.text = string(inv_privileges.of_isRunAsAdmin( ))
st_isprocesselevated.text = string(inv_privileges.of_isprocesselevated( ))
st_integritylevel.text = inv_privileges.of_getprocessintegritylevel( )
st_isanadmin.text = string(inv_privileges.of_isUserAnAdmin())

if inv_privileges.of_isRunAsAdmin() then
	p_shield.visible = false
end if

return 0


end event

event close;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Close
// 
// Author: 
// B.Kemner, 20.04.2015 
//

destroy inv_privileges

return 0


end event

type st_isanadmin from statictext within w_main
integer x = 585
integer y = 416
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_main
integer x = 37
integer y = 416
integer width = 571
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "IsAnAdmin:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_main
integer x = 37
integer y = 320
integer width = 571
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Integrity Level:"
boolean focusrectangle = false
end type

type st_integritylevel from statictext within w_main
integer x = 585
integer y = 320
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_isprocesselevated from statictext within w_main
integer x = 585
integer y = 224
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 37
integer y = 224
integer width = 571
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "IsProcessElevated:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer x = 37
integer y = 128
integer width = 571
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "IsRunAsAdmin:"
boolean focusrectangle = false
end type

type st_isrunasadmin from statictext within w_main
integer x = 585
integer y = 128
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_userinadmingroup from statictext within w_main
integer x = 658
integer y = 32
integer width = 329
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 37
integer y = 32
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "IsUserInAdminGroup:"
boolean focusrectangle = false
end type

type p_shield from picture within w_main
integer x = 73
integer y = 640
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "C:\Users\Siron\PowerBuilder\Privileges\Shield.png"
boolean focusrectangle = false
end type

event clicked;cb_1.triggerEvent(clicked!)
end event

type cb_1 from commandbutton within w_main
integer x = 37
integer y = 608
integer width = 951
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Self-Elevating"
boolean flatstyle = true
end type

event clicked;if inv_privileges.of_selfelevation( ) = 1 then
	halt
end if
end event


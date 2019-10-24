$PBExportHeader$w_address_detail.srw
forward
global type w_address_detail from window
end type
type cb_close from commandbutton within w_address_detail
end type
type dw_detail from datawindow within w_address_detail
end type
end forward

global type w_address_detail from window
boolean visible = false
integer width = 4014
integer height = 1728
boolean border = false
windowtype windowtype = child!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
dw_detail dw_detail
end type
global w_address_detail w_address_detail

on w_address_detail.create
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.Control[]={this.cb_close,&
this.dw_detail}
end on

on w_address_detail.destroy
destroy(this.cb_close)
destroy(this.dw_detail)
end on

event resize;dw_detail.width = workspacewidth()
dw_detail.height = workspaceheight()
cb_close.x = workspacewidth() - cb_close.width - 4
end event

event close;gw_main.of_close_window('w_address_detail')
end event

type cb_close from commandbutton within w_address_detail
integer x = 3854
integer y = 4
integer width = 142
integer height = 108
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "×"
end type

event clicked;close(parent)
end event

type dw_detail from datawindow within w_address_detail
integer width = 4014
integer height = 1728
integer taborder = 10
string dataobject = "d_address_detail"
boolean livescroll = true
end type


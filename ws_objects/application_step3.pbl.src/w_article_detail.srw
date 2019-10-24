$PBExportHeader$w_article_detail.srw
forward
global type w_article_detail from window
end type
type cb_close from commandbutton within w_article_detail
end type
type dw_detail from datawindow within w_article_detail
end type
end forward

global type w_article_detail from window
integer width = 4014
integer height = 1728
boolean border = false
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
dw_detail dw_detail
end type
global w_article_detail w_article_detail

on w_article_detail.create
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.Control[]={this.cb_close,&
this.dw_detail}
end on

on w_article_detail.destroy
destroy(this.cb_close)
destroy(this.dw_detail)
end on

event resize;dw_detail.width = workspacewidth()
dw_detail.height = workspaceheight()
cb_close.x = workspacewidth() - cb_close.width - 4
end event

type cb_close from commandbutton within w_article_detail
integer x = 2000
integer y = 4
integer width = 140
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

type dw_detail from datawindow within w_article_detail
integer width = 4023
integer height = 1732
integer taborder = 10
string dataobject = "d_article_detail"
boolean livescroll = true
end type


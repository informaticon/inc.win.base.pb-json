$PBExportHeader$w_article_list.srw
forward
global type w_article_list from window
end type
type cb_close from commandbutton within w_article_list
end type
type dw_list from datawindow within w_article_list
end type
type dw_search from datawindow within w_article_list
end type
end forward

global type w_article_list from window
integer width = 4718
integer height = 2620
boolean border = false
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
dw_list dw_list
dw_search dw_search
end type
global w_article_list w_article_list

type variables
u_data iu_data
w_article_detail iw_detail
end variables

on w_article_list.create
this.cb_close=create cb_close
this.dw_list=create dw_list
this.dw_search=create dw_search
this.Control[]={this.cb_close,&
this.dw_list,&
this.dw_search}
end on

on w_article_list.destroy
destroy(this.cb_close)
destroy(this.dw_list)
destroy(this.dw_search)
end on

event open;iu_data = create u_data

dw_search.insertrow(1)

iu_data.of_fill_article(dw_list)

// hack because I was too lazy to create a separate search dw
dw_search.modify('t_1.text="Article Search"')
end event

event resize;dw_search.width = workspacewidth()
dw_list.width = workspacewidth()
dw_list.height = workspaceheight() - dw_list.y
cb_close.x = workspacewidth() - cb_close.width - 4
end event

type cb_close from commandbutton within w_article_list
integer x = 4576
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

type dw_list from datawindow within w_article_list
integer y = 396
integer width = 4722
integer height = 2232
integer taborder = 20
string title = "none"
string dataobject = "d_article_list"
boolean livescroll = true
end type

event rowfocuschanged;selectrow(0, false)
selectrow(currentrow, true)
end event

event doubleclicked;if isvalid(iw_detail) then
	iw_detail.show()
else
	open(iw_detail)
end if
dw_list.sharedata(iw_detail.dw_detail)
iw_detail.dw_detail.scrolltorow(row)
end event

type dw_search from datawindow within w_article_list
integer width = 4727
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_address_search"
boolean livescroll = true
end type


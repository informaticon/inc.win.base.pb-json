$PBExportHeader$application_oldschool.sra
$PBExportComments$Generated Application Object
forward
global type application_oldschool from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type application_oldschool from application
string appname = "application_oldschool"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Do Not Use Themes"
long richtextedittype = 2
long richtexteditversion = 1
string richtexteditkey = ""
end type
global application_oldschool application_oldschool

on application_oldschool.create
appname="application_oldschool"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on application_oldschool.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_main)
end event


$PBExportHeader$application_step1.sra
$PBExportComments$Generated Application Object
forward
global type application_step1 from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type application_step1 from application
string appname = "application_step1"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Flat Design Informaticon"
long richtextedittype = 2
long richtexteditversion = 1
string richtexteditkey = ""
end type
global application_step1 application_step1

on application_step1.create
appname="application_step1"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on application_step1.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_main)
end event


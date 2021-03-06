#include "protheus.ch"
#include "rwmake.ch"                 
#include "tbiconn.ch"
#include "msole.ch"
/*
_________________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+---------------------------------------------------------------------------+¦¦
¦¦¦Programa  ¦ ADVPLDOC  ¦ Autor ¦ Renan Ramos              ¦ Data ¦ 19.05.16 ¦¦¦
¦¦¦----------+----------------------------------------------------------------¦¦¦
¦¦¦Descriçäo ¦ Realiza integração do Protheus com documentos Word.            ¦¦¦
¦¦+---------------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/
user function advplDoc  

local hWord 
local cTitulo1  := "Arquivo Word"
local cExtensao := "Modelo Word | *.dot | *.dotx"
local cFileOpen := ""

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
 
cFileOpen := cGetFile(cExtensao, cTitulo1,,,.T.)          
	
hWord := OLE_CreateLink()

OLE_SetProperty(hWord, oleWdVisible,   .T.)
OLE_SetProperty(hWord, oleWdPrintBack, .F.) 

OLE_NewFile(hWord, cFileOpen)

dbSelectArea("SA1")
dbSetOrder(1)                                                                                        
dbGoTop()
                                              
OLE_SetDocumentVar(hWord, "A1_COD"   ,SA1->A1_COD)
OLE_SetDocumentVar(hWord, "A1_NOME"  ,SA1->A1_NOME)
OLE_SetDocumentVar(hWord, "A1_END"   ,SA1->A1_END)
OLE_SetDocumentVar(hWord, "A1_BAIRRO",SA1->A1_BAIRRO)
OLE_SetDocumentVar(hWord, "A1_MUN"	 ,SA1->A1_MUN)
OLE_SetDocumentVar(hWord, "A1_EST"   ,SA1->A1_EST) 

OLE_UpdateFields(hWord)	
OLE_saveFile(hWord)                                
OLE_PrintFile(hWord,"ALL",,,1)

cFileSave := subStr(cFileOpen,1,At(".",trim(cFileOpen))-1)
OLE_saveAsField(hWord, cFileSave+".doc")

OLE_closeLink(hWord)

return

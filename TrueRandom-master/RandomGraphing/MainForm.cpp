//---------------------------------------------------------------------------

#include <vcl.h>
#include <stdlib.h>
#include <stdio.h>
#pragma hdrstop

#include "MainForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "PERFGRAP"
#pragma resource "*.dfm"
TForm1 *Form1;
FILE*f;
long seed;
int iterator;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
        if(_argc==2) {
                f=fopen(_argv[1],"r");
                if(f==NULL) {
                        MessageBox(this->Handle, "Please pass valid commandline argument", "Error", MB_OK);
                } else {

                        Timer1->Enabled = true;
                }
        } else {
                MessageBox(this->Handle, "Please pass valid commandline argument", "Error", MB_OK);
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Timer1Timer(TObject *Sender)
{
     if(feof(f)) {
        MessageBox(this->Handle, "Done!", "Error", MB_OK);
        Timer1->Enabled = false;
        return;
     }
     if(iterator==5000) {
        fread(&seed,sizeof(long),1,f);
        iterator=0;
     }
     seed=1103515245*seed+12345;
     RndGph->DataPoint(clWhite,seed%100);
     RndGph->Update();
     iterator++;
}
//---------------------------------------------------------------------------

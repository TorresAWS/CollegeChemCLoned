\begingroup\efdlspecials
\isdljstrue
\makeatletter
\obeyspaces\obeylines\let^^M=\jsR%
\catcode`\"=12%
\gdef\dljsjsforthoriii{%
var sndSaveWarning=\SecondSave@Msg;
var isthereCvrPg=\thIsCP;
var cvrPgNum="\thCvrPg";
function freezeQuizMU() {
var f, fname;
var bOK=true;
var f=this.getField("studentenGrade");
var str=""+f.value;
str=str.replace(/\s/g,"");
if (str=="") {
  app.alert(\MarkWarning@Msg);
  bOK=false;
}
var SolnSet=this.info.SolnSet;
if (bOK&&SolnSet!=""){
var SolnPath=this.info.SolnPath;
// var SolnSet=this.info.SolnSet;
var qzbasename=this.info.qzBaseName;
  aebTrustedFunctions(this,aebInsertPages,{
    nPage: (this.numPages-1),
    cPath: SolnPath+"/"+qzbasename+"-"+SolnSet+".pdf"
  })
};
if(\instrAutoSave&&bOK) {
//  var cSave="\jobname";
  var docFN=this.documentFileName;
  docFN=docFN.substring(0,docFN.length-4);
  var cSave=(\thUseNameToCustomize)?"\jobname":docFN;
  if(\thUseNameToCustomize) {
    var f=this.getField("Name.first");
    if(f!=null)cSave+=("-"+f.value+"_");
    f=this.getField("Name.last");
    if(f!=null)cSave+=(f.value);
    cSave+=("-g");
  }
  var oRetn=aebTrustedFunctions(this,aebBrowseForDoc,{bSave:true,%
cFilenameInit: cSave });
  bOK=(typeof oRetn=="object");
  if(bOK) {
    for (var i=0; i<this.numFields; i++) {
      fname=this.getNthFieldName(i);
      f=this.getField(fname);
      f.readonly=true;
    }
    var f=this.getField("MarkIt");
    if (f!=null)f.display=display.hidden;
    f=this.getField("freezeQz");
    if (f!=null)f.display=display.hidden;
    if(typeof _flattenThisDoc=="undefined")this.flattenPages();
    oRecordOfQuizData=undefined;
    this.info.SolnSet="";
    var retn=aebTrustedFunctions(this,aebDocSaveAs,%
{cPath:oRetn.cPath,cFS:oRetn.cFS});
  }
}
if(\instrAutoClose&&bOK) this.closeDoc(true);
}
}%
\endgroup
\begingroup 
\catcode`\<=12 
\catcode`\>=12 
\ccpdftex%
\input{dljscc.def}%
\immediate\pdfobj{ << /S/JavaScript/JS(\dljsjsforthoriii) >> }
\xdef\objjsforthoriii{\the\pdflastobj\space0 R}
\endgroup 

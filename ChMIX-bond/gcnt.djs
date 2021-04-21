\begingroup\efdlspecials
\isdljstrue
\makeatletter
\obeyspaces\obeylines\let^^M=\jsR%
\catcode`\"=12%
\gdef\dljsgcntiii{%
var _passToQuestions=false;
var oRecordOfQuizData;
var _docDevMode=\devMode;
var aQzList=new Array(\cListOfQuizNames);
var aSqList=new Array(\cListOfSQuizNames);
\jsCodeForQzs%
cntCorrectResponses.nCorrectInDoc=0;
cntCorrectResponses.nOutOfInDoc=0;
cntCorrectResponses.nPtsCorrectInDoc=0;
cntCorrectResponses.nPtsOutOfInDoc=0;
function cntCorrectResponses() {
  var f=this.getField("\eqsroot");
  if (f==null) return;
  var g=f.getArray();
  var fld1="\eqsroot.Score";
  var fld2="\eqsroot.OutOf";
  var fld3="\eqsroot.ScoreComb";
  var fld4="\eqsroot.ptScore";
  var fld5="\eqsroot.ptOutOf";
  var fld6="\eqsroot.ptScoreComb";
  cntCorrectResponses.nCorrectInDoc=0;
  cntCorrectResponses.nOutOfInDoc=0;
  cntCorrectResponses.nPtsCorrectInDoc=0;
  cntCorrectResponses.nPtsOutOfInDoc=0;
  var pos,baseName;
  for (var i=0; i<this.numFields; i++) {
    fname=this.getNthFieldName(i);
    baseName=fname+"..";
    pos=baseName.indexOf(".");
    baseName=baseName.substring(pos+1);
    pos=baseName.indexOf(".");
    baseName=baseName.substring(0,pos);
    if (aQzList.indexOf(baseName)!=-1) {
      continue;
    }
    pos=fname.indexOf(".");
    var root=fname.substring(0,pos);
    if (root=="obj"|root=="grpobj") {
      var f=this.getField(fname);
      cntCorrectResponses.nOutOfInDoc+=1;
      if (f.isCorrect==1) {
          cntCorrectResponses.nCorrectInDoc+=1;
      }
    } else if (root=="mcq"||root=="mck"){
        continue;
      } else if (fname.substring(0,2)=="mc") {
      var tst4qz="mcq"+fname.substring(2);
      var otst4qz=this.getField(tst4qz);
      if (otst4qz!=null)continue;
      var f=this.getField(fname);
      var aResults=fname.match(/\./g);
      if (aResults.length>2) {
        // multiple selection
        if (f.exportValues[0][0]==1) {
          cntCorrectResponses.nOutOfInDoc+=1;
          if (f.isBoxChecked(0)) {
            cntCorrectResponses.nCorrectInDoc+=1;
          }
        }
      } else {
        // multiple choice
        cntCorrectResponses.nOutOfInDoc+=1;
        if (f.value[0]==1) {
            cntCorrectResponses.nCorrectInDoc+=1;
        }
      }
    }
  }
  addInQuizResults();
  f=this.getField(fld1);
  if(f!=null)f.value=cntCorrectResponses.nCorrectInDoc;
  f=this.getField(fld2);
  if(f!=null)f.value=cntCorrectResponses.nOutOfInDoc
  var f=this.getField(fld3);
  if (f!=null)f.value=(\dclScorePhse(cntCorrectResponses.nCorrectInDoc)%
(cntCorrectResponses.nOutOfInDoc));
  f=this.getField(fld4);
  if(f!=null)f.value=cntCorrectResponses.nPtsCorrectInDoc;
  f=this.getField(fld5);
  if(f!=null)f.value=cntCorrectResponses.nPtsOutOfInDoc
  var f=this.getField(fld6);
  if (f!=null)
    f.value=(\dclScorePhse(cntCorrectResponses.nPtsCorrectInDoc)%
(cntCorrectResponses.nPtsOutOfInDoc));
}
function addInQuizResults() {
  var results,value,score,outof;
  cntCorrectResponses.nPtsCorrectInDoc=%
cntCorrectResponses.nCorrectInDoc;
  cntCorrectResponses.nPtsOutOfInDoc=cntCorrectResponses.nOutOfInDoc;
  for (var i=0; i<aQzList.length; i++) {
    var f=this.getField("ScoreData."+aQzList[i]);
    if (f!=null) {
      if (f.value!="") {
        aTmp=f.value.split(";");
        cntCorrectResponses.nCorrectInDoc+=(1*aTmp[0]);
        cntCorrectResponses.nOutOfInDoc+=(1*aTmp[1]);
        cntCorrectResponses.nPtsCorrectInDoc+=(1*aTmp[2]);
        cntCorrectResponses.nPtsOutOfInDoc+=(1*aTmp[3]);
      }
    }
  }
}
function clearAllSQElements() {
  var fname;
  // clear any short quizzes and any supportive elements
  for (var i=0; i<aSqList.length; i++) {
    ProcessIt = false;
    if ( typeof eval(aSqList[i])== "undefined" )
      eval(aSqList[i])= new Object();
    if (typeof appAlerts[aSqList[i]] == "undefined")
      appAlerts[aSqList[i]] = new Object();
    this.resetForm(new Array("mc."+aSqList[i],"obj."+aSqList[i],%
"tally."+aSqList[i],"grpobj."+aSqList[i]));
    var f = this.getField("obj."+aSqList[i]);
    if ( f != null ) f.strokeColor=\ifx\defaultColorJSLoc\@empty%
\defaultColorJS\else\defaultColorJSLoc\fi;
    f = this.getField("grpobj."+aSqList[i]);
    if ( f != null ) f.strokeColor=\ifx\defaultColorJSLoc\@empty%
\defaultColorJS\else\defaultColorJSLoc\fi;
    f = this.getField("rbmarkup."+aSqList[i]);
    if ( f != null ) f.display=display.hidden;
    eval(aSqList[i]).Grp = {};
    appAlerts[aSqList[i]].bAfterValue=false;
    ProcessIt=true;
  }
  isAQuizUnfinished.check=true;
  // clear any quizzes and any supportive elements
  for (var i=0; i<aQzList.length; i++) {
    InitializeQuiz(aQzList[i],1);
    aQuizControl[aQzList[i]] = 0;
  }
  this.resetForm(["\eqsroot","holdScoreData","ScoreData"]);
  oRecordOfQuizData=new Object();
}
chk4PassToQuestions.entered=false;
function chk4PassToQuestions(event) {
  if(event.willCommit) {
    if (chk4PassToQuestions.entered) {
      _passToQuestions=false;
      clearAllSQElements();
      this.dirty=false;
      return;
    }
    if(event.value!="") {
      var value=""+event.value;
      value = value.replace(/\s/g,"");
      if(value==null || value.length==0) {
        _passToQuestions=false;
        chk4PassToQuestions.entered=false;
      } else {
        _passToQuestions=true;
        chk4PassToQuestions.entered=true;
        clearAllSQElements();
        this.dirty=false;
      }
    }
  }
}
function collectQuizData() {
  var f=this.getField("holdScoreData");
  f.value=(oRecordOfQuizData.toSource());
}
restoreQuizData.hasRestoredData=false;
function restoreQuizData() {
  var f=this.getField("holdScoreData");
  try{oRecordOfQuizData=eval(f.value);}catch(e){return;}
  for (fname in oRecordOfQuizData) {
    f=this.getField(fname);
    if (typeof oRecordOfQuizData[fname]=="object") {
      // name of field is endQuiz.qzname
      var pos=fname.indexOf(".");
      var qzName=fname.substring(pos+1);
      var qzRoot=fname.substring(0,pos);
      switch(qzRoot) {
        case "ScoreData":
          lstOfQuizzes[qzName]=eval(qzName);
          Score=1*oRecordOfQuizData[fname][0];
          NQuestions=1*oRecordOfQuizData[fname][1];
          ptScore=1*oRecordOfQuizData[fname][2];
          NPointTotal=1*oRecordOfQuizData[fname][3];
          var h=this.getField("ScoreData."+qzName);
          h.value=Score+";"+NQuestions+";"+ptScore+";"+NPointTotal;
          break;
        case "ProbDist":
          ProbDist=eval(oRecordOfQuizData[fname]);
          break;
        case "RightWrong":
          RightWrong=eval(oRecordOfQuizData[fname]);
          break;
        default:
          console.println("name not recognized:"+fname);
      }
    } else f.isCorrect=oRecordOfQuizData[fname];
  }
}
function IhrNameFormat(event){
  if(event.value!="") {
    var value=""+event.value;
    value = value.replace(/\s/g,"");
    if(value==null || value.length==0) {
      _passToQuestions=false;
      chk4PassToQuestions.entered=false;
    } else {
      _passToQuestions=true;
      chk4PassToQuestions.entered=true;
      this.dirty=false;
    }
  } else {
   chk4PassToQuestions.entered=false;
   _passToQuestions=false;
  }
}
function isAQuizUnfinishedAtSave()
{
    for ( var qtfield in aQuizControl )
        if ( aQuizControl[qtfield] == 1 )
        {
            eqAppAlert(\eqerrUnfinishQuizAtSave, 3);
            return false;
        }
    return true;
}
}%
\endgroup
\begingroup 
\catcode`\<=12 
\catcode`\>=12 
\ccpdftex%
\input{dljscc.def}%
\immediate\pdfobj{ << /S/JavaScript/JS(\dljsgcntiii) >> }
\xdef\objgcntiii{\the\pdflastobj\space0 R}
\endgroup 

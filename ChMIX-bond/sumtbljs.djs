\begingroup\efdlspecials
\isdljstrue
\makeatletter
\obeyspaces\obeylines\let^^M=\jsR%
\catcode`\"=12%
\gdef\dljssumtbljsiii{%
function correctSumryTbl(qtfield,nQuestions) {
    var oQName=eval(qtfield);
    var rightColor=(typeof oQName.RightColorJSLoc=="undefined")%
?\rghtColorJS:oQName.RightColorJSLoc;
    var wrongColor=(typeof oQName.WrongColorJSLoc=="undefined")%
?\wrngColorJS:oQName.WrongColorJSLoc;
    var partialColor=(typeof oQName.PartialColorJSLoc=="undefined")%
?\partialColorJS:oQName.PartialColorJSLoc;
    var sc=this.getField(qtfield+"SanityCheck");
    var nc=this.getField(qtfield+"NoCorrections");
    if (sc != null && nc == null ) {
        for (var i=0; i<nQuestions; i++) {
            var cb=this.getField(qtfield+"SanityCheck."+(i+1));
            if (typeof RightWrong[i+1] == "undefined" ) {
                cb.strokeColor=wrongColor;
                continue;
            }
            if ( RightWrong[i+1] == 1 ) {
                cb.strokeColor=rightColor;
                continue;
            }
            if ( RightWrong[i+1] == 0 ) {
                // this is either an obj or multiple choice q
                if ( typeof ProbValue[i+1] == "object" )
                    cb.strokeColor=( ProbValue[i+1][2] > 0 )?%
partialColor:wrongColor;
                else cb.strokeColor=wrongColor; // obj q
                continue;
            }
            // either multiple selection or grouped math
            if ( RightWrong[i+1][0] == "grp" ) {
                // grouped question
                var f = this.getField("grpobj."+qtfield+"."+(i+1));
                var l = f.getArray().length;
                // is this right?
                for (var sum=0, j=1; j<=l; j++)
                    sum+=(!!RightWrong[i+1][j]);
                if ( sum == l ) cb.strokeColor=["RGB", 0, .6, 0];
                else cb.strokeColor=( sum > 0 )?%
partialColor:wrongColor;
                continue;
            }
            // multiple selection
            if ( RightWrong[i+1][0] == 1 ) cb.strokeColor=rightColor;
            else cb.strokeColor=(RightWrong[i+1][1]== 1)?%
partialColor:wrongColor;
        }
    }
    var f1=this.getField(qtfield+"SanityCheckPts");
    var f2=this.getField(qtfield+"SanityCheckOOPts");
    var h=this.getField(qtfield+"activateSC");
    if ( f1 != null ) {
        for ( var i = 1; i <= nQuestions; i++) {
            if ( ProbValue[i] == undefined ) ProbValue[i]=0
                // find the next non-null field
                var g=this.getField(qtfield+"SanityCheckPts."+i);
                var qpts=(ProbDist[i]==undefined) ? 0 : ProbDist[i];
                if ( !negPointsAllowed && (qpts < 0) ) qpts=0;
                var thesePts= qpts + (( qpts == 1 )?%
" \eqptLabel":" \eqptsLabel");
                g.value = thesePts;
        }
    }
    if ( f2 != null ) {
        for ( var i = 1; i <= nQuestions; i++) {
            if ( ProbValue[i] == undefined ) ProbValue[i]=0
                // find the next non-null field
                var g=this.getField(qtfield+"SanityCheckOOPts."+i);
                var qpts=(ProbDist[i]==undefined) ? 0 : ProbDist[i];
                if ( !negPointsAllowed && (qpts < 0) ) qpts=0;
                var ptValue = oQName.PtValues[i];
                var probPts = ptValue + (( ptValue == 1 )?%
" \eqptLabel":" \eqptsLabel");
                g.value = qpts +" \stOutOf\space"+probPts;
        }
    }
}
function popVisitsTbl(qtfield,nQuestions) {
    if ( aQuizControl[qtfield] == 1) {
        this.resetForm([qtfield+"SanityCheck"]);
        for ( var i=0; i < nQuestions; i++ ) {
            var f=this.getField(qtfield+"SanityCheck."+(i+1));
            f.checkThisBox(0,(typeof Responses[i+1]!="undefined"));
        }
    }
}
function fieldPopTbl(qtfield) {
    var f=this.getField(qtfield+"activateSC");
    if ( f != null) {
        var n=Number(f.userName);
        var a = [ qtfield, n ];
        popVisitsTbl.apply(null,a);
    }
}
}%
\endgroup
\begingroup 
\catcode`\<=12 
\catcode`\>=12 
\ccpdftex%
\input{dljscc.def}%
\immediate\pdfobj{ << /S/JavaScript/JS(\dljssumtbljsiii) >> }
\xdef\objsumtbljsiii{\the\pdflastobj\space0 R}
\endgroup 

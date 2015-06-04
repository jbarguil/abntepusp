%% $Header: /home/cvsroot/abntex/texmf/bibtex/bst/abntex/abnt-alf.bst,v 1.29 2002/11/22 18:20:32 gweber Exp $
%% name of this file abnt-num.bst
%% Copyright 2001-2002 by the abnTeX group at http://abntex.codigolivre.org.br
%%
%% This file is distributed under the LaTeXProject Public License (LPPL) http://www.latex-project.org/lppl.html
%% You are free to modify this file under the LPPL.
%%
%% This file is an *extensive* modification from a file generated with the docstrip utility.
%% The original source files were:
%% merlin.mbs  (with options: `babel,nm-revf,aunm-semi,nmlm,x3,m3,dt-end,yr-com,xmth,vnum-x,volp-com,jwdpg,jwdvol,num-xser,btit-rm,bt-rm,pg-bk,add-pub,pub-date,pub-xpar,pre-pub,isbn,issn,pp,ed,abr,ednx,nfss')
%% These sourefiles are copyrighted by Patrick W Daly
%%
ENTRY
  { address author booktitle booksubtitle chapter edition editor editortype
    dimensions furtherresp
    howpublished institution illustrated
    isbn issn journal key month note marginnote number organization
    org-short pages pagename
    publisher school
    series subtitle section title type url urlaccessdate
    volume year
    abnt-emphasize abnt-experimental abnt-full-initials abnt-ldots-type
    abnt-missing-year abnt-note abnt-repeated-field-omit
    abnt-show-options abnt-refinfo abnt-thesis-year abnt-dont-use-etal
    abnt-no-etal-label}{}{ label extra.label}

%revision string
STRINGS { abnt.bst.revision }

%general purpose strings
STRINGS { s t }

%variables needed to implement the various abnt options
STRINGS {abnt.emphasize}
INTEGERS {abnt.alf abnt.experimental abnt.full.initials abnt.ldots.type
          abnt.missing.year
          abnt.repeated.field.omit abnt.refinfo abnt.show.options
          abnt.thesis.year abnt.dont.use.etal abnt.no.etal.label}

%needed for title formatting
INTEGERS { title.lenght title.pos first.word no.bracket}
STRINGS { title.char}

%needed for controlling the sentence position
INTEGERS {output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}


%output.nonnull decides what is written before the argument s, if a comma, period etc.
FUNCTION {output.nonnull}
{ 's :=                                     %the argument is written into s
  output.state mid.sentence =
    { ", " * write$ }                       %mid.sentence first write comma
    { output.state after.block =
        { add.period$ write$ newline$ }
        { output.state before.all = 'write$
            { add.period$ " " * write$ }
          if$}
      if$
      mid.sentence 'output.state := }
  if$
  s                                         %now comes s
}
FUNCTION {output.nonnull.dash}
{ 's :=                                     %the argument is written into s
  output.state mid.sentence =
    { " --- " * write$ }                       %mid.sentence first write comma
    { output.state after.block =
        { add.period$ write$ newline$ write$}
        { output.state before.all = 'write$
            { add.period$ " " * write$ }
          if$}
      if$
      mid.sentence 'output.state := }
  if$
  s                                         %now comes s
}
FUNCTION {output}     %does nothing or calls output.nonull
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}
FUNCTION {output.dash}     %does nothing or calls output.nonull
{ duplicate$ empty$
    'pop$
    'output.nonnull.dash
  if$
}
FUNCTION {output.check}  %like ouput, but complains if t empty
{ 't :=
  duplicate$ empty$
    { pop$ "campo " t * " vazio em " * cite$ * warning$ }
    'output.nonnull
  if$
}
FUNCTION {fin.entry}
{ add.period$ write$
abnt-note empty$ 'skip$
{"\footnote{" abnt-note * "}" * write$} if$
"}" write$
newline$ }

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}
FUNCTION {add.blank} {  " " * before.all 'output.state :=}

FUNCTION {date.block} {new.block}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}
FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}
FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}
FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}
FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { abnt.emphasize "{"  * " " * swap$ * "}" * }
  if$
}


FUNCTION {same.field} { "\underline{\ \ \ \ \ \ \  \ }" }

FUNCTION {tie.or.space.prefix} %if text length less than 3 chars. uses a tie
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$
}

FUNCTION {no.space} { { "" } swap$ }


FUNCTION {space.word} { " " swap$ * " " * }

FUNCTION {bbl.and} { " e "}
FUNCTION {bbl.chapter} { "cap." }
FUNCTION {bbl.editors} { "Ed." }
FUNCTION {bbl.editor} { "Ed." }
FUNCTION {bbl.edby} { "editado por" }
FUNCTION {bbl.edition} { "ed." }
FUNCTION {bbl.empty} {""}
FUNCTION {bbl.etal}{ " et al."}
FUNCTION {bbl.in} { "In: " }
FUNCTION {bbl.ldots} %#0 use nothing, #1 use \ldots, #2 use $\ldots$, 3# use {...}
{abnt.ldots.type
  {abnt.ldots.type #1 = {"\ldots"}   'skip$ if$
   abnt.ldots.type #2 = {"$\ldots$"} 'skip$ if$
   abnt.ldots.type #3 = {"{...}"}    'skip$ if$}
  {""} %for #0 use nothing
if$}
FUNCTION {bbl.master}  { "Mestrado" }
FUNCTION {bbl.missing.year}
{abnt.missing.year
  {"[s.d.]"} %#1
  {""}       %#0
 if$}
FUNCTION {bbl.monography} { "Monografia" }
FUNCTION {bbl.mthesis} { "Disserta\c{c}\~ao" }
FUNCTION {bbl.number} { "n." }
FUNCTION {bbl.nr} { "n." }
FUNCTION {bbl.of} { "de" }
FUNCTION {bbl.phd} { "Doutorado" }
FUNCTION {bbl.phdthesis} { "Tese" }
FUNCTION {bbl.pages}
  {pagename empty$
    { "p." }
    {pagename}
   if$
   }
FUNCTION {bbl.page} { bbl.pages }
FUNCTION {bbl.semicolon} { "; "}
FUNCTION {bbl.no.address} {"[S.l.]"}
FUNCTION {bbl.no.address.no.publisher} {"[S.l.: s.n.]"}
FUNCTION {bbl.no.publisher} {"[s.n.]"}
FUNCTION {bbl.techrep} { "Rel. Tec." }
FUNCTION {bbl.url.accessdate} {"Acesso em: "}
FUNCTION {bbl.url.begin} {"Dispon{\'\i}vel em: $<$"}
FUNCTION {bbl.url.end} {"$>$"}
FUNCTION {bbl.volume} { "v." }


MACRO {jan} {"jan."}
MACRO {feb} {"fev."}
MACRO {mar} {"mar."}
MACRO {apr} {"abr."}
MACRO {may} {"maio"}
MACRO {jun} {"jun."}
MACRO {jul} {"jul."}
MACRO {aug} {"ago."}
MACRO {sep} {"set."}
MACRO {oct} {"out."}
MACRO {nov} {"nov."}
MACRO {dec} {"dez."}


FUNCTION {is.num}
{ chr.to.int$
  duplicate$ "0" chr.to.int$ < not
  swap$ "9" chr.to.int$ > not and
}
FUNCTION {bibinfo.check} %usage: field "field" bibinfo.check
{ swap$ duplicate$ missing$
    {pop$ pop$ ""}
    { duplicate$ empty$
        {swap$ pop$}
        {swap$ pop$}
      if$
    }
  if$
}
FUNCTION {bibinfo.warn}
{ swap$
  duplicate$ missing$
    {swap$ "faltando " swap$ * " em " * cite$ * warning$ pop$ ""}
    { duplicate$ empty$
        {swap$ "vazio " swap$ * " em " * cite$ * warning$}
        {swap$ pop$}
      if$
    }
  if$
}

STRINGS  { bibinfo}
INTEGERS { nameptr namesleft numnames }
FUNCTION {format.names}
{ 'bibinfo :=  duplicate$ empty$ 'skip$
  {'s := ""
   't :=
   #1 'nameptr :=  s num.names$ 'numnames :=
    numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{ll}{ jj}" format.name$ "u" change.case$
      abnt.full.initials
        {s nameptr "{, ff}{ vv}" format.name$ *}
        {s nameptr "{, f.}{ vv}" format.name$ *}
      if$
      bibinfo bibinfo.check
      't :=
      nameptr #1 >
        {nameptr #1 #1 + = numnames #3 > and
            {abnt.dont.use.etal 'skip$ {"others" 't := #1 'namesleft :=} if$ }
            'skip$
          if$
          namesleft #1 >
            { "; " * t * }
            { numnames #2 >
                { "" * }
                'skip$
              if$
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                { bbl.etal *}
                { "; " * t *}
              if$ }
          if$ }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft := }
  while$
  } if$
}
FUNCTION {format.names.ed} {format.names}

FUNCTION {format.authors} { author "author" format.names}

FUNCTION {get.bbl.editor} { editor num.names$ #1 > 'bbl.editors 'bbl.editor if$ }


FUNCTION {format.book.pages}
{ pages "pages" bibinfo.check  duplicate$ empty$
    'skip$
    {  "~" * bbl.pages * }
  if$
}
FUNCTION {format.dimensions}
{ dimensions empty$
    'skip$
    { dimensions output}
  if$
}
FUNCTION {format.furtherresp}
{ furtherresp empty$
    'skip$
    { furtherresp output}
  if$
}
FUNCTION {format.illustrated}
{ illustrated missing$
    'skip$
    {illustrated empty$
      {"il." output}
      {illustrated output}
     if$}
  if$
}
FUNCTION {format.isbn}
{ isbn "isbn" bibinfo.check duplicate$ empty$
    'skip$
    {new.block "ISBN " swap$ *}
  if$
}

FUNCTION {format.issn}
{ issn "issn" bibinfo.check
  duplicate$ empty$ 'skip$
    {new.block "ISSN " swap$ *}
  if$
}

FUNCTION {format.note}
{ note empty$
    { "" }
    { note #1 #1 substring$
      duplicate$ "{" =
        'skip$
        { output.state mid.sentence =
          { "l" }
          { "u" }
        if$
        change.case$ }
      if$
      note #2 global.max$ substring$ * "note" bibinfo.check }
  if$
}

FUNCTION {format.howpublished}
{ howpublished empty$
    { "" }
    { howpublished #1 #1 substring$
      duplicate$ "{" =
        'skip$
        { output.state mid.sentence =
          { "l" }
          { "u" }
        if$
        change.case$ }
      if$
      howpublished #2 global.max$ substring$ * "howpublished" bibinfo.check }
  if$
}


%ABNT styles require that the title acts as an author if
%typical author fields are absent. In this case the first
%word is uppercase. Our main problem is to estblishe what
%the first word actually is since portuguese uses accents.
%For example: Fun{\c c}\ão (Função) is a whole word but contains a
%space, but if we write Fun\c{c}\ão \c is converted to uppercase...
%You get the problem, don't you?
FUNCTION {format.title.as.author}
{ 's := %holds the title
  #1 'title.pos := %our position in the title
  #1 'first.word := %boolean, true if we already have the first word
  #1 'no.bracket := %boolean, false if we are inside a {}
  "" 't := %holds the first title.pos characters of the title
  {first.word}
    {s title.pos #1 substring$ 'title.char :=
      %checks if the character is a {
      title.char "{" = {#0 'no.bracket :=} 'skip$ if$
      %if we are in a bracket
      no.bracket 'skip$ {title.char "}" = {#1 'no.bracket :=} 'skip$ if$}  if$
      type$ "journalpart" =
        {title.char "." = title.char ":" = or title.char "!" = or
     title.char "," = or title.char ";" = or title.char "?" = or}
    {title.char " " =}
      if$ s t = or no.bracket and
       {#0 'first.word :=
       t title.char * "u" change.case$
       title.pos #1 + 'title.pos :=
       s title.pos global.max$ substring$ * 's :=}
       {title.pos #1 + 'title.pos := t title.char * 't :=}
     if$
     }
  while$
s
}


FUNCTION {format.title}
{author empty$ editor empty$ and organization empty$ and
  {title format.title.as.author}
  {title  duplicate$ empty$ 'skip$ { "t" change.case$} if$}
 if$
 subtitle  empty$ 'skip$ {subtitle ": " swap$ * "t" change.case$ *} if$
}

FUNCTION {n.dashify}
{
  't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {word.in} { bbl.in " " * }

FUNCTION {format.month}
{ month empty$ 'skip$
  {month "month" bibinfo.check}
  if$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
    { bbl.missing.year }
    { "existe o campo month (mês) mas não o campo year (ano) em " cite$ * warning$ month}
      if$}
    { month empty$
    'year
    { month " " * year * }
      if$}
  if$
}
FUNCTION {format.btitle}
{author empty$ editor empty$ and organization empty$ and
    {title format.title.as.author "title" bibinfo.check duplicate$ empty$ 'skip$ {} if$
    subtitle  empty$ 'skip$ {subtitle ": " swap$ * "t" change.case$ *} if$}
    {title "title" bibinfo.check emphasize duplicate$ empty$ 'skip$ {} if$
    subtitle  empty$ 'skip$ {subtitle ": " swap$ * "t" change.case$ *} if$}
if$
}
FUNCTION {either.or.check}
{ empty$
    'pop$
    { "não posso usar ambos " swap$ * " os campos em " * cite$ * warning$ }
  if$
}

FUNCTION {format.volume} %leaves formatted or empty volume on the stack
{volume duplicate$ empty$
   'skip$
   {volume #1 #1 substring$ is.num
      {bbl.volume swap$ tie.or.space.prefix * *}
      'skip$
    if$}
 if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { format.volume
      series "series" bibinfo.check
      duplicate$ empty$ 'pop$
        { swap$ bbl.of space.word * swap$
          emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.bvolume.if.no.series}
{ series empty$
    { format.bvolume }
    { "" }
  if$
}

FUNCTION {format.number}
{ number duplicate$ empty$
    'skip$
    {bbl.number swap$ tie.or.space.prefix "number" bibinfo.check * *}
  if$
}


FUNCTION {format.number.or.volume}
{number empty$
  {format.volume}
  {number} %we use the pure number here without leading "n."
 if$
}

FUNCTION {format.volume.and.number}
{format.volume output
 format.number
}

FUNCTION {format.volume.number.series}
{ number empty$ volume empty$ and
  { series empty$
    { "" }
    {" (" series "series" bibinfo.check * ")" *}
    if$}
  { series empty$
    {""} %{ format.number.or.volume }
    { " ("  series "series" bibinfo.check * ", " *
     format.number.or.volume * ")" *  }
     if$ }
  if$
}

FUNCTION {extract.num}
{ duplicate$ 't :=
  "" 's :=
  { t empty$ not }
  { t #1 #1 substring$
    t #2 global.max$ substring$ 't :=
    duplicate$ is.num
      { s swap$ * 's := }
      { pop$ "" 't := }
    if$ }
  while$
  s empty$
    'skip$
    { pop$ s }
  if$
}

FUNCTION {format.edition}
{ edition duplicate$ empty$ 'skip$
    {output.state mid.sentence = { "l" } { "t" } if$ change.case$
      "edition" bibinfo.check
    edition #1 #1 substring$ is.num {" " * bbl.edition * } 'skip$ if$}
  if$
}
INTEGERS { multiresult }
FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$ }
  while$
  multiresult
}
FUNCTION {format.pages}
{ pages duplicate$ empty$ 'skip$
    { duplicate$ multi.page.check
        { bbl.pages swap$ n.dashify}
        { bbl.page swap$ }
      if$
      tie.or.space.prefix "pages" bibinfo.check * * }
  if$
}
FUNCTION {format.journal.pages}
{ pages empty$ {""}
    { pages n.dashify bbl.pages
          swap$ tie.or.space.prefix "pages" bibinfo.check * *}
  if$
}

FUNCTION {format.url}
{ url empty$ 'skip$
    {bbl.url.begin url * bbl.url.end * output new.sentence }
  if$
 urlaccessdate duplicate$ empty$ 'skip$
    { bbl.url.accessdate swap$ *}
  if$
  "urlaccessdate" bibinfo.check output new.sentence
}


FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { bbl.chapter }
        { type "l" change.case$
          "type" bibinfo.check }
      if$
      chapter tie.or.space.prefix "chapter" bibinfo.check * *
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$ }
  if$
}

FUNCTION {format.booktitle}
{ %booktitle  duplicate$ empty$ 'skip$ { "t" change.case$ emphasize} if$
  %booksubtitle  empty$ 'skip$ {":  " booksubtitle * "t" change.case$ * "booksubtitle" bibinfo.check} if$
author empty$ editor empty$ and organization empty$ and
    {booktitle format.title.as.author "booktitle" bibinfo.check duplicate$ empty$ 'skip$ {} if$
    booksubtitle  empty$ 'skip$ {booksubtitle ": " swap$ * "t" change.case$ *} if$}
    {booktitle "booktitle" bibinfo.check emphasize duplicate$ empty$ 'skip$ {} if$
    booksubtitle  empty$ 'skip$ {booksubtitle ": " swap$ * "t" change.case$ *} if$}
if$
}
FUNCTION {format.editors}
{ editor  empty$
   {"inbook" type$ = 'same.field 'skip$ if$}
   {author empty$
    {editor "editor" format.names " (" *
     editortype empty$ {bbl.editor} {editortype} if$
     ")" * * }
    {"inbook" type$ =
      { same.field }
      {editor "editor" format.names " (" *
       editortype empty$ {bbl.editor} {editortype} if$
       ")" * *}
    if$}
   if$}
  if$
}
FUNCTION {format.in.ed.booktitle}
{ editor empty$
    {organization empty$ not author empty$ not and    %if one of two not empty
      {word.in organization "u" change.case$ *
       booktitle empty$ 'skip$ {". " format.booktitle * * } if$}
      {word.in
       organization empty$ author empty$ and 'skip$
       {"inbook" type$ = {same.field * ". " *}
       'skip$ if$ } if$
       booktitle empty$ 'skip$ {format.booktitle * } if$}
     if$}
    {word.in format.editors *
     booktitle empty$ 'skip$ {". " format.booktitle * * } if$}
  if$
}
FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "todos os campos relevantes estão vazios ou faltando em " cite$ * warning$ }
    'skip$
  if$
}
FUNCTION {format.type}
{ type "type" bibinfo.check
  duplicate$ empty$ 'skip$
    {new.block "" swap$ * }
  if$
}


FUNCTION {format.year}
{year empty$
   { "campo year vazio ou faltando em " cite$ *
    abnt.missing.year {" (vou colocar [s.d.])" *} 'skip$ if$ warning$
    abnt.missing.year {", " } {""} if$ bbl.missing.year *}
    {year "year" bibinfo.check}
if$
}

FUNCTION {format.field.address}
{ 't :=
  address empty$ organization empty$ and url empty$ and t empty$ and
    {bbl.no.address.no.publisher}
    {address empty$
      %if an url is present we don't give a missing address "[s.l.]" notice
      {url empty$  {bbl.no.address ": "} {"" ""} if$}
      {address ": "}
    if$
    t empty$
      {%if an organization is present then it is OK not to have a publisher
       organization empty$ {* bbl.no.publisher * } 'pop$ if$}
      {* t * }
     if$}
  if$
}

FUNCTION {format.address}
{address empty$
  { bbl.no.address}
  { address}
 if$
}

FUNCTION {format.publisher.address}
{ publisher "publisher" bibinfo.check format.field.address}

FUNCTION {format.publisher.address.relax}
{publisher empty$ address empty$ and {""}
 {publisher "publisher" bibinfo.check format.field.address}
if$}

FUNCTION {format.organization.address}
{ organization "organization" bibinfo.check format.field.address}

FUNCTION {format.author.or.organization}
{  author empty$
    { organization empty$ 'skip$
      { organization "u" change.case$ "organization"  bibinfo.check output}
      if$}
    { format.authors output.nonnull }
  if$
}

FUNCTION {format.author.or.editor}
{  author empty$
    { editor empty$ 'skip$
      { format.editors output.nonnull}
      if$}
    { format.authors output.nonnull }
  if$
}

FUNCTION {format.editor.or.organization}
{  editor empty$
    { organization empty$ 'skip$
      { organization "u" change.case$ "organization"  bibinfo.check output}
      if$}
    { format.editors output.nonnull }
  if$
}

FUNCTION {format.author.or.editor.or.organization}
{ author empty$
    { editor empty$
        { organization empty$
        'skip$
            { organization "u" change.case$ "organization"  bibinfo.check output}
          if$}
        { format.editors output.nonnull }
      if$}
    { format.authors output.nonnull }
  if$
}


FUNCTION {format.names.for.label1} %abnt-alf only
{ 's := "" 't :=
   #1 'nameptr :=  s num.names$ 'numnames :=
    numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll}{ jj}" format.name$ 't :=
      nameptr #1 >
        {namesleft #1 >
            { numnames #3 > {#0 'namesleft := bbl.etal *} {", " * t * } if$ }
            { t "others" =
          {abnt.no.etal.label 'skip$ {bbl.etal *} if$}
          {numnames nameptr = { bbl.and * t *} 'skip$ if$}
             if$
         }
          if$ }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft := }
  while$
}
FUNCTION {format.names.for.label2} %abnt-alf only
{ 's := "" 't :=
   #1 'nameptr :=  s num.names$ 'numnames :=
    numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll}{ jj}" format.name$ "u" change.case$ 't :=
      nameptr #1 >
        {namesleft #1 >
            { numnames #3 > {#0 'namesleft := bbl.etal *} {"; " * t * } if$ }
            { t "OTHERS" =
          {abnt.no.etal.label 'skip$ {bbl.etal *} if$}
          {numnames nameptr = { bbl.semicolon * t *} 'skip$ if$}
             if$
         }
          if$ }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft := }
  while$
}
FUNCTION {format.names.for.label} %abnt-alf only
{  's :=
   s #1 "{ll}{ jj}" format.name$ }

FUNCTION {format.title.for.label}
{  's :=
  #1 'title.pos :=   #1 'first.word :=
  "" 't :=
  {first.word}
    {s title.pos #1 substring$ 'title.char :=
        title.char "." = title.char ":" = or title.char ";" = or
    title.char "," = or title.char " " = or s t = or
       {#0 'first.word :=
       title.pos #1 + 'title.pos :=}
       {title.pos #1 + 'title.pos := t title.char * 't :=}
     if$
     }
  while$
s t = %title equals first word, dont use bbl.ldots
  {t  "}{" * t "u" change.case$ * }
  {t bbl.ldots * "}{" * t "u" change.case$ * bbl.ldots *}
if$
}

%cvs keys have the general form $key: value $
INTEGERS {key.pos value.pos}
FUNCTION {extract.cvs.key} %we borrow the functionality of format.title.for.label
{ 's := %holds the entire cvs string
  #1 'key.pos :=
  #0 'value.pos := %0= between first $ and :, 1=between : and second $, 2= at the end
  "" 't := %holds the resulting value
  {value.pos #0 = value.pos #1 = or}
    { s key.pos #1 substring$ 'title.char :=
      value.pos #0 =
      { title.char ":" = {#1 'value.pos := key.pos #1 + 'key.pos :=} 'skip$ if$}
      { title.char "$" =
        {#2 'value.pos :=}
        {t title.char * 't :=}
    if$}
     if$
     key.pos #1 + 'key.pos :=
     }
  while$
  t
}

%generates and extended label of type {Author}{AUTHOR}{YEAR}
%final result is placed into variable label
FUNCTION {calc.extended.label}
{ "{"
  author empty$ not
    {author format.names.for.label1 * "}{" *  author format.names.for.label2 *}
    {editor empty$ not
     {editor format.names.for.label1 * "}{" *  editor format.names.for.label2 *}
     {org-short empty$ not
      {org-short * "}{" * org-short "u" change.case$ *}
      {organization empty$ not
       {organization * "}{" * organization "u" change.case$ *}
        {title empty$ not
         {title format.title.for.label *}
         {"nada}{NADA" *}
       if$}
      if$}
     if$}
    if$}
   if$
 "}{" *
 year empty$ 'skip$ {year *} if$
 'label := %place the stack into label
 % final } will be placed in reverse.pass
}
%generates and simple label of type "Author YEAR"
%final result is placed onto the stack
FUNCTION {calc.simple.label}
{ author empty$ not
    {author format.names.for.label1}
    {editor empty$ not
     {editor format.names.for.label1}
     {organization empty$ not
      {organization}
      {title empty$ not
       {title}
       {""}
      if$}
     if$}
    if$}
   if$
 year empty$ 'skip$ {" " * year *} if$
}

FUNCTION {output.bibitem}
{ newline$
  abnt.alf
  {"\bibitem[" write$
  calc.simple.label
  write$ "]{"}
  {"\bibitem{"}
  if$
  write$ cite$ write$ "}" write$ newline$
  abnt.refinfo #1 = {"\abntrefinfo" write$ label write$ newline$} 'skip$ if$
  "{" write$
  "" before.all 'output.state :=
}

FUNCTION { abnt.display.options}
{ 's := 't :=
  abnt.show.options #1 = % "warn"
  {"opção " t * " passou para " * s * warning$ } 'skip$ if$

  abnt.show.options #2 = % "list"
  {"Op\c c\~ao selecionada {\tt " t * "=}\verb+" * s * "+" * output new.sentence } 'skip$ if$
}

FUNCTION { abnt-options }
  {
    abnt-show-options empty$
    'skip$
      {abnt-show-options "no" =
        {#0} {abnt-show-options "warn" =
           {#1} {abnt-show-options "list" =
             {#2 } {#0 } if$} if$} if$
      'abnt.show.options :=} % #0 "no"; #1 "warn"; #2 "list"
    if$

    abnt.show.options #2 =
    {output.bibitem "Mudan\c ca de estilo ap\'os este ponto com o comando \verb!\citeoption{"
    cite$ * "}! " *
    output new.sentence} 'skip$ if$

    abnt-show-options empty$
    'skip$ {"abnt-show-options" abnt-show-options abnt.display.options} if$

    abnt-experimental empty$
    'skip$ {abnt-experimental "yes" = 'abnt.experimental :=
    "abnt-experimental" abnt-experimental abnt.display.options} if$

    abnt-emphasize duplicate$ empty$
    'pop$ {'abnt.emphasize :=
    "abnt-emphasize" abnt.emphasize abnt.display.options
    abnt-emphasize "\bf" = abnt-emphasize "\it" = or abnt-emphasize "\em" = or
    abnt-emphasize "\bfseries" = or
      {"não use " abnt-emphasize * " para abnt-emphasize em " * cite$ *
      ", isto alterará TODO o texto. Use \textbf ou \emph. Veja a documentação abnt-bibtex-doc para mais detalhes." * warning$}
    'skip$ if$
    } if$

    %abnt-repeated-field-omit duplicate$ empty$ 'pop$ {'abnt.repeated.field.omit :=} if$

    abnt-full-initials empty$
    'skip$ {abnt-full-initials "yes" = 'abnt.full.initials :=
    "abnt-full-initials" abnt-full-initials abnt.display.options} if$

    abnt-ldots-type empty$
      'skip$
      {abnt-ldots-type "none" =   {#0}
        {abnt-ldots-type "normal" = {#1}
          {abnt-ldots-type "math" =   {#2}
            {abnt-ldots-type "text" =   {#1} {#0}
        if$} if$} if$} if$
       'abnt.ldots.type :=
       "abnt-ldots-type" abnt-ldots-type abnt.display.options}
    if$

    abnt-missing-year empty$
      'skip$
      {abnt-missing-year "void" = {#0}
    {abnt-missing-year "sd" = {#1} {#0} if$}
       if$
       'abnt.missing.year :=
       "abnt-missing-year" abnt-missing-year abnt.display.options}
    if$


    abnt-thesis-year empty$
    'skip$ {abnt-thesis-year "final" =
              {#0} {abnt-thesis-year "title" =
                {#1} {abnt-thesis-year "both" =
                  {#2} {#0} if$} if$} if$
            'abnt.thesis.year :=
      "abnt-thesis-year" abnt-thesis-year abnt.display.options}
    if$

    abnt-refinfo empty$
    'skip$ {abnt-refinfo "yes" = 'abnt.refinfo :=
    "abnt-refinfo" abnt-refinfo abnt.display.options} if$

    abnt-dont-use-etal empty$
    'skip$ {abnt-dont-use-etal "yes" = 'abnt.dont.use.etal :=
    "abnt-dont-use-etal" abnt-dont-use-etal abnt.display.options} if$

    abnt-no-etal-label empty$
    'skip$ {abnt-no-etal-label "yes" = 'abnt.no.etal.label :=
    "abnt-no-etal-label" abnt-no-etal-label abnt.display.options} if$

  abnt.show.options #2 = 'fin.entry  'skip$ if$
  }

FUNCTION {article}
{ output.bibitem
  format.author.or.organization  new.sentence
  format.title "title" output.check new.block
  journal "journal" bibinfo.check emphasize "journal" output.check
  section "section" bibinfo.check output.dash
  publisher "publisher" bibinfo.check output
  address "address" bibinfo.check output
  format.volume output
  format.number output
  format.pages output
  format.date output
  format.issn output new.block
  format.note output new.block
  format.url
  fin.entry
}
FUNCTION {book}
{ output.bibitem
  format.author.or.editor.or.organization new.sentence
  format.type output new.sentence
  format.btitle "title" output.check new.sentence
  format.furtherresp new.sentence
  format.edition output new.sentence
  format.publisher.address output
  format.year output new.sentence
  format.book.pages output
  format.illustrated
  format.dimensions  new.sentence
  format.volume.number.series output new.sentence
  format.note output
  format.issn output %pode parecer curioso, mas revistas inteiras são tratadas como livro
  format.isbn output new.sentence
  format.url
  fin.entry
}
FUNCTION {booklet}
{ output.bibitem
  format.author.or.editor.or.organization new.sentence
  format.type output new.sentence
  format.btitle "title" output.check new.sentence
  format.edition output new.sentence
  address "address" bibinfo.check output
  format.bvolume output
  format.date output  new.sentence
  format.book.pages output new.sentence
  format.volume.number.series output new.sentence
  format.note output
  format.isbn output new.sentence
  format.url
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  format.author.or.organization
  new.sentence
  format.title "title" output.check new.block
  format.in.ed.booktitle "booktitle" output.check new.sentence
  format.furtherresp new.sentence
  format.edition output new.sentence
  format.publisher.address output
  format.year output new.sentence
  format.bvolume.if.no.series output
  format.volume.number.series output
  format.chapter.pages output new.sentence
  format.isbn output new.block
  format.note output new.block
  format.url
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.author.or.organization new.sentence
  format.title "title" output.check new.sentence
  format.in.ed.booktitle "booktitle" output.check new.sentence
  format.edition output new.sentence
  format.publisher.address output
  format.year output
  format.volume.number.series output new.sentence
  format.bvolume.if.no.series output
  format.chapter.pages output new.sentence
  format.isbn output new.block
  format.note output new.block
  format.url
  fin.entry
}
FUNCTION {inproceedings}
{ output.bibitem
  format.author.or.organization new.sentence
  format.title "title" output.check  new.sentence
  format.in.ed.booktitle "booktitle" output.check new.sentence
  format.publisher.address output
  format.year output new.sentence
  format.bvolume.if.no.series output
  format.volume.number.series output
  format.pages output
  format.isbn output
  format.issn output new.sentence
  format.note output new.sentence
  format.url
  fin.entry
}
FUNCTION {journalpart}
{ output.bibitem
  format.author.or.editor.or.organization new.sentence
  format.type output new.sentence
  format.btitle "title" output.check new.sentence
  format.furtherresp new.sentence
  format.edition output new.sentence
  format.publisher.address output
  format.volume output
  format.number output
  format.date output new.sentence
  format.pages output
  format.illustrated
  format.dimensions  new.sentence
  format.note output
  format.issn output %pode parecer curioso, mas revistas inteiras são tratadas como livro
  format.isbn output new.sentence
  format.url
  fin.entry
}
FUNCTION {conference} { inproceedings }
FUNCTION {manual}
{ output.bibitem
  format.author.or.editor.or.organization new.sentence
  format.btitle "title" output.check new.block
  format.edition output new.sentence
  format.address output
  format.date output new.sentence
  format.bvolume.if.no.series output
  format.book.pages output new.sentence
  format.volume.number.series output new.sentence
  format.note output new.sentence
  format.url
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.author.or.editor.or.organization new.sentence
  format.type output
  format.btitle output new.sentence
  format.furtherresp new.sentence
  format.publisher.address.relax output
  format.date output  new.block
  format.book.pages output new.sentence
  format.illustrated
  format.dimensions  new.sentence
  format.howpublished output  new.block
  format.volume.number.series output new.sentence
  format.note output  new.block
  format.url
  fin.entry
  empty.misc.check
}

FUNCTION {format.thesis.type}
{ type$ "phdthesis" =
    {bbl.phdthesis}
    {type$ "mastersthesis" =
       {bbl.mthesis}
       {type$ "monography" =
          {bbl.monography}
      'skip$
        if$}
     if$}
  if$
  type empty$
    {type missing$
       {type$ "phdthesis" =
          { " (" bbl.phd * ")" *}
          {type$ "mastersthesis" = { " (" bbl.master * ")" *} {pop$ ""} if$}
        if$}
       {""}
     if$}
    {" (" type  * ")" * "type" bibinfo.check}
  if$
 * %joins first and second part of this function
}
FUNCTION {thesis}
{ output.bibitem
  format.authors "author" output.check new.block
  format.btitle "title" output.check new.block
  abnt.thesis.year #1 = abnt.thesis.year #2 = or
    {format.date "year" output.check new.sentence} 'skip$ if$
  format.book.pages output new.sentence
  format.thesis.type output.nonnull
  school "school" bibinfo.warn output.dash
  address "address" bibinfo.check output
  abnt.thesis.year #0 = abnt.thesis.year #2 = or
    {format.date "year" output.check new.sentence} 'skip$ if$
  format.note output new.block
  format.url
  fin.entry
}

FUNCTION {phdthesis}     { thesis }
FUNCTION {mastersthesis} { thesis }
FUNCTION {monography}    { thesis }

FUNCTION {proceedings}
{ output.bibitem
  format.editor.or.organization new.sentence
  format.btitle "title" output.check
  format.bvolume output
  format.volume.number.series output
  editor empty$
    { publisher empty$
        'skip$
        { new.sentence format.publisher.address output format.year output}
      if$
    }
    { publisher empty$
        { new.sentence
          format.organization.address output format.year output}
        { new.sentence
          organization "organization" bibinfo.check output
          format.publisher.address output format.year output}
      if$ }
  if$
  new.sentence format.book.pages output new.sentence
  format.isbn output
  format.issn output  new.block
  format.note output  new.block
  format.url
  fin.entry
}

FUNCTION {techreport} {manual}

FUNCTION {unpublished}
{ output.bibitem
  format.author.or.editor.or.organization new.sentence
  format.title "title" output.check  new.sentence
  format.note "note" output.check  new.sentence
  format.date output new.sentence
  format.url
  fin.entry
}

FUNCTION {default.type} { misc }
READ
FUNCTION {sortify}
{ purify$
  "l" change.case$
}
INTEGERS { len }
FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}
FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      abnt.full.initials
        {"{ll{ }}{  jj{ }}{  ff{ }}{vv{ } }"}
        {"{ll{ }}{  jj{ }}{  f.{ }}{vv{ } }"}
      if$
      format.name$ 't :=
      nameptr #1 >
        {
          nameptr #3
          #1 + =
          numnames #3
          > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          "   "  *
          namesleft #1 = t "others" = and
            { "zzzzz" * }
            { t sortify * }
          if$
        }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}
FUNCTION {any.sort}
{ author empty$
  { organization empty$
    { editor empty$
      { title empty$
        { key empty$
          { "para ordenar, precisa dos campos author, organization, editor, title ou key in " cite$ * warning$ ""}
          { key sortify }
        if$}
        { title sortify}
      if$}
      { editor sort.format.names }
    if$}
    { organization sortify }
  if$}
  { author sort.format.names }
if$
}

FUNCTION {presort}
{ any.sort
  "    " * year field.or.null sortify * "    " * title field.or.null
  sort.format.title * #1 entry.max$ substring$
  'sort.key$ :=
  calc.extended.label
}

FUNCTION {set.default.abnt.variables}
{ %if you change abnt-num to abnt-alf by hand you need also to change
  %the name of RCSfile by hand, otherwise cvs takes care of it.
  "$RCSfile: abnt-alf.bst,v $ " extract.cvs.key
  "abnt-alf.bst,v " = 'abnt.alf := % #1 para abnt-alf #0 para abnt-num
  "$Revision: 1.29 $" extract.cvs.key 'abnt.bst.revision :=
  "\emph" 'abnt.emphasize :=
  #0 'abnt.experimental :=
  #0 'abnt.full.initials :=
  #1 'abnt.ldots.type := %#0 use nothing, #1 use \ldots, #2 use $\ldots$, 3# use {...}
  #0 'abnt.missing.year := %#0 "void"; #1 "[s.d.]"
  #0 'abnt.repeated.field.omit :=
  #1 'abnt.refinfo :=
  #0 'abnt.show.options := % #0 "no"; #1 "warn"; #2 "list"
  #0 'abnt.thesis.year :=  % #0 "final"; #1 "title"; #2 "both"
  #1 'abnt.dont.use.etal :=
  #0 'abnt.no.etal.label := % #0 use etal in label; #1 don't use it
}
EXECUTE {set.default.abnt.variables}
FUNCTION {process.early.abnt.options}
{%here we intercept any entry with abnt-lodts-type field,
 %we cannot use type$ at this point
 abnt-ldots-type missing$
 abnt-experimental missing$ and
 abnt-no-etal-label missing$ and
'skip$ {call.type$} if$
}
ITERATE {process.early.abnt.options}
ITERATE {presort}
%abnt-alf: for sorting uncomment the following line
SORT
STRINGS { last.label next.extra}
INTEGERS { last.extra.num }
FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * 'label :=
  extra.label 'next.extra :=
  label "}" * 'label :=
}
ITERATE {forward.pass}
REVERSE {reverse.pass}
FUNCTION {begin.bib}
{
  abnt.alf
    {"\setlength{\labelsep}{0pt}" write$}
    'skip$
  if$
  "\begin{thebibliography}{}" write$ newline$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  abnt.refinfo #1 =
  {"\providecommand{\abntrefinfo}[3]{}" write$ newline$}
  'skip$ if$
  "\providecommand{\abntbstabout}[1]{}" write$ newline$
  "\abntbstabout{" abnt.bst.revision * "}" * write$ newline$
  %Se você não usa abntcite e precisa que a margem direita não
  %seja justificada, descomente a linha seguinte
  %alternativamente coloque \bibligraphy{abnt-nrj,...
%  "\setlength{\rightskip}{0pt plus 2cm}" write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
FUNCTION {process.entry}{call.type$}
ITERATE {process.entry}
FUNCTION {end.bib}
{ newline$ "\end{thebibliography}" write$ newline$
"Aviso: Este estilo está em desenvolvimento." warning$
"Caso tenha problemas procure por http://abntex.codigolivre.org.br" warning$
}
EXECUTE {end.bib}

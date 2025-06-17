/-  *links
/+  dbug, default-agent, server, schooner
/*  ui  %html  /app/links/html
::
|%
+$  versioned-state  $%(state-0)
+$  state-0  [%0 links=(list link)]
+$  card  card:agent:gall
--
::
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
::
=<
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %|) bowl)
    hc   ~(. +> [bowl ~])
::
++  on-init
  ^-  (quip card _this)
  =^  cards  state  abet:init:hc
  [cards this]
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  [~ this(state !<(state-0 vase))]
::
++  on-poke
  |=  =cage
  ^-  (quip card _this)
  =^  cards  state  abet:(poke:hc cage)
  [cards this]
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  [~ ~]
      [%y %links %html ~]
    :-  ~
    :-  ~
    :-  %noun
    !>
    %-  crip
    %-  en-xml:html
    ;html
      ;body
        ;div
          ;*  %+  turn 
                links 
              |=  [url=@t text=@t image-url=@t] 
              ;p: {(trip text)}
        ==
      ==
    ==
  ==
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  `this
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  `this
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  =^  cards  state  abet:(watch:hc path)
  [cards this]
::
++  on-fail   on-fail:def
++  on-leave  on-leave:def
--
::
|_  [=bowl:gall deck=(list card)]
+*  that  .
::
++  emit  |=(=card that(deck [card deck]))
++  emil  |=(lac=(list card) that(deck (welp lac deck)))
++  abet  ^-((quip card _state) [(flop deck) state])
::
++  init
  ^+  that
  %-  emit
  :*  %pass   /eyre/connect   
      %arvo  %e  %connect
      `/links  %links
  ==
::
++  watch
  |=  =path
  ^+  that
  ?+    path  that
      [%http-response *]
    that
  ==
:: 
++  poke
  |=  =cage
  ^+  that
  ?+    -.cage  !!
      %handle-http-request
    (handle-http !<([@ta =inbound-request:eyre] +.cage))
      %links-action
    (handle-action !<(action +.cage))
  ==
::
++  handle-action
  |=  act=action
  ^+  that
  ?-    -.act
      %new
    that(links [link.act links])
  ::
      %delete
    that(links (oust [index.act 1] links))
  ::
      %reorder
    =/  link  (snag current.act links)
    =.  links  (oust [current.act 1] links)
    =.  links  (into links new.act link)
    that
  ==
::
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^+  that
  =/  ,request-line:server
    (parse-request-line:server url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ::
  ?+    method.request.inbound-request
    (emil (flop (send [405 ~ [%stock ~]])))
    ::
      %'POST'
    ?~  body.request.inbound-request  !!
    =/  json  (de:json:html q.u.body.request.inbound-request)
    =/  act  (dejs-action +.json)
    =.  that  (handle-action act)
    %-  emil  %-  flop  %-  send
    [200 ~ [%json enjs-links]]
    ::
      %'GET'
    %-  emil  %-  flop  %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%links ~]
      [200 ~ [%html ui]]
    ::
        [%links %state ~]
      [200 ~ [%json enjs-links]]
    ==
  ==
::
++  enjs-links
  =,  enjs:format
  ^-  json
  %-  pairs
  :~  [%authed [%b =(src.bowl our.bowl)]]
      :-  %links
      :-  %a
      %+  turn
        links
      |=  =link
      %-  pairs
      :~  [%url [%s url.link]]
          [%text [%s text.link]]
          [%image-url [%s image-url.link]]
      ==
  ==
::
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action
  %.  jon
  %-  of
  :~  [%new (ot ~[url+so text+so image-url+so])]
      [%delete (ot ~[index+ni])]
      [%reorder (ot ~[current+ni new+ni])]
  ==
--

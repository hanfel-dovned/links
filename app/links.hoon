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
      [%y %links ~]
    :-  ~
    :-  ~
    :-  %noun
    !>
    %-  crip
    %-  en-xml:html
    ;html
      ;head
        ;style: {style}
      ==
      ;body
        ;div.link-container
          ;*
          %+  turn 
            links
          |=  [url=@t text=@t image-url=@t] 
          ;div.link-card
            ;div.link-image-container
              ;+  =/  source  (trip image-url)
                  ;img(src source);
            ==
            ;div.link-details
              ;+  =/  link  (trip url)
                  ;a
                    =href  "test"
                    =target  "_blank"
                    ; {(trip text)}
                  ==
              ;span:  {(trip url)}
            ==
          ==
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
  %-  emil
  :~  :*  %pass   /eyre/connect   
          %arvo  %e  %connect
          `/links  %links
      ==
  ::
      :*  %pass  /ai-docs  %agent
          [our.bowl %scrai]  %poke
          %scrai-action  !>([%set-docs ai-docs])
      ==
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
::
++  ai-docs
  '''
   %links

  An Urbit app that lets you host a page of links from your ship.

  Has the following type definitions:
  
  |%
  +$  link  [url=@t text=@t image-url=@t]
  +$  action  
    $%  [%new =link]
        [%delete index=@ud]
        [%reorder current=@ud new=@ud]
    ==
  --

  So, examples of the cards that you can send will be:
  
  [%pass /ai %agent [our.bowl %links] %poke %links-action !>([%new 'http://google.com' 'Google' 'http://google.com/google-logo'])]
  Adds a link to the user's links.

  We won't implement the delete and reorder actions right now.
  
  Scry paths:

  /~/links/~/links
  
  Get a list of the user's links
  
  --------
  '''
::
++  style
  ^~
  %-  trip
  '''

    .links-container {
      display: flex;
      flex-direction: column;
      align-items: stretch;
      width: 90%;
      max-width: 600px;
      margin-top: 20px;
    }

    .link-card {
      display: flex;
      flex-direction: row;
      align-items: center;
      background: #ffffff;
      margin: 10px 0;
      padding: 15px;
      border-radius: 8px;
      border: 2px solid #000000;
      position: relative;
      transition: box-shadow 0.2s ease;
    }

    .link-card:hover {
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .link-image-container {
      width: 60px;
      height: 60px;
      border-radius: 8px;
      border: 1px solid #000000;
      margin-right: 15px;
      flex-shrink: 0;
      background-color: #eee;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .link-image-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
    }

    .link-details {
      display: flex;
      flex-direction: column;
      flex: 1;
    }

    .link-details a {
      font-size: 20px;
      color: #000;
      text-decoration: none;
      font-weight: bold;
      margin-bottom: 5px;
      word-break: break-all;
      transition: color 0.2s ease;
    }

    .link-details a:hover {
      color: #2575fc;
    }

    .link-details span {
      font-size: 14px;
      color: #555;
      word-break: break-all;
    }
  '''
--

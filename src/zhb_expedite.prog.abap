*&---------------------------------------------------------------------*
*& Report  ZHB_EXPEDITE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZHB_EXPEDITE.

data: wf_user type string .
data: wf_password type string .

data: rlength type i,
      txlen type string  .

data: http_client type ref to if_http_client .

data: wf_string type string .
data: wf_string1 type string .

data: wf_proxy type string ,
      wf_port type string .

selection-screen: begin of block a with frame .
parameters: crcard(16) type c lower case default '4242424242424242',
            cvn(4)     type c lower case default '564',
            year(2)    type c lower case default '07',
            month(2)   type c lower case default '11',
            amount(10) type c lower case default '100.00',
            cukey(4)   type c lower case default 'AUD',
            order(10)  type c lower case default 'AB1322-refund'.

selection-screen skip 1.
parameters: user(50) lower case,
            password(50) lower case ,
            p_proxy(100) lower case default '' ,
            p_port(4) default ''.

selection-screen: end of block a .

at selection-screen output.

  loop at screen.
    if screen-name = 'PASSWORD'.
      screen-invisible = '1'.
      modify screen.
    endif.
  endloop.

start-of-selection .


  clear wf_string .

  concatenate

  'order.type=capture&customer.username=SOMEUSER'
  '&customer.password=SOMEPASSWORD'
  '&customer.merchant=SOMEMERCHANT'
  '&card.PAN=' crcard
  '&card.CVN=' cvn
  '&card.expiryYear=' year
  '&card.expiryMonth=' month
  '&order.amount=' amount
  '&customer.orderNumber=' order
  '&card.currency=' cukey
  '&order.ECI=IVR'
  '&customer.captureOrderNumber=' order
  '&order.priority=1'
  '&message.end=null'

  into wf_string .

  break-point.

  clear :rlength , txlen .
  rlength = strlen( wf_string ) .
  move: rlength to txlen .

  clear: wf_proxy, wf_port .

  move: p_proxy to wf_proxy ,
        p_port to wf_port .

  call method cl_http_client=>create
    exporting
      host          = 'api.somewhere.com'
      service       = '80'
      scheme        = '2'                        "https
      proxy_host    = wf_proxy
      proxy_service = wf_port
    importing
      client        = http_client.

  http_client->propertytype_logon_popup = http_client->co_disabled.

  wf_user = user .
  wf_password = password .

* proxy server authentication
  call method http_client->authenticate
    exporting
      proxy_authentication = 'X'
      username             = wf_user
      password             = wf_password.

  call method http_client->request->set_header_field
    exporting
      name  = '~request_method'
      value = 'POST'.

  call method http_client->request->set_header_field
    exporting
      name  = '~server_protocol'
      value = 'HTTPS/1.0'.

  call method http_client->request->set_header_field
    exporting
      name  = '~request_uri'
      value = '/post/CreditCardAPIReceiver'.

  call method http_client->request->set_header_field
    exporting
      name  = 'Content-Type'
      value = 'application/x-www-form-urlencoded; charset=UTF-8'.

  call method http_client->request->set_header_field
    exporting
      name  = 'Content-Length'
      value = txlen.

  call method http_client->request->set_header_field
    exporting
      name  = 'HOST'
      value = 'api.somewhere.com:80'.

  call method http_client->request->set_cdata
    exporting
      data   = wf_string
      offset = 0
      length = rlength.

  call method http_client->send
    exceptions
      http_communication_failure = 1
      http_invalid_state         = 2.

  call method http_client->receive
    exceptions
      http_communication_failure = 1
      http_invalid_state         = 2
      http_processing_failed     = 3.

  if sy-subrc <> 0.
    message e000(oo) with 'Processing failed !'.
  endif.

  clear wf_string1 .

  wf_string1 = http_client->response->get_cdata( ).

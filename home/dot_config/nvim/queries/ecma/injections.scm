; extends

; /* html */ `<html>`
; /* sql */ `SELECT * FROM foo`
; (variable_declarator
;   (comment) @injection.language (#offset! @injection.language 0 3 0 -3)
;   (template_string) @injection.content (#offset! @injection.content 0 1 0 -1)
;   (#set! injection.include-children)
;   )

; foo(/* html */ `<span>`)
; foo(/* sql */ `SELECT * FROM foo`)
; (call_expression
;   arguments: [
;     (arguments
;       (comment) @injection.language (#offset! @injection.language 0 3 0 -3)
;       (template_string) @injection.content (#offset! @injection.content 0 1 0 -1))
;   ]
;   (#set! injection.include-children))

; pg: pool.query(`<sql>`)
(call_expression
  function:(member_expression
    object: (identifier) @_obj (#eq? @_obj "pool")
    property: (property_identifier) @_prop (#eq? @_prop "query"))
  arguments: (arguments
    (template_string) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "sql"))

; pg: await pool.query(`<sql>`)
(call_expression
  function:(await_expression
    (member_expression
      object: (identifier) @_obj (#eq? @_obj "pool")
      property: (property_identifier) @_prop (#eq? @_prop "query")))
  arguments: (arguments
    (template_string) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "sql"))

